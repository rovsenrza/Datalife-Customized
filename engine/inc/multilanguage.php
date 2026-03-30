<?php
/*
=====================================================
 DataLife Engine - by SoftNews Media Group
-----------------------------------------------------
 Custom multilanguage helper
=====================================================
*/

if( !defined('DATALIFEENGINE') ) {
    header("HTTP/1.1 403 Forbidden");
    header('Location: ../');
    die("Hacking attempt!");
}

function dle_ml_predefined_codes() {
    return array(
        'azerbaijan' => 'az',
        'english' => 'en',
        'russian' => 'ru',
    );
}

function dle_ml_code_from_folder($folder) {
    $folder = totranslit($folder, false, false);
    $folder_l = strtolower($folder);

    $map = dle_ml_predefined_codes();
    if (isset($map[$folder_l])) return $map[$folder_l];

    if (strlen($folder_l) >= 2) return substr($folder_l, 0, 2);

    return 'en';
}

function dle_ml_languages_file_path() {
    return ENGINE_DIR . '/data/site_languages.json';
}

function dle_ml_sanitize_folder_key($folder) {
    $folder = totranslit(trim((string)$folder), false, false);
    $folder = preg_replace('/[^a-zA-Z0-9_\-]/', '', $folder);

    return trim((string)$folder);
}

function dle_ml_get_languages_all($force = false) {
    global $config;

    static $cache = null;

    if (!$force && is_array($cache)) {
        return $cache;
    }

    $folder_map = get_folder_list('language');
    if (!is_array($folder_map)) $folder_map = array();

    $languages = array();
    $ordered_folders = array();
    $seen_keys = array();
    $file_path = dle_ml_languages_file_path();
    $registry = array();

    if (file_exists($file_path)) {
        $raw = @file_get_contents($file_path);
        if ($raw !== false && $raw !== '') {
            $json = @json_decode($raw, true);
            if (is_array($json)) {
                $registry = $json;
            }
        }
    }

    if (is_array($registry) && count($registry)) {
        foreach ($registry as $entry) {
            if (!is_array($entry)) continue;

            $folder = isset($entry['folder']) ? dle_ml_sanitize_folder_key($entry['folder']) : '';
            if (!$folder) continue;

            $key = strtolower($folder);
            if (isset($seen_keys[$key])) continue;
            $seen_keys[$key] = 1;
            $ordered_folders[] = $folder;
        }
    }

    if (is_array($folder_map)) {
        foreach ($folder_map as $folder => $meta) {
            $folder = dle_ml_sanitize_folder_key($folder);
            if (!$folder) continue;

            $key = strtolower($folder);
            if (isset($seen_keys[$key])) continue;
            $seen_keys[$key] = 1;
            $ordered_folders[] = $folder;
        }
    }

    foreach ($ordered_folders as $folder) {
        $entry = array();

        if (is_array($registry) && count($registry)) {
            foreach ($registry as $row) {
                if (!is_array($row)) continue;
                if (!isset($row['folder'])) continue;
                if (strtolower(dle_ml_sanitize_folder_key($row['folder'])) == strtolower($folder)) {
                    $entry = $row;
                    break;
                }
            }
        }

        $meta = isset($folder_map[$folder]) && is_array($folder_map[$folder]) ? $folder_map[$folder] : array();

        $name = isset($entry['name']) ? trim((string)$entry['name']) : '';
        if (!$name && isset($meta['name'])) $name = trim((string)$meta['name']);
        if (!$name) $name = $folder;

        $title = isset($entry['title']) ? trim((string)$entry['title']) : '';
        if (!$title && isset($meta['title'])) $title = trim((string)$meta['title']);
        if (!$title) $title = $name;

        $code = isset($entry['code']) ? strtolower(trim((string)$entry['code'])) : '';
        $code = preg_replace('/[^a-z0-9]/', '', $code);
        if (!$code) $code = dle_ml_code_from_folder($folder);
        if (strlen($code) > 10) $code = substr($code, 0, 10);

        $icon = isset($entry['icon']) ? trim((string)$entry['icon']) : '';
        if (!$icon && isset($meta['icon'])) $icon = trim((string)$meta['icon']);

        $enabled = isset($entry['enabled']) ? intval($entry['enabled']) : 1;
        $installed = isset($folder_map[$folder]) ? 1 : 0;

        $languages[$folder] = array(
            'folder' => $folder,
            'name' => $name,
            'title' => $title,
            'code' => $code,
            'icon' => $icon,
            'enabled' => $enabled ? 1 : 0,
            'installed' => $installed,
        );
    }

    if (!count($languages)) {
        $fallback = !empty($config['main_language']) ? $config['main_language'] : (!empty($config['langs']) ? $config['langs'] : 'English');
        $fallback = dle_ml_sanitize_folder_key($fallback);
        if (!$fallback) $fallback = 'English';

        $languages[$fallback] = array(
            'folder' => $fallback,
            'name' => $fallback,
            'title' => $fallback,
            'code' => dle_ml_code_from_folder($fallback),
            'icon' => '',
            'enabled' => 1,
            'installed' => 0,
        );
    }

    $cache = $languages;

    return $cache;
}

