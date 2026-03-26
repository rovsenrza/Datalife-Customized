<?php
/*
=====================================================
 DataLife Engine - by SoftNews Media Group 
-----------------------------------------------------
 https://dle-news.ru/
-----------------------------------------------------
 Copyright (c) 2004-2025 SoftNews Media Group
=====================================================
 This code is protected by copyright
=====================================================
 File: google.class.php
-----------------------------------------------------
 Use: Google Sitemap
=====================================================
*/

include_once ENGINE_DIR . '/classes/composer/vendor/autoload.php';

use Melbahja\Seo\Sitemap;
use Melbahja\Seo\Factory;

if( !defined( 'DATALIFEENGINE' ) ) {
	header( "HTTP/1.1 403 Forbidden" );
	header ( 'Location: ../../' );
	die( "Hacking attempt!" );
}

class googlemap {
	
	public $allow_url = "";
	public $home = "";
	public $limit = 0;
	
	public $news_priority = "";
	public $stat_priority = "";
	public $cat_priority = "";
	
	public $news_changefreq = "";
	public $stat_changefreq = "";
	public $cat_changefreq = "";
	
	public $priority = "0.6";
	public $changefreq = "daily";
	
	public $set_images = false;

	public $news_per_file = 40000;
	
	public  $sitemap = null;
	private $db_result = null;
	private $allow_tags = null;

	private $googlenews = array();
	private $languages = array();
	private $post_i18n_has_alt_name = null;

	
	function __construct($config) {

		if (file_exists(ENGINE_DIR . '/inc/multilanguage.php')) {
			include_once ENGINE_DIR . '/inc/multilanguage.php';
		}
		
		if (strpos($config['http_home_url'], "//") === 0) $config['http_home_url'] = "https:".$config['http_home_url'];
		elseif (strpos($config['http_home_url'], "/") === 0) $config['http_home_url'] = "https://".$_SERVER['HTTP_HOST'].$config['http_home_url'];

		$config['http_home_url'] = preg_replace('#/(az|en|ru)/$#i', '/', $config['http_home_url']);

		$this->allow_url = $config['allow_alt_url'];
		$this->home = $config['http_home_url'];
		$this->limit = $config['sitemap_limit'];
		$this->news_per_file = $config['sitemap_news_per_file'];
		$this->allow_tags = $config['allow_tags'];

		$this->news_priority = $config['sitemap_news_priority'];
		$this->stat_priority = $config['sitemap_stat_priority'];
		$this->cat_priority = $config['sitemap_cat_priority'];
		
		if( $config['sitemap_set_images'] ) $this->set_images = true;

		$this->news_changefreq = $config['sitemap_news_changefreq'];
		$this->stat_changefreq = $config['sitemap_stat_changefreq'];
		$this->cat_changefreq = $config['sitemap_cat_changefreq'];
		
		$this->sitemap = new Sitemap($this->home);
		$this->sitemap->setSavePath(ROOT_DIR. '/uploads');
		
		if( $this->allow_url ) {
			$this->sitemap->setSitemapsUrl($this->home);
		} else {
			$this->sitemap->setSitemapsUrl($this->home.'uploads');
		}

		$this->sitemap->setIndexName('sitemap.xml');
		$this->languages = $this->get_supported_languages();

	}

	private function get_supported_languages() {
		$result = array();

		if (function_exists('dle_ml_get_languages')) {
			$langs = dle_ml_get_languages();
			if (is_array($langs)) {
				foreach ($langs as $folder => $meta) {
					$code = isset($meta['code']) ? trim((string)$meta['code']) : '';
					if (!$code) $code = substr(strtolower($folder), 0, 2);
					$result[] = array('folder' => $folder, 'code' => $code);
				}
			}
		}

		if (!count($result)) {
			$result = array(
				array('folder' => 'Azerbaijan', 'code' => 'az'),
				array('folder' => 'English', 'code' => 'en'),
				array('folder' => 'Russian', 'code' => 'ru')
			);
		}

		return $result;
	}

	private function has_post_i18n_alt_name() {
		global $db;

		if ($this->post_i18n_has_alt_name !== null) {
			return $this->post_i18n_has_alt_name;
		}

		$this->post_i18n_has_alt_name = false;

		if (!(function_exists('dle_ml_table_exists') && dle_ml_table_exists('post_i18n'))) {
			return $this->post_i18n_has_alt_name;
		}

		$table_name = PREFIX . "_post_i18n";
		$safe_table = $db->safesql($table_name);
		$res = $db->query("SHOW COLUMNS FROM `{$safe_table}` LIKE 'alt_name'", false, false);

		if ($res instanceof mysqli_result) {
			$this->post_i18n_has_alt_name = ($res->num_rows > 0);
			$db->free($res);
		}

		return $this->post_i18n_has_alt_name;
	}
	
