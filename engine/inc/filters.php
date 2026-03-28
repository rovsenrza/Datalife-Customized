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
 File: filters.php
-----------------------------------------------------
 Use: category filters config
=====================================================
*/

if( !defined('DATALIFEENGINE') OR !defined('LOGGED_IN') ) {
	header( "HTTP/1.1 403 Forbidden" );
	header ( 'Location: ../../' );
	die( "Hacking attempt!" );
}

if( !$user_group[$member_id['user_group']]['allow_admin'] ) {
	msg("error", $lang['index_denied'], $lang['index_denied']);
}

$filters_file = ENGINE_DIR . '/data/category_filters.json';
$allowed_types = array('range', 'radio', 'checkbox', 'input');

function dle_filters_available_languages() {
	if (function_exists('dle_ml_get_languages')) {
		$langs = dle_ml_get_languages();
		if (is_array($langs) && count($langs)) {
			return $langs;
		}
	}

	$fallback = array();
	$folders = get_folder_list('language');
	if (is_array($folders)) {
		foreach ($folders as $folder => $meta) {
			$fallback[$folder] = array(
				'title' => isset($meta['title']) && $meta['title'] ? $meta['title'] : $folder
			);
		}
	}

	return $fallback;
}

function dle_filters_admin_lang_folder() {
	global $config;

	$folder = isset($config['langs']) ? totranslit($config['langs'], false, false) : 'English';

	if (isset($_POST['selected_language']) && $_POST['selected_language']) {
		$folder = totranslit($_POST['selected_language'], false, false);
	} elseif (isset($_COOKIE['selected_language']) && $_COOKIE['selected_language']) {
		$folder = totranslit($_COOKIE['selected_language'], false, false);
	}

	if (!in_array($folder, array('Azerbaijan', 'English', 'Russian'))) {
		$folder = 'English';
	}

	return $folder;
}

function dle_filters_t($key) {
	static $dict = array(
		'Azerbaijan' => array(
			'page_title' => 'Filterlər',
			'page_subtitle' => 'Kateqoriya XFields filterləri',
			'save_error' => 'Filter konfiqurasiyasını kodlaşdırmaq mümkün olmadı',
			'write_error' => 'Filter faylına yazmaq mümkün olmadı',
			'required_error' => 'Məcburi sahələri doldurun: başlıq, xfield, tip',
			'form_title' => 'Filter əlavə et / redaktə et',
			'label_title' => 'Başlıq',
			'label_xfield' => 'XField adı',
			'label_type' => 'Tip',
			'label_categories' => 'Kateqoriyalar (boş = bütün kateqoriyalar)',
			'label_enabled' => 'Aktiv',
			'btn_save' => 'Filteri saxla',
			'btn_reset' => 'Sıfırla',
			'list_title' => 'Mövcud filterlər',
			'th_title' => 'Başlıq',
			'th_xfield' => 'XField',
			'th_type' => 'Tip',
			'th_categories' => 'Kateqoriyalar',
			'th_status' => 'Status',
			'th_actions' => 'Əməliyyat',
			'status_enabled' => 'Aktiv',
			'status_disabled' => 'Passiv',
			'all' => 'Hamısı',
			'no_filters' => 'Hələ filter əlavə edilməyib',
			'confirm_delete' => 'Filter silinsin?'
		),
		'English' => array(
			'page_title' => 'Filters',
			'page_subtitle' => 'Category XFields Filters',
			'save_error' => 'Unable to encode filters configuration',
			'write_error' => 'Unable to write filters file',
			'required_error' => 'Fill all required fields: title, xfield, type',
			'form_title' => 'Add / Edit Filter',
			'label_title' => 'Title',
			'label_xfield' => 'XField Name',
			'label_type' => 'Type',
			'label_categories' => 'Categories (empty = all categories)',
			'label_enabled' => 'Enabled',
			'btn_save' => 'Save Filter',
			'btn_reset' => 'Reset',
			'list_title' => 'Configured Filters',
			'th_title' => 'Title',
			'th_xfield' => 'XField',
			'th_type' => 'Type',
			'th_categories' => 'Categories',
			'th_status' => 'Status',
			'th_actions' => 'Actions',
			'status_enabled' => 'Enabled',
			'status_disabled' => 'Disabled',
			'all' => 'All',
			'no_filters' => 'No filters yet',
			'confirm_delete' => 'Delete filter?'
		),
		'Russian' => array(
			'page_title' => 'Фильтры',
			'page_subtitle' => 'Фильтры категорий по XFields',
			'save_error' => 'Не удалось закодировать конфигурацию фильтров',
			'write_error' => 'Не удалось записать файл фильтров',
			'required_error' => 'Заполните обязательные поля: заголовок, xfield, тип',
			'form_title' => 'Добавить / редактировать фильтр',
			'label_title' => 'Заголовок',
			'label_xfield' => 'Имя XField',
			'label_type' => 'Тип',
			'label_categories' => 'Категории (пусто = все категории)',
			'label_enabled' => 'Активен',
			'btn_save' => 'Сохранить фильтр',
			'btn_reset' => 'Сброс',
			'list_title' => 'Настроенные фильтры',
			'th_title' => 'Заголовок',
			'th_xfield' => 'XField',
			'th_type' => 'Тип',
			'th_categories' => 'Категории',
			'th_status' => 'Статус',
			'th_actions' => 'Действия',
			'status_enabled' => 'Активен',
			'status_disabled' => 'Отключен',
			'all' => 'Все',
			'no_filters' => 'Фильтры пока не добавлены',
			'confirm_delete' => 'Удалить фильтр?'
		),
	);

	$folder = dle_filters_admin_lang_folder();
	if (!isset($dict[$folder][$key])) {
		$folder = 'English';
	}

	return isset($dict[$folder][$key]) ? $dict[$folder][$key] : $key;
}