function dle_ml_save_languages_all($languages = array()) {
    if (!is_array($languages)) return false;

    $clean = array();
    $seen = array();

    foreach ($languages as $entry) {
        if (!is_array($entry)) continue;

        $folder = isset($entry['folder']) ? dle_ml_sanitize_folder_key($entry['folder']) : '';
        if (!$folder) continue;

        $key = strtolower($folder);
        if (isset($seen[$key])) continue;
        $seen[$key] = 1;

        $title = isset($entry['title']) ? trim((string)$entry['title']) : '';
        if (!$title) $title = $folder;

        $name = isset($entry['name']) ? trim((string)$entry['name']) : $folder;
        if (!$name) $name = $folder;

        $code = isset($entry['code']) ? strtolower(trim((string)$entry['code'])) : '';
        $code = preg_replace('/[^a-z0-9]/', '', $code);
        if (!$code) $code = dle_ml_code_from_folder($folder);
        if (strlen($code) > 10) $code = substr($code, 0, 10);

        $icon = isset($entry['icon']) ? trim((string)$entry['icon']) : '';
        $enabled = isset($entry['enabled']) ? intval($entry['enabled']) : 1;

        $clean[] = array(
            'folder' => $folder,
            'name' => $name,
            'title' => $title,
            'code' => $code,
            'icon' => $icon,
            'enabled' => $enabled ? 1 : 0,
        );
    }

    if (!count($clean)) return false;

    $json = json_encode($clean, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($json === false) return false;

    if (@file_put_contents(dle_ml_languages_file_path(), $json) === false) return false;

    if (function_exists('opcache_reset')) {
        @opcache_reset();
    }

    return true;
}

function dle_ml_get_languages($force = false) {
    global $config;

    static $cache = null;

    if (!$force && is_array($cache)) {
        return $cache;
    }

    $all_languages = dle_ml_get_languages_all($force);
    $languages = array();

    foreach ($all_languages as $folder => $meta) {
        if (empty($meta['enabled'])) continue;

        $languages[$folder] = array(
            'folder' => $folder,
            'name' => isset($meta['name']) ? $meta['name'] : $folder,
            'title' => isset($meta['title']) ? $meta['title'] : $folder,
            'code' => isset($meta['code']) ? $meta['code'] : dle_ml_code_from_folder($folder),
            'icon' => isset($meta['icon']) ? $meta['icon'] : '',
            'enabled' => 1,
            'installed' => isset($meta['installed']) ? intval($meta['installed']) : 0,
        );
    }

    if (!count($languages)) {
        $main = isset($config['main_language']) ? (string)$config['main_language'] : '';
        if ($main && isset($all_languages[$main])) {
            $meta = $all_languages[$main];
            $languages[$main] = array(
                'folder' => $main,
                'name' => isset($meta['name']) ? $meta['name'] : $main,
                'title' => isset($meta['title']) ? $meta['title'] : $main,
                'code' => isset($meta['code']) ? $meta['code'] : dle_ml_code_from_folder($main),
                'icon' => isset($meta['icon']) ? $meta['icon'] : '',
                'enabled' => 1,
                'installed' => isset($meta['installed']) ? intval($meta['installed']) : 0,
            );
        } else {
            foreach ($all_languages as $folder => $meta) {
                $languages[$folder] = array(
                    'folder' => $folder,
                    'name' => isset($meta['name']) ? $meta['name'] : $folder,
                    'title' => isset($meta['title']) ? $meta['title'] : $folder,
                    'code' => isset($meta['code']) ? $meta['code'] : dle_ml_code_from_folder($folder),
                    'icon' => isset($meta['icon']) ? $meta['icon'] : '',
                    'enabled' => 1,
                    'installed' => isset($meta['installed']) ? intval($meta['installed']) : 0,
                );
                break;
            }
        }
    }

    $cache = $languages;

    return $cache;
}

function dle_ml_ordered_languages($main_folder = '') {
    $languages = dle_ml_get_languages();

    if (!$main_folder || !isset($languages[$main_folder])) {
        return $languages;
    }

    $ordered = array(
        $main_folder => $languages[$main_folder]
    );

    foreach ($languages as $folder => $meta) {
        if ($folder == $main_folder) continue;
        $ordered[$folder] = $meta;
    }

    return $ordered;
}

function dle_ml_main_folder($config_data = array()) {
    $languages = dle_ml_get_languages();

    if (isset($config_data['main_language']) && $config_data['main_language'] && isset($languages[$config_data['main_language']])) {
        return $config_data['main_language'];
    }

    if (isset($config_data['main_language']) && $config_data['main_language']) {
        $from_code = dle_ml_folder_from_code($config_data['main_language']);
        if ($from_code && isset($languages[$from_code])) {
            return $from_code;
        }
    }

    if (isset($config_data['langs']) && $config_data['langs'] && isset($languages[$config_data['langs']])) {
        return $config_data['langs'];
    }

    if (isset($config_data['langs']) && $config_data['langs']) {
        $from_code = dle_ml_folder_from_code($config_data['langs']);
        if ($from_code && isset($languages[$from_code])) {
            return $from_code;
        }
    }

    foreach ($languages as $folder => $meta) {
        return $folder;
    }

    return 'English';
}

function dle_ml_folder_from_code($code) {
    $code = strtolower(trim((string)$code));

    if (!$code) return '';

    $languages = dle_ml_get_languages();

    foreach ($languages as $folder => $meta) {
        if (isset($meta['code']) && strtolower($meta['code']) == $code) {
            return $folder;
        }
    }

    return '';
}

function dle_ml_code_from_folder_name($folder) {
    $languages = dle_ml_get_languages();

    if (isset($languages[$folder]['code'])) {
        return $languages[$folder]['code'];
    }

    return dle_ml_code_from_folder($folder);
}

function dle_ml_active_folder(&$config_data, $allow_cookie = true) {
    $languages = dle_ml_get_languages();
    $main_folder = dle_ml_main_folder($config_data);

    $active_folder = '';
    $path_lang_folder = '';

    $request_uri = isset($_SERVER['REQUEST_URI']) ? (string)$_SERVER['REQUEST_URI'] : '/';
    $request_path = parse_url($request_uri, PHP_URL_PATH);
    if (!$request_path) $request_path = '/';

    $request_path = preg_replace('#/+#', '/', $request_path);
    $first_segment = trim((string)strtok(ltrim($request_path, '/'), '/'));

    if ($first_segment !== '') {
        foreach ($languages as $folder_key => $meta) {
            $lang_code = isset($meta['code']) ? strtolower(trim((string)$meta['code'])) : '';
            if ($lang_code && $lang_code === strtolower($first_segment)) {
                $path_lang_folder = $folder_key;
                break;
            }
        }
    }

    if (isset($_GET['site_lang']) && $_GET['site_lang'] !== '') {
        $request_lang = totranslit($_GET['site_lang'], false, false);

        if (isset($languages[$request_lang])) {
            $active_folder = $request_lang;
        } else {
            $active_folder = dle_ml_folder_from_code($request_lang);
        }
    }

    if (!$active_folder && $path_lang_folder && isset($languages[$path_lang_folder])) {
        $active_folder = $path_lang_folder;
    }

    if (!$active_folder && dle_ml_feature_enabled($config_data)) {
        // In prefix mode, URLs without a language segment must always resolve to main language.
        // This guarantees reliable return to main language via root URL (/).
        $active_folder = $main_folder;
    }

    if (!$active_folder && $allow_cookie && isset($_COOKIE['site_language']) && $_COOKIE['site_language']) {
        $cookie_folder = totranslit($_COOKIE['site_language'], false, false);
        if (isset($languages[$cookie_folder])) {
            $active_folder = $cookie_folder;
        }
    }

    if (!$active_folder && $allow_cookie && isset($_COOKIE['site_lang']) && $_COOKIE['site_lang']) {
        $cookie_code = totranslit($_COOKIE['site_lang'], false, false);
        $active_folder = dle_ml_folder_from_code($cookie_code);
    }

    if (!$active_folder || !isset($languages[$active_folder])) {
        $active_folder = $main_folder;
    }

    if (!isset($languages[$active_folder])) {
        $active_folder = dle_ml_main_folder($config_data);
    }

    $active_code = dle_ml_code_from_folder_name($active_folder);

    $GLOBALS['dle_languages'] = $languages;
    $GLOBALS['dle_main_language'] = $main_folder;
    $GLOBALS['dle_active_language'] = $active_folder;
    $GLOBALS['dle_active_language_code'] = $active_code;

    $config_data['main_language'] = $main_folder;
    $config_data['active_language'] = $active_folder;
    $config_data['active_language_code'] = $active_code;

    if ($allow_cookie) {
        if (!isset($_COOKIE['site_language']) || $_COOKIE['site_language'] != $active_folder) {
            set_cookie('site_language', $active_folder, 365);
        }

        if (!isset($_COOKIE['site_lang']) || $_COOKIE['site_lang'] != $active_code) {
            set_cookie('site_lang', $active_code, 365);
        }
    }

    return $active_folder;
}

function dle_ml_base_home_url($config_data) {
    $home = isset($config_data['http_home_url']) ? trim((string)$config_data['http_home_url']) : '/';

    if (!$home) $home = '/';

    if (substr($home, -1) != '/') {
        $home .= '/';
    }

    return $home;
}

function dle_ml_prefix_mode($config_data = array()) {
    if (isset($config_data['multilanguage_prefix'])) {
        return intval($config_data['multilanguage_prefix']) ? 1 : 0;
    }

    return 1;
}

function dle_ml_feature_enabled($config_data = array()) {
    return dle_ml_prefix_mode($config_data) ? true : false;
}

function dle_ml_admin_languages($config_data = array(), $ordered = true) {
    $main = dle_ml_main_folder($config_data);
    $list = $ordered ? dle_ml_ordered_languages($main) : dle_ml_get_languages();

    if (dle_ml_feature_enabled($config_data)) {
        return $list;
    }

    if (isset($list[$main])) {
        return array($main => $list[$main]);
    }

    foreach ($list as $folder => $meta) {
        return array($folder => $meta);
    }

    return array();
}

function dle_ml_should_prefix_code($code, $config_data = array()) {
    $code = strtolower(trim((string)$code));
    if (!$code) return false;

    if (!dle_ml_prefix_mode($config_data)) return false;

    $main_code = dle_ml_main_lang_code($config_data);
    if (!$main_code) return false;

    return ($code !== strtolower($main_code));
}

function dle_ml_language_base_url($lang_code, $config_data = array()) {
    $base = isset($config_data['http_home_url_base']) ? $config_data['http_home_url_base'] : dle_ml_base_home_url($config_data);

    if (dle_ml_should_prefix_code($lang_code, $config_data)) {
        return $base . $lang_code . '/';
    }

    return $base;
}

function dle_ml_prepare_home_url(&$config_data) {
    $base_home = dle_ml_base_home_url($config_data);

    $active_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config_data);
    $active_code = dle_ml_code_from_folder_name($active_folder);

    $config_data['http_home_url_base'] = $base_home;
    $config_data['http_home_url_lang'] = dle_ml_language_base_url($active_code, $config_data);

    $config_data['http_home_url'] = $config_data['http_home_url_lang'];

    return $config_data['http_home_url'];
}

function dle_ml_current_url_no_lang_prefix() {
    $uri = isset($_SERVER['REQUEST_URI']) ? (string)$_SERVER['REQUEST_URI'] : '/';
    $uri = str_replace("\0", '', $uri);

    $path = parse_url($uri, PHP_URL_PATH);
    $query = parse_url($uri, PHP_URL_QUERY);

    if (!$path) $path = '/';

    $codes = array();
    $languages = dle_ml_get_languages();

    foreach ($languages as $meta) {
        if (!isset($meta['code'])) continue;
        $code = strtolower(trim((string)$meta['code']));
        if (!$code) continue;
        $codes[$code] = $code;
    }

    if (count($codes)) {
        $quoted = array();
        foreach ($codes as $code) {
            $quoted[] = preg_quote($code, '#');
        }

        $path = preg_replace('#^/(' . implode('|', $quoted) . ')(/|$)#i', '/', $path);
    }

    $path = preg_replace('#/+#', '/', $path);

    if ($path == '') $path = '/';

    if ($query) {
        parse_str($query, $query_arr);
        unset($query_arr['site_lang']);
        $query = http_build_query($query_arr);
        if ($query) {
            return $path . '?' . $query;
        }
    }

    return $path;
}