	function generate() {
		foreach ($this->languages as $language) {
			$this->generate_static($language);
			$this->generate_categories($language);
			if ($this->allow_tags ) $this->generate_tags($language);
			$this->generate_news($language);
		}

		if( is_array($this->googlenews) AND count($this->googlenews) ) {
			foreach ($this->googlenews as $language_code => $items) {
				if (!count($items)) continue;
				$file_name = "google_news_{$language_code}.xml";
				$this->sitemap->news($file_name, function($map) use ($items, $language_code) {
					global $config;
					foreach( $items as $news) {
						$map->setPublication($config['home_title'], $language_code);
						$map->loc($news['loc'])->news(
						[
						   'title' => $news['title'],
						   'publication_date' => date('c', $news['last']),
						]);
					}
				});
			}
		}

		$this->sitemap->save();
		$this->collapse_to_single_sitemap();
		
	}

	private function collapse_to_single_sitemap() {
		$index_file = ROOT_DIR . '/uploads/sitemap.xml';

		if (!file_exists($index_file)) return;

		$index_doc = new DOMDocument();
		if (!@$index_doc->load($index_file)) return;

		if ($index_doc->documentElement->localName !== 'sitemapindex') return;

		$single_doc = new DOMDocument('1.0', 'UTF-8');
		$single_doc->formatOutput = false;
		$urlset = $single_doc->createElementNS('http://www.sitemaps.org/schemas/sitemap/0.9', 'urlset');
		$urlset->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:image', 'http://www.google.com/schemas/sitemap-image/1.1');
		$urlset->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:video', 'http://www.google.com/schemas/sitemap-video/1.1');
		$urlset->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:xhtml', 'http://www.w3.org/1999/xhtml');
		$single_doc->appendChild($urlset);

		$xpath = new DOMXPath($index_doc);
		foreach ($xpath->query("//*[local-name()='sitemap']/*[local-name()='loc']") as $loc_node) {
			$loc = trim($loc_node->nodeValue);
			if (!$loc) continue;

			$path = parse_url($loc, PHP_URL_PATH);
			if (!$path) continue;

			$source_file = ROOT_DIR . '/uploads/' . basename($path);
			if (!file_exists($source_file)) continue;

			$source_doc = new DOMDocument();
			if (!@$source_doc->load($source_file)) continue;

			$source_xpath = new DOMXPath($source_doc);
			foreach ($source_xpath->query("//*[local-name()='url']") as $url_node) {
				$urlset->appendChild($single_doc->importNode($url_node, true));
			}
		}

		$single_doc->save($index_file);
	}
	
	function generate_news($language = array()) {
		
		global $db, $config, $user_group;

		$allow_list = explode ( ',', $user_group[5]['allow_cats'] );
		$not_allow_cats = explode ( ',', $user_group[5]['not_allow_cats'] );
		$stop_list = "";
		$cat_join = "";
	
		if ($allow_list[0] != "all") {
			
			if ($config['allow_multi_category']) {
				
				$cat_join = "INNER JOIN (SELECT DISTINCT(" . PREFIX . "_post_extras_cats.news_id) FROM " . PREFIX . "_post_extras_cats WHERE cat_id IN (" . implode ( ',', $allow_list ) . ")) c ON (p.id=c.news_id) ";
			
			} else {
				
				$stop_list = "category IN ('" . implode ( "','", $allow_list ) . "') AND ";
			
			}
			
		}
	
		if( $not_allow_cats[0] ) {
			
			if ($config['allow_multi_category']) {
				
				$stop_list = "p.id NOT IN ( SELECT DISTINCT(" . PREFIX . "_post_extras_cats.news_id) FROM " . PREFIX . "_post_extras_cats WHERE cat_id IN (" . implode ( ',', $not_allow_cats ) . ") ) AND ";
	
				
			} else {
				
				$stop_list = "category NOT IN ('" . implode ( "','", $not_allow_cats ) . "') AND ";
			
			}
			
		}
		
		$thisdate = date( "Y-m-d H:i:s", time() );
		if( $config['no_date'] AND !$config['news_future'] ) $where_date = " AND date < '" . $thisdate . "'";
		else $where_date = "";
	
		$row = $db->super_query( "SELECT COUNT(*) as count FROM " . PREFIX . "_post p {$cat_join}WHERE {$stop_list}approve=1{$where_date}" );
	
		if ( !$this->limit ) $this->limit = $row['count'];
		
		if ( $this->limit > $this->news_per_file ) {
	
			$pages_count = @ceil( $row['count'] / $this->news_per_file );
			
			$n = 0;
	
			for ($i =0; $i < $pages_count; $i++) {

				$n = $n+1;

				$this->get_news($n, $language);

			}
	
	
		} else {
	
			$this->get_news(false, $language);
		
		}
	
	}
	