function dle_admin_filters_load($path) {
	if( !file_exists($path) ) return array();

	$data = @file_get_contents($path);
	if( !$data ) return array();

	$json = json_decode($data, true);
	if( !is_array($json) ) return array();

	return $json;
}

function dle_admin_filters_save($path, $data) {
	$data = array_values($data);
	$json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

	if( $json === false ) {
		msg("error", dle_filters_t('page_title'), dle_filters_t('save_error'));
	}

	if( file_put_contents($path, $json) === false ) {
		msg("error", dle_filters_t('page_title'), dle_filters_t('write_error') . ": {$path}");
	}
}

$action = isset($_REQUEST['action']) ? totranslit($_REQUEST['action']) : 'list';
$filters = dle_admin_filters_load($filters_file);

if( $action == 'save' ) {

	if( !isset($_REQUEST['user_hash']) OR $_REQUEST['user_hash'] != $dle_login_hash ) {
		die("Hacking attempt! User not found");
	}

	$data = isset($_POST['filter']) && is_array($_POST['filter']) ? $_POST['filter'] : array();

	$id = isset($data['id']) ? preg_replace("/[^a-z0-9\_\-]+/i", "", $data['id']) : '';
	if( !$id ) {
		$id = 'f' . dechex(time()) . dechex(random_int(1000, 9999));
	}

	$title = isset($data['title']) ? trim(strip_tags($data['title'])) : '';
	$xfield = isset($data['xfield']) ? totranslit(trim($data['xfield']), false, false) : '';
	$type = isset($data['type']) ? trim($data['type']) : 'checkbox';
	$enabled = isset($data['enabled']) ? 1 : 0;
	$title_i18n = array();
	$available_langs = dle_filters_available_languages();

	if (isset($data['title_i18n']) && is_array($data['title_i18n'])) {
		foreach ($data['title_i18n'] as $folder => $value) {
			$folder = totranslit($folder, false, false);
			if (!isset($available_langs[$folder])) continue;
			$value = trim(strip_tags((string)$value));
			$title_i18n[$folder] = $value;
		}
	}

	if (!$title && count($title_i18n)) {
		foreach ($title_i18n as $v) {
			if ($v !== '') {
				$title = $v;
				break;
			}
		}
	}

	if( !$title OR !$xfield OR !in_array($type, $allowed_types) ) {
		msg("error", dle_filters_t('page_title'), dle_filters_t('required_error'), "?mod=filters");
	}

	$categories = isset($data['categories']) && is_array($data['categories']) ? $data['categories'] : array();
	$cat_save = array();
	foreach($categories as $cat) {
		$cat = intval($cat);
		if($cat > 0) $cat_save[$cat] = $cat;
	}

	$record = array(
		'id' => $id,
		'title' => $title,
		'title_i18n' => $title_i18n,
		'xfield' => $xfield,
		'type' => $type,
		'enabled' => $enabled,
		'categories' => array_values($cat_save)
	);

	$updated = false;
	foreach($filters as $index => $item) {
		if( isset($item['id']) && $item['id'] === $id ) {
			$filters[$index] = $record;
			$updated = true;
			break;
		}
	}

	if( !$updated ) {
		$filters[] = $record;
	}

	dle_admin_filters_save($filters_file, $filters);
	clear_cache();
	header("Location: ?mod=filters");
	die();
}