function dle_ml_url_for_code($code, $relative = '') {
    global $config;

    if (!$relative) {
        $relative = dle_ml_current_url_no_lang_prefix();
    }

    $base = dle_ml_language_base_url($code, $config);

    $relative = ltrim($relative, '/');

    if ($relative) {
        return $base . $relative;
    }

    return $base;
}

function dle_ml_front_switcher_markup() {
    global $config;

    if (!dle_ml_feature_enabled($config)) return '';

    $languages = dle_ml_get_languages();
    $active_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : '';
    $active_code = isset($GLOBALS['dle_active_language_code']) ? $GLOBALS['dle_active_language_code'] : '';

    if (!count($languages)) return '';

    $items = array();

    foreach ($languages as $folder => $meta) {
        $code = $meta['code'];
        $title = htmlspecialchars($meta['title'], ENT_QUOTES, 'UTF-8');
        $icon = '';

        if (!empty($meta['icon']) && file_exists(ROOT_DIR . '/language/' . $folder . '/' . $meta['icon'])) {
            $icon_file = htmlspecialchars($meta['icon'], ENT_QUOTES, 'UTF-8');
            $icon = '<img src="/language/' . $folder . '/' . $icon_file . '" alt="' . $title . '">';
        }

        $active = ($folder == $active_folder) ? ' class="active"' : '';
        $url = htmlspecialchars(dle_ml_url_for_code($code), ENT_QUOTES, 'UTF-8');

        $items[] = '<li' . $active . '><a href="' . $url . '" hreflang="' . $code . '">' . $icon . '<span>' . $title . '</span></a></li>';
    }

    $active_icon = '';
    if ($active_folder && isset($languages[$active_folder]) && !empty($languages[$active_folder]['icon']) && file_exists(ROOT_DIR . '/language/' . $active_folder . '/' . $languages[$active_folder]['icon'])) {
        $active_icon_file = htmlspecialchars($languages[$active_folder]['icon'], ENT_QUOTES, 'UTF-8');
        $active_icon = '<img src="/language/' . $active_folder . '/' . $active_icon_file . '" alt="' . htmlspecialchars($languages[$active_folder]['title'], ENT_QUOTES, 'UTF-8') . '">';
    }

    if (!$active_code && $active_folder) {
        $active_code = dle_ml_code_from_folder_name($active_folder);
    }

    $active_code = htmlspecialchars(strtoupper($active_code), ENT_QUOTES, 'UTF-8');

    $items_html = implode('', $items);
    $fallback_html = '<div class="ml-switcher"><button type="button" class="ml-switcher__btn">' . $active_icon . '<span>' . $active_code . '</span></button><ul class="ml-switcher__menu">' . $items_html . '</ul></div>';

    $skin = isset($config['skin']) ? trim((string)$config['skin']) : '';
    if (!$skin) return $fallback_html;

    $template_file = ROOT_DIR . '/templates/' . $skin . '/multilanguage.tpl';

    if (!file_exists($template_file)) return $fallback_html;

    $template = @file_get_contents($template_file);
    if ($template === false || $template === '') return $fallback_html;

    $template = str_replace('{active_icon}', $active_icon, $template);
    $template = str_replace('{active_code}', $active_code, $template);
    $template = str_replace('{items}', $items_html, $template);

    return $template;
}

function dle_ml_load_website_lang($folder) {
    global $lang;

    $folder = totranslit($folder, false, false);

    if (!$folder) return;

    if (file_exists(DLEPlugins::Check(ROOT_DIR . '/language/' . $folder . '/website.lng'))) {
        include_once (DLEPlugins::Check(ROOT_DIR . '/language/' . $folder . '/website.lng'));
    }

    if (file_exists(DLEPlugins::Check(ROOT_DIR . '/language/' . $folder . '/template_language.lng'))) {
        $website_lang = (is_array($lang) ? $lang : array());
        include_once (DLEPlugins::Check(ROOT_DIR . '/language/' . $folder . '/template_language.lng'));
        $template_lang = (is_array($lang) ? $lang : array());
        $lang = array_merge($website_lang, $template_lang);
    }
}

function dle_ml_table_exists($table_suffix) {
    global $db;

    if (!isset($GLOBALS['dle_ml_table_exists_cache']) || !is_array($GLOBALS['dle_ml_table_exists_cache'])) {
        $GLOBALS['dle_ml_table_exists_cache'] = array();
    }
    $cache = &$GLOBALS['dle_ml_table_exists_cache'];

    if (isset($cache[$table_suffix])) {
        return $cache[$table_suffix];
    }

    $table_name = PREFIX . '_' . $table_suffix;
    $safe_name = $db->safesql($table_name);

    $result = $db->query("SHOW TABLES LIKE '{$safe_name}'", false, true);

    if ($result instanceof mysqli_result) {
        $cache[$table_suffix] = ($result->num_rows > 0);
        $result->close();
    } else {
        $cache[$table_suffix] = false;
    }

    return $cache[$table_suffix];
}

function dle_ml_table_column_exists($table_suffix, $column_name) {
    global $db;

    if (!isset($GLOBALS['dle_ml_table_column_cache']) || !is_array($GLOBALS['dle_ml_table_column_cache'])) {
        $GLOBALS['dle_ml_table_column_cache'] = array();
    }

    $table_suffix = trim((string)$table_suffix);
    $column_name = trim((string)$column_name);
    $cache_key = $table_suffix . ':' . $column_name;

    if (isset($GLOBALS['dle_ml_table_column_cache'][$cache_key])) {
        return $GLOBALS['dle_ml_table_column_cache'][$cache_key];
    }

    if (!$table_suffix || !$column_name || !dle_ml_table_exists($table_suffix)) {
        $GLOBALS['dle_ml_table_column_cache'][$cache_key] = false;
        return false;
    }

    $table_name = PREFIX . '_' . $table_suffix;
    $safe_table = $db->safesql($table_name);
    $safe_column = $db->safesql($column_name);

    $result = $db->query("SHOW COLUMNS FROM `{$safe_table}` LIKE '{$safe_column}'", false, true);

    if ($result instanceof mysqli_result) {
        $exists = ($result->num_rows > 0);
        $result->close();
    } else {
        $exists = false;
    }

    $GLOBALS['dle_ml_table_column_cache'][$cache_key] = $exists;

    return $exists;
}

function dle_ml_table_cache_reset($table_suffix = '') {
    if (!isset($GLOBALS['dle_ml_table_exists_cache']) || !is_array($GLOBALS['dle_ml_table_exists_cache'])) return;

    if ($table_suffix) {
        unset($GLOBALS['dle_ml_table_exists_cache'][$table_suffix]);
    } else {
        $GLOBALS['dle_ml_table_exists_cache'] = array();
    }

    if (isset($GLOBALS['dle_ml_table_column_cache']) && is_array($GLOBALS['dle_ml_table_column_cache'])) {
        if ($table_suffix) {
            foreach ($GLOBALS['dle_ml_table_column_cache'] as $cache_key => $cache_val) {
                if (strpos($cache_key, $table_suffix . ':') === 0) {
                    unset($GLOBALS['dle_ml_table_column_cache'][$cache_key]);
                }
            }
        } else {
            $GLOBALS['dle_ml_table_column_cache'] = array();
        }
    }
}