	function generate_categories($language = array()) {
		global $db, $user_group;

		$this->priority = $this->cat_priority;
		$this->changefreq = $this->cat_changefreq;

		$cat_info = get_vars("category");

		if (!is_array($cat_info)) {
			$cat_info = array();

			$db->query("SELECT * FROM " . PREFIX . "_category ORDER BY posi ASC");

			while ($row = $db->get_row()) {

				if (!$row['active']) continue;

				$cat_info[$row['id']] = array();

				foreach ($row as $key => $value) {
					$cat_info[$row['id']][$key] = $value;
				}
			}

			set_vars("category", $cat_info);
			$db->free();
		}
		
		$allow_list = explode(',', $user_group[5]['allow_cats']);
		$not_allow_cats = explode(',', $user_group[5]['not_allow_cats']);

		foreach ($cat_info as $cats) {
			if ($cats['disable_index']) unset( $cat_info[$cats['id']] );
			
			if ($allow_list[0] != "all") {
				if (!$user_group[5]['allow_short'] and !in_array($cats['id'], $allow_list)) unset( $cat_info[$cats['id']] );
			}

			if ($not_allow_cats[0]) {
				if (!$user_group[5]['allow_short'] and in_array($cats['id'], $not_allow_cats)) unset( $cat_info[$cats['id']] );
			}

		}

		if( !count($cat_info) ) return;

		$lang_code = isset($language['code']) ? $language['code'] : 'en';
		$file_name = "category_pages_{$lang_code}.xml";
		$lang_prefix = $lang_code . '/';

		$this->sitemap->links($file_name, function($map) use ($cat_info, $lang_prefix, $lang_code) {
		
			foreach ( $cat_info as $cats ) {

				if( $this->allow_url ) $loc = $lang_prefix . get_url( $cats['id'] ) . "/";
				else $loc = "index.php?site_lang={$lang_code}&do=cat&category=" . get_url ($cats['id'] );
				
				$map->loc($loc)->freq($this->changefreq)->lastMod(date('c'))->priority( $this->priority );
				
			}
			
		});
		
	}
	
	function generate_static($language = array()) {
		
		global $db;
		
		$this->priority = $this->stat_priority;
		$this->changefreq = $this->stat_changefreq;

		$result_count = $db->super_query("SELECT COUNT(*) as count FROM " . PREFIX . "_static WHERE name !='dle-rules-page' AND sitemap='1' AND password='' AND disable_index='0'");

		if( !$result_count['count'] ) return;

		$lang_folder = isset($language['folder']) ? $db->safesql($language['folder']) : '';
		$lang_code = isset($language['code']) ? $language['code'] : 'en';
		$lang_prefix = $lang_code . '/';
		$file_name = "static_pages_{$lang_code}.xml";
		$has_i18n = function_exists('dle_ml_table_exists') ? dle_ml_table_exists('static_i18n') : false;

		if ($has_i18n && $lang_folder) {
			$this->db_result = $db->query( "SELECT s.id, s.name, s.sitemap, s.disable_index, s.password, i.name as i18n_name FROM " . PREFIX . "_static s LEFT JOIN " . PREFIX . "_static_i18n i ON (i.static_id=s.id AND i.lang='{$lang_folder}')" );
		} else {
			$this->db_result = $db->query( "SELECT id, name, sitemap, disable_index, password, '' as i18n_name FROM " . PREFIX . "_static" );
		}

		if( $this->set_images ) {
			$file_params = ['name' => $file_name, 'images' => true];
		} else {
			$file_params = $file_name;
		}

		$this->sitemap->links($file_params, function($map) use ($lang_prefix, $lang_code) {
			
			global $db;
			
			while ( $row = $db->get_row( $this->db_result ) ) {
				
				if( $row['name'] == "dle-rules-page" ) continue;
				if( !$row['sitemap'] OR $row['disable_index'] OR $row['password']) continue;
				
				$page_name = $row['name'];
				if( isset($row['i18n_name']) AND trim((string)$row['i18n_name']) !== '' ) $page_name = $row['i18n_name'];

				if( $this->allow_url ) $loc = $lang_prefix . $page_name . ".html";
				else $loc = "index.php?site_lang={$lang_code}&do=static&page=" . $page_name;
				
				$map->loc($loc)->freq($this->changefreq)->lastMod(date('c'))->priority( $this->priority );

				if ($this->set_images) {

					$images_sql = $db->query( "SELECT name FROM " . PREFIX . "_static_files WHERE static_id = '{$row['id']}' AND onserver = ''" );

					while ($images_row = $db->get_row( $images_sql )) {

						$image = get_uploaded_image_info($images_row['name']);

						$map->image($image->url);
						
					}
				}
				
			}
			
		});
		
	}
	