if( $action == 'delete' ) {

	if( !isset($_REQUEST['user_hash']) OR $_REQUEST['user_hash'] != $dle_login_hash ) {
		die("Hacking attempt! User not found");
	}

	$id = isset($_GET['id']) ? preg_replace("/[^a-z0-9\_\-]+/i", "", $_GET['id']) : '';
	if( $id ) {
		foreach($filters as $index => $item) {
			if( isset($item['id']) && $item['id'] === $id ) {
				unset($filters[$index]);
				break;
			}
		}
		dle_admin_filters_save($filters_file, $filters);
		clear_cache();
	}

	header("Location: ?mod=filters");
	die();
}

$edit = array(
	'id' => '',
	'title' => '',
	'title_i18n' => array(),
	'xfield' => '',
	'type' => 'checkbox',
	'enabled' => 1,
	'categories' => array()
);

if( $action == 'edit' ) {
	$id = isset($_GET['id']) ? preg_replace("/[^a-z0-9\_\-]+/i", "", $_GET['id']) : '';
	foreach($filters as $item) {
		if( isset($item['id']) && $item['id'] === $id ) {
			$edit = $item;
			break;
		}
	}
}

echoheader("<i class=\"fa fa-filter position-left\"></i><span class=\"text-semibold\">".dle_filters_t('page_title')."</span>", array('?mod=filters' => dle_filters_t('page_title'), '' => dle_filters_t('page_subtitle')));

$types_html = '';
foreach($allowed_types as $type) {
	$selected = ($edit['type'] == $type) ? ' selected' : '';
	$types_html .= "<option value=\"{$type}\"{$selected}>{$type}</option>";
}

$categories_html = '';
foreach($cat_info as $cat) {
	$cid = intval($cat['id']);
	$selected = in_array($cid, isset($edit['categories']) ? $edit['categories'] : array()) ? ' selected' : '';
	$cname = htmlspecialchars(stripslashes($cat['name']), ENT_QUOTES, 'UTF-8');
	$categories_html .= "<option value=\"{$cid}\"{$selected}>{$cname}</option>";
}

$title_value = htmlspecialchars($edit['title'], ENT_QUOTES, 'UTF-8');
$xfield_value = htmlspecialchars($edit['xfield'], ENT_QUOTES, 'UTF-8');
$enabled_checked = !empty($edit['enabled']) ? ' checked' : '';
$id_value = htmlspecialchars($edit['id'], ENT_QUOTES, 'UTF-8');
$title_i18n_inputs = '';
$available_langs = dle_filters_available_languages();
foreach ($available_langs as $folder => $meta) {
	$meta_title = isset($meta['title']) ? $meta['title'] : $folder;
	$value = '';
	if (isset($edit['title_i18n']) && is_array($edit['title_i18n']) && isset($edit['title_i18n'][$folder])) {
		$value = $edit['title_i18n'][$folder];
	} elseif ($folder == (isset($config['langs']) ? $config['langs'] : '') && $title_value) {
		$value = htmlspecialchars_decode($title_value, ENT_QUOTES);
	}

	$folder_safe = htmlspecialchars($folder, ENT_QUOTES, 'UTF-8');
	$meta_title_safe = htmlspecialchars($meta_title, ENT_QUOTES, 'UTF-8');
	$value_safe = htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8');
	$title_i18n_inputs .= "<div style=\"margin-bottom:8px;\"><label class=\"text-muted text-size-small\" style=\"display:block;\">{$meta_title_safe}</label><input type=\"text\" class=\"form-control\" name=\"filter[title_i18n][{$folder_safe}]\" value=\"{$value_safe}\"></div>";
}
$form_title = dle_filters_t('form_title');
$label_title = dle_filters_t('label_title');
$label_xfield = dle_filters_t('label_xfield');
$label_type = dle_filters_t('label_type');
$label_categories = dle_filters_t('label_categories');
$label_enabled = dle_filters_t('label_enabled');
$btn_save = dle_filters_t('btn_save');
$btn_reset = dle_filters_t('btn_reset');
$list_title = dle_filters_t('list_title');
$th_title = dle_filters_t('th_title');
$th_xfield = dle_filters_t('th_xfield');
$th_type = dle_filters_t('th_type');
$th_categories = dle_filters_t('th_categories');
$th_status = dle_filters_t('th_status');
$th_actions = dle_filters_t('th_actions');
$status_enabled = dle_filters_t('status_enabled');
$status_disabled = dle_filters_t('status_disabled');
$all_label = dle_filters_t('all');
$no_filters = dle_filters_t('no_filters');
$confirm_delete = htmlspecialchars(dle_filters_t('confirm_delete'), ENT_QUOTES, 'UTF-8');