function dle_ml_install_schema($main_folder = '') {
    global $db, $config;

    static $installed = false;
    if ($installed) return;
    $installed = true;

    if (!$main_folder) {
        $main_folder = dle_ml_main_folder($config);
    }

    $table_post = PREFIX . "_post_i18n";
    $table_post_xfields = PREFIX . "_post_xfields_i18n";
    $table_category = PREFIX . "_category_i18n";
    $table_static = PREFIX . "_static_i18n";
    $table_settings = PREFIX . "_settings_i18n";

    $db->query("CREATE TABLE IF NOT EXISTS `{$table_post}` (
        `news_id` int(11) unsigned NOT NULL,
        `lang` varchar(32) NOT NULL,
        `title` varchar(255) NOT NULL DEFAULT '',
        `alt_name` varchar(255) NOT NULL DEFAULT '',
        `short_story` mediumtext NOT NULL,
        `full_story` mediumtext NOT NULL,
        `descr` varchar(300) NOT NULL DEFAULT '',
        `keywords` text NOT NULL,
        `metatitle` varchar(300) NOT NULL DEFAULT '',
        `tags` text NOT NULL,
        PRIMARY KEY (`news_id`,`lang`),
        KEY `lang` (`lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", false, true);

    $db->query("CREATE TABLE IF NOT EXISTS `{$table_post_xfields}` (
        `news_id` int(11) unsigned NOT NULL,
        `lang` varchar(32) NOT NULL,
        `xfields` mediumtext NOT NULL,
        PRIMARY KEY (`news_id`,`lang`),
        KEY `lang` (`lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", false, true);

    $db->query("CREATE TABLE IF NOT EXISTS `{$table_category}` (
        `category_id` int(11) unsigned NOT NULL,
        `lang` varchar(32) NOT NULL,
        `name` varchar(100) NOT NULL DEFAULT '',
        `alt_name` varchar(255) NOT NULL DEFAULT '',
        `descr` varchar(300) NOT NULL DEFAULT '',
        `keywords` text NOT NULL,
        `metatitle` varchar(300) NOT NULL DEFAULT '',
        `fulldescr` mediumtext NOT NULL,
        PRIMARY KEY (`category_id`,`lang`),
        KEY `lang` (`lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", false, true);

    $db->query("CREATE TABLE IF NOT EXISTS `{$table_static}` (
        `static_id` int(11) unsigned NOT NULL,
        `lang` varchar(32) NOT NULL,
        `name` varchar(255) NOT NULL DEFAULT '',
        `descr` varchar(255) NOT NULL DEFAULT '',
        `template` mediumtext NOT NULL,
        `metadescr` varchar(300) NOT NULL DEFAULT '',
        `metakeys` text NOT NULL,
        `metatitle` varchar(300) NOT NULL DEFAULT '',
        PRIMARY KEY (`static_id`,`lang`),
        KEY `lang` (`lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", false, true);

    $db->query("CREATE TABLE IF NOT EXISTS `{$table_settings}` (
        `setting_key` varchar(100) NOT NULL,
        `lang` varchar(32) NOT NULL,
        `setting_value` mediumtext NOT NULL,
        PRIMARY KEY (`setting_key`,`lang`),
        KEY `lang` (`lang`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", false, true);

    dle_ml_table_cache_reset();

    if (!dle_ml_table_exists('post_i18n') || !dle_ml_table_exists('post_xfields_i18n') || !dle_ml_table_exists('category_i18n') || !dle_ml_table_exists('static_i18n') || !dle_ml_table_exists('settings_i18n')) {
        return;
    }

    if (!dle_ml_table_column_exists('post_i18n', 'alt_name')) {
        $db->query("ALTER TABLE {$table_post} ADD COLUMN alt_name varchar(255) NOT NULL DEFAULT '' AFTER title", false, true);
    }
    if (!dle_ml_table_column_exists('category_i18n', 'alt_name')) {
        $db->query("ALTER TABLE {$table_category} ADD COLUMN alt_name varchar(255) NOT NULL DEFAULT '' AFTER name", false, true);
    }
    if (!dle_ml_table_column_exists('static_i18n', 'name')) {
        $db->query("ALTER TABLE {$table_static} ADD COLUMN name varchar(255) NOT NULL DEFAULT '' AFTER lang", false, true);
    }
    dle_ml_table_cache_reset();

    $safe_main = $db->safesql($main_folder);

    $db->query("INSERT INTO {$table_post} (news_id, lang, title, alt_name, short_story, full_story, descr, keywords, metatitle, tags)
        SELECT p.id, '{$safe_main}', p.title, p.alt_name, p.short_story, p.full_story, p.descr, p.keywords, p.metatitle, p.tags
        FROM " . PREFIX . "_post p
        LEFT JOIN {$table_post} t ON (t.news_id = p.id AND t.lang = '{$safe_main}')
        WHERE t.news_id IS NULL", false, true);

    $db->query("INSERT INTO {$table_post_xfields} (news_id, lang, xfields)
        SELECT p.id, '{$safe_main}', p.xfields
        FROM " . PREFIX . "_post p
        LEFT JOIN {$table_post_xfields} t ON (t.news_id = p.id AND t.lang = '{$safe_main}')
        WHERE t.news_id IS NULL", false, true);

    $db->query("INSERT INTO {$table_category} (category_id, lang, name, alt_name, descr, keywords, metatitle, fulldescr)
        SELECT c.id, '{$safe_main}', c.name, c.alt_name, c.descr, c.keywords, c.metatitle, c.fulldescr
        FROM " . PREFIX . "_category c
        LEFT JOIN {$table_category} t ON (t.category_id = c.id AND t.lang = '{$safe_main}')
        WHERE t.category_id IS NULL", false, true);

    if (dle_ml_table_column_exists('static_i18n', 'name')) {
        $db->query("INSERT INTO {$table_static} (static_id, lang, name, descr, template, metadescr, metakeys, metatitle)
            SELECT s.id, '{$safe_main}', s.name, s.descr, s.template, s.metadescr, s.metakeys, s.metatitle
            FROM " . PREFIX . "_static s
            LEFT JOIN {$table_static} t ON (t.static_id = s.id AND t.lang = '{$safe_main}')
            WHERE t.static_id IS NULL", false, true);
    } else {
        $db->query("INSERT INTO {$table_static} (static_id, lang, descr, template, metadescr, metakeys, metatitle)
            SELECT s.id, '{$safe_main}', s.descr, s.template, s.metadescr, s.metakeys, s.metatitle
            FROM " . PREFIX . "_static s
            LEFT JOIN {$table_static} t ON (t.static_id = s.id AND t.lang = '{$safe_main}')
            WHERE t.static_id IS NULL", false, true);
    }

    $base_settings = array(
        'home_title' => isset($config['home_title']) ? $config['home_title'] : '',
        'short_title' => isset($config['short_title']) ? $config['short_title'] : '',
    );

    foreach ($base_settings as $setting_key => $setting_value) {
        $safe_key = $db->safesql($setting_key);
        $safe_val = $db->safesql((string)$setting_value);
        $db->query("INSERT INTO {$table_settings} (setting_key, lang, setting_value) VALUES ('{$safe_key}', '{$safe_main}', '{$safe_val}') ON DUPLICATE KEY UPDATE setting_value=IF(setting_value='', '{$safe_val}', setting_value)", false, true);
    }
}

function dle_ml_bootstrap($config_data = array()) {
    $main_folder = dle_ml_main_folder($config_data);
    dle_ml_install_schema($main_folder);
}

function dle_ml_get_post_translation($news_id, $lang_folder = '', $fallback = true) {
    global $db, $config;

    $news_id = intval($news_id);
    if ($news_id < 1) return array();

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    static $cache = array();
    $cache_key = $news_id . ':' . $lang_folder . ':' . intval($fallback);

    if (isset($cache[$cache_key])) return $cache[$cache_key];

    if (!dle_ml_table_exists('post_i18n')) {
        $cache[$cache_key] = array();
        return array();
    }

    $safe_lang = $db->safesql($lang_folder);
    $row = $db->super_query("SELECT * FROM " . PREFIX . "_post_i18n WHERE news_id='{$news_id}' AND lang='{$safe_lang}'");

    if (!$fallback || (isset($row['news_id']) && $row['news_id'])) {
        $cache[$cache_key] = is_array($row) ? $row : array();
        return $cache[$cache_key];
    }

    $main_folder = dle_ml_main_folder($config);

    if ($main_folder != $lang_folder) {
        $safe_main = $db->safesql($main_folder);
        $row = $db->super_query("SELECT * FROM " . PREFIX . "_post_i18n WHERE news_id='{$news_id}' AND lang='{$safe_main}'");
    }

    $cache[$cache_key] = is_array($row) ? $row : array();

    return $cache[$cache_key];
}

function dle_ml_apply_post_translation(&$row, $lang_folder = '') {
    global $config;

    if (!is_array($row) || !isset($row['id'])) return;

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    $main_folder = dle_ml_main_folder($config);

    $target = dle_ml_get_post_translation($row['id'], $lang_folder, false);
    $main = ($main_folder != $lang_folder) ? dle_ml_get_post_translation($row['id'], $main_folder, false) : $target;

    $fields = array('title', 'alt_name', 'short_story', 'full_story', 'descr', 'keywords', 'metatitle', 'tags');

    foreach ($fields as $field) {
        if (isset($target[$field]) && trim((string)$target[$field]) !== '') {
            $row[$field] = $target[$field];
        } elseif (isset($main[$field]) && trim((string)$main[$field]) !== '') {
            $row[$field] = $main[$field];
        }
    }
}

function dle_ml_apply_static_translation(&$row, $lang_folder = '') {
    global $db, $config;

    if (!is_array($row) || !isset($row['id']) || !dle_ml_table_exists('static_i18n')) return;

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    $main_folder = dle_ml_main_folder($config);

    $safe_lang = $db->safesql($lang_folder);
    $target = $db->super_query("SELECT * FROM " . PREFIX . "_static_i18n WHERE static_id='" . intval($row['id']) . "' AND lang='{$safe_lang}'");

    $main = array();
    if ($main_folder != $lang_folder) {
        $safe_main = $db->safesql($main_folder);
        $main = $db->super_query("SELECT * FROM " . PREFIX . "_static_i18n WHERE static_id='" . intval($row['id']) . "' AND lang='{$safe_main}'");
    } else {
        $main = $target;
    }

    $fields = array('name', 'descr', 'template', 'metadescr', 'metakeys', 'metatitle');

    foreach ($fields as $field) {
        if (isset($target[$field]) && trim((string)$target[$field]) !== '') {
            $row[$field] = $target[$field];
        } elseif (isset($main[$field]) && trim((string)$main[$field]) !== '') {
            $row[$field] = $main[$field];
        }
    }
}

function dle_ml_localize_categories(&$cat_info, $lang_folder = '') {
    global $db, $config;

    if (!is_array($cat_info) || !count($cat_info) || !dle_ml_table_exists('category_i18n')) return;

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    $main_folder = dle_ml_main_folder($config);

    $safe_lang = $db->safesql($lang_folder);
    $safe_main = $db->safesql($main_folder);

    $rows = array();

    $query = "SELECT * FROM " . PREFIX . "_category_i18n WHERE lang IN ('{$safe_lang}', '{$safe_main}')";
    $result = $db->query($query);

    while ($row = $db->get_row($result)) {
        $cid = intval($row['category_id']);
        if (!$cid) continue;

        if (!isset($rows[$cid])) $rows[$cid] = array();
        $rows[$cid][$row['lang']] = $row;
    }

    $db->free($result);

    $fields = array('name', 'alt_name', 'descr', 'keywords', 'metatitle', 'fulldescr');

    foreach ($cat_info as $cid => $cat) {
        $cid = intval($cid);
        if (!$cid || !isset($rows[$cid])) continue;

        $target = isset($rows[$cid][$lang_folder]) ? $rows[$cid][$lang_folder] : array();
        $main = isset($rows[$cid][$main_folder]) ? $rows[$cid][$main_folder] : array();

        foreach ($fields as $field) {
            if (isset($target[$field]) && trim((string)$target[$field]) !== '') {
                $cat_info[$cid][$field] = $target[$field];
            } elseif (isset($main[$field]) && trim((string)$main[$field]) !== '') {
                $cat_info[$cid][$field] = $main[$field];
            }
        }
    }
}

function dle_ml_get_setting_translations($setting_key) {
    global $db;

    $result_data = array();

    if (!dle_ml_table_exists('settings_i18n')) return $result_data;

    $setting_key = trim((string)$setting_key);
    if (!$setting_key) return $result_data;

    $safe_key = $db->safesql($setting_key);
    $result = $db->query("SELECT lang, setting_value FROM " . PREFIX . "_settings_i18n WHERE setting_key='{$safe_key}'");

    while ($row = $db->get_row($result)) {
        $result_data[$row['lang']] = $row['setting_value'];
    }

    $db->free($result);

    return $result_data;
}

function dle_ml_get_setting_value($setting_key, $lang_folder = '', $fallback = '') {
    global $config;

    $values = dle_ml_get_setting_translations($setting_key);

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    if (isset($values[$lang_folder]) && trim((string)$values[$lang_folder]) !== '') {
        return $values[$lang_folder];
    }

    $main_folder = dle_ml_main_folder($config);
    if (isset($values[$main_folder]) && trim((string)$values[$main_folder]) !== '') {
        return $values[$main_folder];
    }

    return $fallback;
}

function dle_ml_set_setting_translations($setting_key, $values = array()) {
    global $db;

    if (!is_array($values) || !count($values) || !dle_ml_table_exists('settings_i18n')) return;

    $languages = dle_ml_get_languages();
    $setting_key = $db->safesql(trim((string)$setting_key));

    foreach ($values as $folder => $value) {
        if (!isset($languages[$folder])) continue;

        $safe_lang = $db->safesql($folder);
        $safe_val = $db->safesql((string)$value);

        $db->query("INSERT INTO " . PREFIX . "_settings_i18n (setting_key, lang, setting_value) VALUES ('{$setting_key}', '{$safe_lang}', '{$safe_val}') ON DUPLICATE KEY UPDATE setting_value='{$safe_val}'");
    }
}

function dle_ml_save_post_translation($news_id, $lang_folder, $data = array()) {
    global $db;

    if (!dle_ml_table_exists('post_i18n')) return;

    $news_id = intval($news_id);
    if ($news_id < 1) return;

    $languages = dle_ml_get_languages();
    if (!isset($languages[$lang_folder])) return;

    $safe_lang = $db->safesql($lang_folder);

    $title = isset($data['title']) ? $db->safesql($data['title']) : '';
    $alt_name_raw = isset($data['alt_name']) ? trim((string)$data['alt_name']) : '';
    if (!$alt_name_raw && isset($data['title']) && trim((string)$data['title']) !== '') {
        $alt_name_raw = totranslit((string)$data['title'], true, false);
    }
    $alt_name = $db->safesql($alt_name_raw);
    $short_story = isset($data['short_story']) ? $db->safesql($data['short_story']) : '';
    $full_story = isset($data['full_story']) ? $db->safesql($data['full_story']) : '';
    $descr = isset($data['descr']) ? $db->safesql($data['descr']) : '';
    $keywords = isset($data['keywords']) ? $db->safesql($data['keywords']) : '';
    $metatitle = isset($data['metatitle']) ? $db->safesql($data['metatitle']) : '';
    $tags = isset($data['tags']) ? $db->safesql($data['tags']) : '';

    $db->query("INSERT INTO " . PREFIX . "_post_i18n (news_id, lang, title, alt_name, short_story, full_story, descr, keywords, metatitle, tags) VALUES ('{$news_id}', '{$safe_lang}', '{$title}', '{$alt_name}', '{$short_story}', '{$full_story}', '{$descr}', '{$keywords}', '{$metatitle}', '{$tags}') ON DUPLICATE KEY UPDATE title='{$title}', alt_name='{$alt_name}', short_story='{$short_story}', full_story='{$full_story}', descr='{$descr}', keywords='{$keywords}', metatitle='{$metatitle}', tags='{$tags}'");
}

function dle_ml_save_post_xfields_translation($news_id, $lang_folder, $xfields_raw = '') {
    global $db;

    if (!dle_ml_table_exists('post_xfields_i18n')) return;

    $news_id = intval($news_id);
    if ($news_id < 1) return;

    $languages = dle_ml_get_languages();
    if (!isset($languages[$lang_folder])) return;

    $safe_lang = $db->safesql($lang_folder);
    $safe_xfields = $db->safesql((string)$xfields_raw);

    $db->query("INSERT INTO " . PREFIX . "_post_xfields_i18n (news_id, lang, xfields) VALUES ('{$news_id}', '{$safe_lang}', '{$safe_xfields}') ON DUPLICATE KEY UPDATE xfields='{$safe_xfields}'");
}

function dle_ml_get_post_xfields_translation($news_id, $lang_folder = '', $fallback = true) {
    global $db, $config;

    $news_id = intval($news_id);
    if ($news_id < 1) return '';
    if (!dle_ml_table_exists('post_xfields_i18n')) return '';

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    static $cache = array();
    $cache_key = $news_id . ':' . $lang_folder . ':' . intval($fallback);

    if (isset($cache[$cache_key])) return $cache[$cache_key];

    $safe_lang = $db->safesql($lang_folder);
    $row = $db->super_query("SELECT xfields FROM " . PREFIX . "_post_xfields_i18n WHERE news_id='{$news_id}' AND lang='{$safe_lang}'");

    if (isset($row['xfields']) && $row['xfields'] !== '') {
        $cache[$cache_key] = $row['xfields'];
        return $cache[$cache_key];
    }

    if (!$fallback) {
        $cache[$cache_key] = '';
        return '';
    }

    $main_folder = dle_ml_main_folder($config);
    if ($main_folder != $lang_folder) {
        $safe_main = $db->safesql($main_folder);
        $row = $db->super_query("SELECT xfields FROM " . PREFIX . "_post_xfields_i18n WHERE news_id='{$news_id}' AND lang='{$safe_main}'");
        if (isset($row['xfields']) && $row['xfields'] !== '') {
            $cache[$cache_key] = $row['xfields'];
            return $cache[$cache_key];
        }
    }

    $cache[$cache_key] = '';
    return '';
}

function dle_ml_get_post_xfields_translations($news_id) {
    global $db, $config;

    $news_id = intval($news_id);
    $languages = dle_ml_get_languages();
    $main_folder = dle_ml_main_folder($config);
    $result_data = array();

    foreach ($languages as $folder => $meta) {
        $result_data[$folder] = '';
    }

    if ($news_id < 1 || !dle_ml_table_exists('post_xfields_i18n')) {
        return $result_data;
    }

    $result = $db->query("SELECT lang, xfields FROM " . PREFIX . "_post_xfields_i18n WHERE news_id='{$news_id}'");

    while ($row = $db->get_row($result)) {
        $folder = $row['lang'];
        if (isset($result_data[$folder])) {
            $result_data[$folder] = isset($row['xfields']) ? $row['xfields'] : '';
        }
    }

    $db->free($result);

    if (isset($result_data[$main_folder])) {
        foreach ($result_data as $folder => $value) {
            if ($folder == $main_folder) continue;
            if (trim((string)$value) === '') {
                $result_data[$folder] = $result_data[$main_folder];
            }
        }
    }

    return $result_data;
}

function dle_ml_apply_post_xfields_translation(&$row, $lang_folder = '') {
    global $config;

    if (!is_array($row) || !isset($row['id'])) return;

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    $translated_xfields = dle_ml_get_post_xfields_translation($row['id'], $lang_folder, true);
    if ($translated_xfields !== '') {
        $row['xfields'] = $translated_xfields;
    }
}

function dle_ml_xfields_translation_definitions() {
    if (!function_exists('xfieldsload')) return array();

    $defs = xfieldsload();
    if (!is_array($defs) || !count($defs)) return array();

    $allowed = array('text', 'textarea', 'select');
    $prepared = array();

    foreach ($defs as $def) {
        if (!isset($def[0]) || !isset($def[3])) continue;
        $name = totranslit(trim((string)$def[0]));
        $type = trim((string)$def[3]);
        if (!$name || !in_array($type, $allowed)) continue;
        $def[0] = $name;
        $prepared[] = $def;
    }

    return $prepared;
}

function dle_ml_xfields_select_options_string($def, $lang_folder = '') {
    global $config;

    $default_options = isset($def[4]) ? (string)$def[4] : '';

    if (!isset($def[40]) || trim((string)$def[40]) === '') {
        return $default_options;
    }

    $i18n = json_decode((string)$def[40], true);
    if (!is_array($i18n) || !count($i18n)) {
        return $default_options;
    }

    if (!$lang_folder) {
        $lang_folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config);
    }

    if (isset($i18n[$lang_folder]) && trim((string)$i18n[$lang_folder]) !== '') {
        return (string)$i18n[$lang_folder];
    }

    $main_folder = dle_ml_main_folder($config);
    if (isset($i18n[$main_folder]) && trim((string)$i18n[$main_folder]) !== '') {
        return (string)$i18n[$main_folder];
    }

    return $default_options;
}

function dle_ml_xfields_build_string($posted = array(), $category = '', $existing_raw = '', $parse_obj = null) {
    $defs = dle_ml_xfields_translation_definitions();
    if (!count($defs)) return '';

    $existing = is_string($existing_raw) && $existing_raw !== '' && function_exists('xfieldsdataload') ? xfieldsdataload($existing_raw) : array();
    $posted = is_array($posted) ? $posted : array();
    $categories = array_filter(array_map('intval', explode(',', (string)$category)));
    $rows = array();

    foreach ($defs as $def) {
        $name = $def[0];
        $type = isset($def[3]) ? $def[3] : '';
        $cat_limit = isset($def[2]) ? trim((string)$def[2]) : '';

        if ($cat_limit && count($categories)) {
            $allowed_cats = array_filter(array_map('intval', explode(',', $cat_limit)));
            if (count($allowed_cats) && !count(array_intersect($categories, $allowed_cats))) continue;
        }

        $has_posted_value = array_key_exists($name, $posted);
        $value_raw = $has_posted_value ? $posted[$name] : (isset($existing[$name]) ? $existing[$name] : '');

        if ($type === 'select') {
            $selected = array();
            if (is_array($value_raw)) {
                $selected = $value_raw;
            } elseif (is_string($value_raw) && $value_raw !== '') {
                $selected = explode(',', $value_raw);
            }

            $result_values = array();
            foreach ($selected as $item) {
                $item = trim((string)$item);
                if ($item === '') continue;
                $item = str_replace(',', '&#x2C;', $item);
                $result_values[$item] = true;
            }

            $value = implode(',', array_keys($result_values));
        } else {
            $value = is_array($value_raw) ? '' : (string)$value_raw;
            $value = trim($value);

            if ($value !== '' && is_object($parse_obj) && method_exists($parse_obj, 'process') && method_exists($parse_obj, 'BB_Parse')) {
                $value = $parse_obj->BB_Parse($parse_obj->process($value));
            }

            if ($type === 'textarea' && $value === '<p><br></p>') {
                $value = '';
            }
        }

        if ($value === '') continue;

        $value = str_ireplace("{title", "&#123;title", $value);
        $value = str_ireplace("{short-story", "&#123;short-story", $value);
        $value = str_ireplace("{full-story", "&#123;full-story", $value);

        $safe_name = str_replace(array("|", "\r\n"), array("&#124;", "__NEWL__"), $name);
        $safe_value = str_replace(array("|", "\r\n"), array("&#124;", "__NEWL__"), $value);

        $rows[] = $safe_name . "|" . $safe_value;
    }

    return implode("||", $rows);
}

function dle_ml_render_xfields_translation_inputs($lang_folder, $values = array()) {
    global $lang;

    $defs = dle_ml_xfields_translation_definitions();
    if (!count($defs)) return '';

    $values = is_array($values) ? $values : array();
    $folder_safe = htmlspecialchars((string)$lang_folder, ENT_QUOTES, 'UTF-8');
    $title = isset($lang['xfield_xlist']) ? $lang['xfield_xlist'] : 'Extra Fields';
    $html = '<div class="form-group"><label class="control-label col-md-2 col-sm-3">' . htmlspecialchars($title, ENT_QUOTES, 'UTF-8') . '</label><div class="col-md-10 col-sm-9">';

    foreach ($defs as $def) {
        $field_name = $def[0];
        $field_type = isset($def[3]) ? $def[3] : 'text';
        $field_title = isset($def[1]) ? $def[1] : $field_name;

        $field_title_safe = htmlspecialchars((string)$field_title, ENT_QUOTES, 'UTF-8');
        $field_name_safe = htmlspecialchars((string)$field_name, ENT_QUOTES, 'UTF-8');
        $input_name = "translations[{$folder_safe}][xfields][{$field_name_safe}]";
        $current = isset($values[$field_name]) ? (string)$values[$field_name] : '';

        $html .= '<div style="margin-bottom:10px;"><div class="text-muted text-size-small" style="margin-bottom:4px;">' . $field_title_safe . '</div>';

        if ($field_type === 'textarea') {
            $current_safe = htmlspecialchars($current, ENT_QUOTES, 'UTF-8');
            $html .= '<textarea dir="auto" class="classic form-control" style="max-width:700px;height:90px;" name="' . $input_name . '">' . $current_safe . '</textarea>';
        } elseif ($field_type === 'select') {
            $is_multi = !empty($def[34]);
            $selected_values = array();

            if ($current !== '') {
                foreach (explode(',', str_replace(array('&amp;#x2C;', '&#x2C;'), ',', $current)) as $part) {
                    $part = trim((string)$part);
                    if ($part !== '') $selected_values[$part] = true;
                }
            }

            $multi_attr = $is_multi ? ' multiple' : '';
            $name_attr = $is_multi ? $input_name . '[]' : $input_name;
            $select_class = $is_multi ? 'categoryselect' : 'uniform';
            $width_style = $is_multi ? ' style="width:100%;max-width:700px;height:120px;"' : ' style="width:100%;max-width:350px;"';

            $html .= '<select name="' . $name_attr . '" class="' . $select_class . '"' . $multi_attr . $width_style . '>';
            $options_raw = dle_ml_xfields_select_options_string($def, $lang_folder);
            $options_raw = str_replace(array("\r\n", "\r"), "\n", (string)$options_raw);
            $options = explode("\n", $options_raw);

            foreach ($options as $raw_opt) {
                $raw_opt = trim((string)$raw_opt);
                if ($raw_opt === '') continue;
                $parts = explode('|', $raw_opt);
                $opt_value = trim((string)$parts[0]);
                $opt_label = isset($parts[1]) ? trim((string)$parts[1]) : $opt_value;
                $sel = isset($selected_values[$opt_value]) ? ' selected' : '';

                $html .= '<option value="' . htmlspecialchars($opt_value, ENT_QUOTES, 'UTF-8') . '"' . $sel . '>' . htmlspecialchars($opt_label, ENT_QUOTES, 'UTF-8') . '</option>';
            }

            $html .= '</select>';
        } else {
            $current_safe = htmlspecialchars($current, ENT_QUOTES, 'UTF-8');
            $html .= '<input type="text" dir="auto" class="form-control" style="max-width:700px;" name="' . $input_name . '" value="' . $current_safe . '">';
        }

        $html .= '</div>';
    }

    $html .= '</div></div>';

    return $html;
}

function dle_ml_save_category_translation($category_id, $lang_folder, $data = array()) {
    global $db;

    if (!dle_ml_table_exists('category_i18n')) return;

    $category_id = intval($category_id);
    if ($category_id < 1) return;

    $languages = dle_ml_get_languages();
    if (!isset($languages[$lang_folder])) return;

    $safe_lang = $db->safesql($lang_folder);

    $name = isset($data['name']) ? $db->safesql($data['name']) : '';
    $alt_name_raw = isset($data['alt_name']) ? trim((string)$data['alt_name']) : '';
    if (!$alt_name_raw && isset($data['name']) && trim((string)$data['name']) !== '') {
        $alt_name_raw = totranslit((string)$data['name'], true, false);
    }
    $alt_name = $db->safesql($alt_name_raw);
    $descr = isset($data['descr']) ? $db->safesql($data['descr']) : '';
    $keywords = isset($data['keywords']) ? $db->safesql($data['keywords']) : '';
    $metatitle = isset($data['metatitle']) ? $db->safesql($data['metatitle']) : '';
    $fulldescr = isset($data['fulldescr']) ? $db->safesql($data['fulldescr']) : '';

    $db->query("INSERT INTO " . PREFIX . "_category_i18n (category_id, lang, name, alt_name, descr, keywords, metatitle, fulldescr) VALUES ('{$category_id}', '{$safe_lang}', '{$name}', '{$alt_name}', '{$descr}', '{$keywords}', '{$metatitle}', '{$fulldescr}') ON DUPLICATE KEY UPDATE name='{$name}', alt_name='{$alt_name}', descr='{$descr}', keywords='{$keywords}', metatitle='{$metatitle}', fulldescr='{$fulldescr}'");
}

function dle_ml_save_static_translation($static_id, $lang_folder, $data = array()) {
    global $db;

    if (!dle_ml_table_exists('static_i18n')) return;

    $static_id = intval($static_id);
    if ($static_id < 1) return;

    $languages = dle_ml_get_languages();
    if (!isset($languages[$lang_folder])) return;

    $safe_lang = $db->safesql($lang_folder);

    $name_raw = isset($data['name']) ? trim((string)$data['name']) : '';
    if (!$name_raw && isset($data['descr']) && trim((string)$data['descr']) !== '') {
        $name_raw = totranslit((string)$data['descr'], true, false);
    }
    $name = $db->safesql($name_raw);
    $descr = isset($data['descr']) ? $db->safesql($data['descr']) : '';
    $template = isset($data['template']) ? $db->safesql($data['template']) : '';
    $metadescr = isset($data['metadescr']) ? $db->safesql($data['metadescr']) : '';
    $metakeys = isset($data['metakeys']) ? $db->safesql($data['metakeys']) : '';
    $metatitle = isset($data['metatitle']) ? $db->safesql($data['metatitle']) : '';

    if (dle_ml_table_column_exists('static_i18n', 'name')) {
        $db->query("INSERT INTO " . PREFIX . "_static_i18n (static_id, lang, name, descr, template, metadescr, metakeys, metatitle) VALUES ('{$static_id}', '{$safe_lang}', '{$name}', '{$descr}', '{$template}', '{$metadescr}', '{$metakeys}', '{$metatitle}') ON DUPLICATE KEY UPDATE name='{$name}', descr='{$descr}', template='{$template}', metadescr='{$metadescr}', metakeys='{$metakeys}', metatitle='{$metatitle}'");
    } else {
        $db->query("INSERT INTO " . PREFIX . "_static_i18n (static_id, lang, descr, template, metadescr, metakeys, metatitle) VALUES ('{$static_id}', '{$safe_lang}', '{$descr}', '{$template}', '{$metadescr}', '{$metakeys}', '{$metatitle}') ON DUPLICATE KEY UPDATE descr='{$descr}', template='{$template}', metadescr='{$metadescr}', metakeys='{$metakeys}', metatitle='{$metatitle}'");
    }
}

function dle_ml_get_post_translations($news_id) {
    global $db, $config;

    $news_id = intval($news_id);
    $languages = dle_ml_get_languages();
    $main_folder = dle_ml_main_folder($config);
    $result_data = array();

    foreach ($languages as $folder => $meta) {
        $result_data[$folder] = array(
            'title' => '',
            'alt_name' => '',
            'short_story' => '',
            'full_story' => '',
            'descr' => '',
            'keywords' => '',
            'metatitle' => '',
            'tags' => '',
        );
    }

    if ($news_id < 1 || !dle_ml_table_exists('post_i18n')) {
        return $result_data;
    }

    $result = $db->query("SELECT * FROM " . PREFIX . "_post_i18n WHERE news_id='{$news_id}'");

    while ($row = $db->get_row($result)) {
        $folder = $row['lang'];
        if (!isset($result_data[$folder])) continue;
        $result_data[$folder] = $row;
    }

    $db->free($result);

    if (isset($result_data[$main_folder])) {
        foreach ($result_data as $folder => $data) {
            if ($folder == $main_folder) continue;
            foreach (array('title', 'alt_name', 'short_story', 'full_story', 'descr', 'keywords', 'metatitle', 'tags') as $field) {
                if (!isset($result_data[$folder][$field]) || trim((string)$result_data[$folder][$field]) === '') {
                    $result_data[$folder][$field] = isset($result_data[$main_folder][$field]) ? $result_data[$main_folder][$field] : '';
                }
            }
        }
    }

    return $result_data;
}

function dle_ml_get_category_translations($category_id) {
    global $db, $config;

    $category_id = intval($category_id);
    $languages = dle_ml_get_languages();
    $main_folder = dle_ml_main_folder($config);
    $result_data = array();

    foreach ($languages as $folder => $meta) {
        $result_data[$folder] = array(
            'name' => '',
            'alt_name' => '',
            'descr' => '',
            'keywords' => '',
            'metatitle' => '',
            'fulldescr' => '',
        );
    }

    if ($category_id < 1 || !dle_ml_table_exists('category_i18n')) {
        return $result_data;
    }

    $result = $db->query("SELECT * FROM " . PREFIX . "_category_i18n WHERE category_id='{$category_id}'");

    while ($row = $db->get_row($result)) {
        $folder = $row['lang'];
        if (!isset($result_data[$folder])) continue;
        $result_data[$folder] = $row;
    }

    $db->free($result);

    if (isset($result_data[$main_folder])) {
        foreach ($result_data as $folder => $data) {
            if ($folder == $main_folder) continue;
            foreach (array('name', 'alt_name', 'descr', 'keywords', 'metatitle', 'fulldescr') as $field) {
                if (!isset($result_data[$folder][$field]) || trim((string)$result_data[$folder][$field]) === '') {
                    $result_data[$folder][$field] = isset($result_data[$main_folder][$field]) ? $result_data[$main_folder][$field] : '';
                }
            }
        }
    }

    return $result_data;
}

function dle_ml_get_static_translations($static_id) {
    global $db, $config;

    $static_id = intval($static_id);
    $languages = dle_ml_get_languages();
    $main_folder = dle_ml_main_folder($config);
    $result_data = array();

    foreach ($languages as $folder => $meta) {
        $result_data[$folder] = array(
            'name' => '',
            'descr' => '',
            'template' => '',
            'metadescr' => '',
            'metakeys' => '',
            'metatitle' => '',
        );
    }

    if ($static_id < 1 || !dle_ml_table_exists('static_i18n')) {
        return $result_data;
    }

    $result = $db->query("SELECT * FROM " . PREFIX . "_static_i18n WHERE static_id='{$static_id}'");

    while ($row = $db->get_row($result)) {
        $folder = $row['lang'];
        if (!isset($result_data[$folder])) continue;
        $result_data[$folder] = $row;
    }

    $db->free($result);

    if (isset($result_data[$main_folder])) {
        foreach ($result_data as $folder => $data) {
            if ($folder == $main_folder) continue;
            foreach (array('name', 'descr', 'template', 'metadescr', 'metakeys', 'metatitle') as $field) {
                if (!isset($result_data[$folder][$field]) || trim((string)$result_data[$folder][$field]) === '') {
                    $result_data[$folder][$field] = isset($result_data[$main_folder][$field]) ? $result_data[$main_folder][$field] : '';
                }
            }
        }
    }

    return $result_data;
}

function dle_ml_write_config_file($config_data) {
    if (!is_array($config_data) || !count($config_data)) return false;

    $handler = fopen(ENGINE_DIR . '/data/config.php', 'w');
    if (!$handler) return false;

    fwrite($handler, "<?php\n\n//System Configurations\n\n\$config = array (\n\n");

    foreach ($config_data as $name => $value) {
        if (is_array($value) || is_object($value)) continue;

        $name = str_replace(array("\\r", "\\n", "'"), '', (string)$name);
        $value = str_replace(array("\\r", "\\n"), '', (string)$value);
        $value = addslashes($value);

        fwrite($handler, "'{$name}' => '{$value}',\n\n");
    }

    fwrite($handler, ");\n\n?>");
    fclose($handler);

    if (function_exists('opcache_reset')) {
        opcache_reset();
    }

    return true;
}

function dle_ml_current_lang_code($config_data = array()) {
    $folder = isset($config_data['active_language']) ? $config_data['active_language'] : '';
    if (!$folder) $folder = isset($GLOBALS['dle_active_language']) ? $GLOBALS['dle_active_language'] : dle_ml_main_folder($config_data);
    return dle_ml_code_from_folder_name($folder);
}

function dle_ml_main_lang_code($config_data = array()) {
    return dle_ml_code_from_folder_name(dle_ml_main_folder($config_data));
}

function dle_ml_public_url($route, $params = array(), $config_data = array(), $lang_code = '') {
    if (!$lang_code) $lang_code = dle_ml_current_lang_code($config_data);
    $prefix = dle_ml_language_base_url($lang_code, $config_data);

    switch ($route) {
        case 'home':
            return $prefix;
        case 'search':
            return $prefix . 'search/';
        case 'search_advanced':
            return $prefix . 'search/advanced/';
        case 'contact':
            return $prefix . 'contact/';
        case 'register':
            return $prefix . 'register/';
        case 'lostpassword':
            return $prefix . 'lostpassword/';
        case 'lastcomments':
            if (isset($params['userid']) && intval($params['userid']) > 0) {
                return $prefix . 'lastcomments/user/' . intval($params['userid']) . '/';
            }
            return $prefix . 'lastcomments/';
        default:
            return $prefix;
    }
}

function dle_ml_is_utility_request($do = '', $doaction = '', $action = '') {
    $do = totranslit((string)$do, false, false);
    $doaction = totranslit((string)$doaction, false, false);
    $action = totranslit((string)$action, false, false);

    if (in_array($do, array('pm', 'download', 'auth-social', 'unsubscribe', 'newsletterunsubscribe'), true)) return true;
    if ($do == 'register' && $doaction && $doaction != 'new') return true;
    if ($do == 'lostpassword' && $action) return true;
    if ($do == 'feedback' && isset($_REQUEST['send']) ) return true;

    return false;
}

function dle_ml_should_skip_prefix_redirect($path, $do = '') {
    if (stripos($path, '/engine/') === 0 || stripos($path, '/uploads/') === 0 || stripos($path, '/templates/') === 0 || stripos($path, '/backup/') === 0) return true;
    if (preg_match('#^/admin(\.php)?#i', $path)) return true;
    if (preg_match('#\.(css|js|map|jpg|jpeg|png|gif|svg|ico|webp|avif|woff|woff2|ttf|eot|xml|txt|json|pdf|zip)$#i', $path)) return true;
    if ($do && dle_ml_is_utility_request($do, isset($_REQUEST['doaction']) ? $_REQUEST['doaction'] : '', isset($_REQUEST['action']) ? $_REQUEST['action'] : '')) return true;
    return false;
}

function dle_ml_maybe_redirect_legacy_public(&$config_data) {
    if (PHP_SAPI == 'cli') return;
    if (headers_sent()) return;
    if (!isset($_SERVER['REQUEST_METHOD']) || !in_array($_SERVER['REQUEST_METHOD'], array('GET', 'HEAD'), true)) return;

    $uri = isset($_SERVER['REQUEST_URI']) ? (string)$_SERVER['REQUEST_URI'] : '/';
    $path = parse_url($uri, PHP_URL_PATH);
    $query = parse_url($uri, PHP_URL_QUERY);
    if (!$path) $path = '/';

    $current_code = dle_ml_current_lang_code($config_data);
    if (!$current_code) $current_code = dle_ml_main_lang_code($config_data);

    if (preg_match('#^/(az|en|ru)(/|$)#i', $path, $pref_match)) {
        $request_code = strtolower($pref_match[1]);
        if (!dle_ml_should_prefix_code($request_code, $config_data)) {
            $base = isset($config_data['http_home_url_base']) ? $config_data['http_home_url_base'] : dle_ml_base_home_url($config_data);
            $relative = preg_replace('#^/(az|en|ru)(/|$)#i', '/', $path);
            $target = $base . ltrim($relative, '/');
            if ($query) $target .= '?' . $query;

            header("HTTP/1.0 301 Moved Permanently");
            header("Location: {$target}");
            die("Redirect");
        }
        return;
    }

    parse_str((string)$query, $query_arr);
    $do = isset($query_arr['do']) ? totranslit((string)$query_arr['do'], false, false) : '';

    if (dle_ml_should_skip_prefix_redirect($path, $do)) return;

    $target = '';

    if ($do) {
        switch ($do) {
            case 'feedback':
                $target = dle_ml_public_url('contact', array(), $config_data, $current_code);
                break;
            case 'register':
                $target = dle_ml_public_url('register', array(), $config_data, $current_code);
                break;
            case 'lostpassword':
                $target = dle_ml_public_url('lostpassword', array(), $config_data, $current_code);
                break;
            case 'lastcomments':
                $target = dle_ml_public_url('lastcomments', array('userid' => isset($query_arr['userid']) ? intval($query_arr['userid']) : 0), $config_data, $current_code);
                break;
            case 'search':
                $target = (!empty($query_arr['mode']) && $query_arr['mode'] == 'advanced') ? dle_ml_public_url('search_advanced', array(), $config_data, $current_code) : dle_ml_public_url('search', array(), $config_data, $current_code);
                $search_query = $query_arr;
                unset($search_query['site_lang']);
                if (!isset($search_query['subaction']) || $search_query['subaction'] === '') $search_query['subaction'] = 'search';
                if (!isset($search_query['do']) || $search_query['do'] === '') $search_query['do'] = 'search';
                $search_qs = http_build_query($search_query);
                if ($search_qs) $target .= '?' . $search_qs;
                break;
            default:
                break;
        }
    }

    if (!$target && dle_ml_should_prefix_code($current_code, $config_data)) {
        $base = isset($config_data['http_home_url_base']) ? $config_data['http_home_url_base'] : dle_ml_base_home_url($config_data);
        $target = $base . $current_code . '/' . ltrim($path, '/');
        if ($query) $target .= '?' . $query;
    }

    if ($target) {
        $current_rel = dle_ml_current_url_no_lang_prefix();
        $target_path = parse_url($target, PHP_URL_PATH);
        $target_query = parse_url($target, PHP_URL_QUERY);
        if (!$target_path) $target_path = '/';

        if ($target_query) {
            parse_str($target_query, $target_query_arr);
            unset($target_query_arr['site_lang']);
            $target_query = http_build_query($target_query_arr);
            if ($target_query) $target_path .= '?' . $target_query;
        }

        if ($target_path === $current_rel) {
            return;
        }

        header("HTTP/1.0 301 Moved Permanently");
        header("Location: {$target}");
        die("Redirect");
    }
}

function dle_ml_hreflang_links($relative = '') {
    $languages = dle_ml_get_languages();
    if (!$relative) $relative = dle_ml_current_url_no_lang_prefix();

    $links = array();
    foreach ($languages as $folder => $meta) {
        $links[] = array('hreflang' => $meta['code'], 'href' => dle_ml_url_for_code($meta['code'], $relative));
    }

    $main_code = dle_ml_main_lang_code(isset($GLOBALS['config']) && is_array($GLOBALS['config']) ? $GLOBALS['config'] : array());
    $links[] = array('hreflang' => 'x-default', 'href' => dle_ml_url_for_code($main_code, $relative));

    return $links;
}