	function generate_tags($language = array()) {
		
		global $db;
		
		$this->priority = $this->cat_priority;
		$this->changefreq = $this->cat_changefreq;

		$result_count = $db->super_query("SELECT COUNT(*) as count FROM " . PREFIX . "_tags");

		if( !$result_count['count'] ) return;

		$lang_code = isset($language['code']) ? $language['code'] : 'en';
		$lang_prefix = $lang_code . '/';
		$file_name = "tags_pages_{$lang_code}.xml";
		$this->db_result = $db->query( "SELECT tag FROM " . PREFIX . "_tags GROUP BY tag LIMIT 0, 40000" );
		
		$this->sitemap->links($file_name, function($map) use ($lang_prefix, $lang_code) {
			
			global $db;
			
			while ( $row = $db->get_row( $this->db_result ) ) {
				
				$row['tag'] = str_replace(array("&#039;", "&quot;", "&amp;"), array("'", '"', "&"), $row['tag']);
				
				if( $this->allow_url ) $loc = $lang_prefix . "tags/" . rawurlencode( dle_strtolower($row['tag']) ) . "/";
				else $loc = "index.php?site_lang={$lang_code}&do=tags&tag=" .  rawurlencode( dle_strtolower($row['tag']) );	
				
				$map->loc($loc)->freq($this->changefreq)->lastMod(date('c'))->priority( $this->priority );
				
			}
			
		});
		
	}
	