echo <<<HTML
<form action="?mod=filters&action=save" method="post" class="p-15">
	<input type="hidden" name="user_hash" value="{$dle_login_hash}">
	<input type="hidden" name="filter[id]" value="{$id_value}">
	<div class="panel panel-default">
		<div class="panel-heading"><h6 class="panel-title">{$form_title}</h6></div>
		<div class="panel-body">
			<div class="row" style="margin-bottom:15px;">
				<div class="col-md-4"><label>{$label_title}</label><input type="text" name="filter[title]" value="{$title_value}" class="form-control" required></div>
				<div class="col-md-4"><label>{$label_xfield}</label><input type="text" name="filter[xfield]" value="{$xfield_value}" class="form-control" placeholder="product_price" required></div>
				<div class="col-md-4"><label>{$label_type}</label><select name="filter[type]" class="form-control">{$types_html}</select></div>
			</div>
			<div class="row" style="margin-bottom:15px;">
				<div class="col-md-8"><label>{$label_title} (AZ/EN/RU)</label>{$title_i18n_inputs}</div>
			</div>
			<div class="row" style="margin-bottom:15px;">
				<div class="col-md-8"><label>{$label_categories}</label><select name="filter[categories][]" class="form-control" multiple size="8">{$categories_html}</select></div>
				<div class="col-md-4" style="padding-top:30px;"><label><input type="checkbox" name="filter[enabled]" value="1"{$enabled_checked}> {$label_enabled}</label></div>
			</div>
			<div><button type="submit" class="btn bg-teal btn-raised">{$btn_save}</button> <a href="?mod=filters" class="btn btn-default btn-raised">{$btn_reset}</a></div>
		</div>
	</div>
</form>
HTML;

$rows = '';
foreach($filters as $item) {
	$id = htmlspecialchars($item['id'], ENT_QUOTES, 'UTF-8');
	$title = htmlspecialchars($item['title'], ENT_QUOTES, 'UTF-8');
	$xfield = htmlspecialchars($item['xfield'], ENT_QUOTES, 'UTF-8');
	$type = htmlspecialchars($item['type'], ENT_QUOTES, 'UTF-8');
	$status = !empty($item['enabled']) ? '<span class="text-success">'.$status_enabled.'</span>' : '<span class="text-muted">'.$status_disabled.'</span>';
	$cats = '';

	if( isset($item['categories']) && is_array($item['categories']) && count($item['categories']) ) {
		$list = array();
		foreach($item['categories'] as $cat_id) {
			$cat_id = intval($cat_id);
			if( isset($cat_info[$cat_id]['name']) ) $list[] = htmlspecialchars($cat_info[$cat_id]['name'], ENT_QUOTES, 'UTF-8');
		}
		$cats = count($list) ? implode(', ', $list) : $all_label;
	} else {
		$cats = $all_label;
	}

	$rows .= "<tr><td>{$title}</td><td>{$xfield}</td><td>{$type}</td><td>{$cats}</td><td>{$status}</td><td class=\"text-center\"><a href=\"?mod=filters&action=edit&id={$id}\"><i class=\"fa fa-pencil-square-o\"></i></a>&nbsp;&nbsp;<a onclick=\"return confirm('{$confirm_delete}');\" href=\"?mod=filters&action=delete&id={$id}&user_hash={$dle_login_hash}\"><i class=\"fa fa-trash text-danger\"></i></a></td></tr>";
}

if( !$rows ) {
	$rows = '<tr><td colspan="6" class="text-center text-muted">'.$no_filters.'</td></tr>';
}

echo <<<HTML
<div class="panel panel-default p-15">
	<div class="panel-heading"><h6 class="panel-title">{$list_title}</h6></div>
	<div class="panel-body table-responsive">
		<table class="table table-bordered table-striped">
			<thead><tr><th>{$th_title}</th><th>{$th_xfield}</th><th>{$th_type}</th><th>{$th_categories}</th><th>{$th_status}</th><th style="width:90px;" class="text-center">{$th_actions}</th></tr></thead>
			<tbody>{$rows}</tbody>
		</table>
	</div>
</div>
HTML;

echofooter();