	function get_news( $page = false, $language = array() ) {
		
		global $db, $config, $user_group;
		
		$this->priority = $this->news_priority;
		$this->changefreq = $this->news_changefreq;
		$prefix_page = '';
		
		if ( $page ) {
			
			if( $page != 1 ) $prefix_page = $page;

			$page = $page - 1;
			$page = $page * $this->news_per_file;
			$this->limit = " LIMIT {$page}, {$this->news_per_file}";

		} else {

			if( $this->limit < 1 ) $this->limit = false;
			
			if( $this->limit ) {
				
				$this->limit = " LIMIT 0," . $this->limit;
			
			} else {
				
				$this->limit = "";
			
			}
		}
		
		$thisdate = date( "Y-m-d H:i:s", time() );
		if( $config['no_date'] AND !$config['news_future'] ) $where_date = " AND date < '" . $thisdate . "'";
		else $where_date = "";

		$allow_list = explode ( ',', $user_group[5]['allow_cats'] );
		$not_allow_cats = explode ( ',', $user_group[5]['not_allow_cats'] );
		$stop_list = "";
		$cat_join = "";

		if ($allow_list[0] != "all") {
			
			if ($config['allow_multi_category']) {
				
				$cat_join = " INNER JOIN (SELECT DISTINCT(" . PREFIX . "_post_extras_cats.news_id) FROM " . PREFIX . "_post_extras_cats WHERE cat_id IN (" . implode ( ',', $allow_list ) . ")) c ON (p.id=c.news_id) ";
			
			} else {
				
				$stop_list = "category IN ('" . implode ( "','", $allow_list ) . "') AND ";
			
			}
		
		}

		if( $not_allow_cats[0] ) {
			
			if ($config['allow_multi_category']) {
				
				$stop_list = "p.id NOT IN ( SELECT DISTINCT(" . PREFIX . "_post_extras_cats.news_id) FROM " . PREFIX . "_post_extras_cats WHERE cat_id IN (" . implode ( ',', $not_allow_cats ) . ") ) AND ";
			
			} else {
				
				$stop_list = "category NOT IN ('" . implode ( "','", $not_allow_cats ) . "') AND ";
			
			}
			
		}
		
		$lang_code = isset($language['code']) ? $language['code'] : 'en';
		$lang_folder = isset($language['folder']) ? $db->safesql($language['folder']) : '';
		$lang_prefix = $lang_code . '/';
		$join_i18n = "";
		$title_expr = "p.title";
		$alt_expr = "p.alt_name";

		if ($lang_folder && function_exists('dle_ml_table_exists') && dle_ml_table_exists('post_i18n')) {
			$join_i18n = " LEFT JOIN " . PREFIX . "_post_i18n pi ON (pi.news_id=p.id AND pi.lang='{$lang_folder}') ";
			$title_expr = "IF(pi.title != '', pi.title, p.title)";
			if ($this->has_post_i18n_alt_name()) {
				$alt_expr = "IF(pi.alt_name != '', pi.alt_name, p.alt_name)";
			}
		}

		$this->db_result = $db->query( "SELECT p.id, {$title_expr} as title, p.date, {$alt_expr} as alt_name, p.category, e.access, e.editdate, e.disable_index, e.need_pass FROM " . PREFIX . "_post p {$cat_join}{$join_i18n}LEFT JOIN " . PREFIX . "_post_extras e ON (p.id=e.news_id) WHERE {$stop_list}approve=1" . $where_date . " ORDER BY date DESC" . $this->limit );
		
		if( $this->set_images ) {
			$file_params = ['name' => "news_pages_{$lang_code}{$prefix_page}.xml", 'images' => true];	
		} else {
			$file_params = "news_pages_{$lang_code}{$prefix_page}.xml";
		}

		$this->sitemap->links($file_params, function($map) use ($lang_prefix, $lang_code) {	
			global $db, $config;
		
			$two_days = time() - (2 * 3600 * 24);

			$cat_info = get_vars("category");

			while ( $row = $db->get_row( $this->db_result ) ) {
				
				$row['date'] = strtotime($row['date']);
				
				$row['cats'] = explode(',', $row['category']);

				foreach ($row['cats'] as $element) {
					$element = trim(intval($element));
					if( $element AND isset($cat_info[$element]['id']) AND $cat_info[$element]['disable_index'] ) $row['disable_index'] = true;
				}

				$row['category'] = intval( $row['category'] );
	
				if ( $row['disable_index'] ) continue;
				
				if ( $row['need_pass'] ) continue;
				
				if (strpos( $row['access'], '5:3' ) !== false) continue;
	
				if( $this->allow_url ) {
					
					if( $config['seo_type'] == 1 OR  $config['seo_type'] == 2 ) {
						
						if( $row['category'] and $config['seo_type'] == 2 ) {
							
							$cats_url = get_url( $row['category'] );
							
							if($cats_url) {
								
								$loc = $lang_prefix . $cats_url . "/" . $row['id'] . "-" . $row['alt_name'] . ".html";
								
							} else $loc = $lang_prefix . $row['id'] . "-" . $row['alt_name'] . ".html";
						
						} else {
							
							$loc = $lang_prefix . $row['id'] . "-" . $row['alt_name'] . ".html";
						
						}
					
					} else {
						
						$loc = $lang_prefix . date( 'Y/m/d/', $row['date'] ) . $row['alt_name'] . ".html";
					}
				
				} else {
					
					$loc = "index.php?site_lang={$lang_code}&newsid=" . $row['id'];
				
				}
	
				if ( $row['editdate'] AND $row['editdate'] > $row['date'] ){
				
					$row['date'] =  $row['editdate'];
				
				}
				
				if( $row['date'] > $two_days ) {
					if (!isset($this->googlenews[$lang_code]) || !is_array($this->googlenews[$lang_code])) $this->googlenews[$lang_code] = array();
					$this->googlenews[$lang_code][] = array('title' => stripslashes($row['title']), 'loc' => $loc, 'last' => $row['date']);
				}

				$map->loc($loc)->freq($this->changefreq)->lastMod( date('c', $row['date'] ) )->priority( $this->priority );
				
				if ($this->set_images) {

					$images_row = $db->super_query("SELECT images  FROM " . PREFIX . "_images WHERE news_id = '{$row['id']}'");

					if (isset($images_row['images']) and $images_row['images']) {
						$listimages = explode("|||", $images_row['images']);

						foreach ($listimages as $dataimages) {

							$image = get_uploaded_image_info($dataimages);
							$map->image($image->url);

						}
					}
				}

			}
			
		});
		

	}

}
