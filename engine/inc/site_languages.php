<?php
/*
=====================================================
 DataLife Engine - by SoftNews Media Group
-----------------------------------------------------
 Site languages manager (frontend only)
=====================================================
*/

if( !defined('DATALIFEENGINE') OR !defined('LOGGED_IN') ) {
	header( "HTTP/1.1 403 Forbidden" );
	header ( 'Location: ../../' );
	die( "Hacking attempt!" );
}

if( $member_id['user_group'] != 1 ) {
	msg("error", $lang['index_denied'], $lang['index_denied']);
}

function dle_site_lang_admin_folder() {
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

function dle_site_lang_t($key) {
	static $dict = array(
		'Azerbaijan' => array(
			'page_title' => 'Sayt dilləri',
			'page_subtitle' => 'Frontend üçün dilləri əlavə et, aktiv/deaktiv et',
			'hint' => 'Bu bölmə yalnız saytın (frontend) dili üçündür. Admin panel dili ayrıca idarə olunur.',
			'hint_folder' => 'Qovluq adı `/language/<qovluq>` ilə eyni olmalıdır. Qovluq yoxdursa dil əlavə olunar, amma dil faylları yüklənənə qədər tam işləməyə bilər.',
			'save_error' => 'Dillər faylına yazmaq mümkün olmadı',
			'empty_error' => 'Ən azı bir dil saxlanmalıdır',
			'btn_save' => 'Yadda saxla',
			'btn_add' => 'Dil əlavə et',
			'th_folder' => 'Qovluq',
			'th_title' => 'Başlıq',
			'th_code' => 'Kod',
			'th_active' => 'Aktiv',
			'th_installed' => 'Qovluq',
			'th_actions' => 'Əməliyyat',
			'installed_yes' => 'Mövcuddur',
			'installed_no' => 'Yoxdur',
			'remove' => 'Sil',
			'active_label' => 'Aktiv et',
			'saved' => 'Dillər siyahısı yeniləndi',
		),
		'English' => array(
			'page_title' => 'Site languages',
			'page_subtitle' => 'Add and enable/disable frontend languages',
			'hint' => 'This section manages website (frontend) languages only. Admin panel language is managed separately.',
			'hint_folder' => 'Folder must match `/language/<folder>`. You can add a language before folder upload, but full language files are required for proper frontend translation.',
			'save_error' => 'Unable to write site languages file',
			'empty_error' => 'At least one language must be saved',
			'btn_save' => 'Save',
			'btn_add' => 'Add language',
			'th_folder' => 'Folder',
			'th_title' => 'Title',
			'th_code' => 'Code',
			'th_active' => 'Active',
			'th_installed' => 'Folder',
			'th_actions' => 'Actions',
			'installed_yes' => 'Installed',
			'installed_no' => 'Missing',
			'remove' => 'Remove',
			'active_label' => 'Enable',
			'saved' => 'Site languages updated',
		),
		'Russian' => array(
			'page_title' => 'Языки сайта',
			'page_subtitle' => 'Добавление и включение/отключение языков фронтенда',
			'hint' => 'Этот раздел относится только к языкам сайта (frontend). Язык админ-панели настраивается отдельно.',
			'hint_folder' => 'Имя папки должно совпадать с `/language/<папка>`. Язык можно добавить заранее, но для полной работы нужны языковые файлы.',
			'save_error' => 'Не удалось записать файл языков сайта',
			'empty_error' => 'Нужно сохранить минимум один язык',
			'btn_save' => 'Сохранить',
			'btn_add' => 'Добавить язык',
			'th_folder' => 'Папка',
			'th_title' => 'Название',
			'th_code' => 'Код',
			'th_active' => 'Активен',
			'th_installed' => 'Папка',
			'th_actions' => 'Действия',
			'installed_yes' => 'Есть',
			'installed_no' => 'Нет',
			'remove' => 'Удалить',
			'active_label' => 'Включить',
			'saved' => 'Список языков обновлен',
		),
	);

	$folder = dle_site_lang_admin_folder();
	if (!isset($dict[$folder][$key])) {
		$folder = 'English';
	}

	return isset($dict[$folder][$key]) ? $dict[$folder][$key] : $key;
}

function dle_site_lang_clean_folder($value) {
	$value = totranslit(trim((string)$value), false, false);
	$value = preg_replace('/[^a-zA-Z0-9_\-]/', '', $value);
	return trim((string)$value);
}

function dle_site_lang_render_row($index, $item, $can_remove = true) {
	$folder = htmlspecialchars(isset($item['folder']) ? $item['folder'] : '', ENT_QUOTES, 'UTF-8');
	$title = htmlspecialchars(isset($item['title']) ? $item['title'] : '', ENT_QUOTES, 'UTF-8');
	$code = htmlspecialchars(isset($item['code']) ? strtolower($item['code']) : '', ENT_QUOTES, 'UTF-8');
	$icon = htmlspecialchars(isset($item['icon']) ? $item['icon'] : '', ENT_QUOTES, 'UTF-8');
	$enabled = !empty($item['enabled']) ? ' checked' : '';
	$installed = !empty($item['installed']) ? 1 : 0;
	$installed_text = $installed ? dle_site_lang_t('installed_yes') : dle_site_lang_t('installed_no');
	$installed_class = $installed ? 'text-success' : 'text-danger';
	$readonly = $installed ? ' readonly' : '';
	$remove_disabled = $can_remove ? '' : ' disabled';

	return "<tr>
		<td><input type=\"text\" class=\"form-control\" name=\"site_langs[{$index}][folder]\" value=\"{$folder}\"{$readonly}></td>
		<td><input type=\"text\" class=\"form-control\" name=\"site_langs[{$index}][title]\" value=\"{$title}\"></td>
		<td><input type=\"text\" class=\"form-control\" name=\"site_langs[{$index}][code]\" value=\"{$code}\" maxlength=\"10\"></td>
		<td class=\"text-center\"><input type=\"checkbox\" class=\"switch\" name=\"site_langs[{$index}][enabled]\" value=\"1\"{$enabled}></td>
		<td class=\"{$installed_class}\">{$installed_text}<input type=\"hidden\" name=\"site_langs[{$index}][icon]\" value=\"{$icon}\"></td>
		<td class=\"text-center\"><button type=\"button\" class=\"btn btn-sm bg-danger-400 js-remove-row\"{$remove_disabled}><i class=\"fa fa-trash-o\"></i></button></td>
	</tr>";
}

$action = isset($_REQUEST['action']) ? totranslit($_REQUEST['action']) : 'list';

if ($action == 'save') {

	if( !isset($_REQUEST['user_hash']) OR !$_REQUEST['user_hash'] OR $_REQUEST['user_hash'] != $dle_login_hash ) {
		die("Hacking attempt! User not found");
	}

	$posted = isset($_POST['site_langs']) && is_array($_POST['site_langs']) ? $_POST['site_langs'] : array();
	$installed_folders = get_folder_list('language');
	if (!is_array($installed_folders)) $installed_folders = array();

	$rows = array();
	$seen = array();

	foreach ($posted as $row) {
		if (!is_array($row)) continue;

		$folder = isset($row['folder']) ? dle_site_lang_clean_folder($row['folder']) : '';
		if (!$folder) continue;

		$key = strtolower($folder);
		if (isset($seen[$key])) continue;
		$seen[$key] = 1;

		$title = isset($row['title']) ? trim((string)$row['title']) : '';
		if (!$title) $title = $folder;

		$code = isset($row['code']) ? strtolower(trim((string)$row['code'])) : '';
		$code = preg_replace('/[^a-z0-9]/', '', $code);
		if (!$code) $code = dle_ml_code_from_folder($folder);
		if (strlen($code) > 10) $code = substr($code, 0, 10);

		$icon = isset($row['icon']) ? trim((string)$row['icon']) : '';
		$enabled = isset($row['enabled']) ? 1 : 0;

		$rows[] = array(
			'folder' => $folder,
			'name' => $folder,
			'title' => $title,
			'code' => $code,
			'icon' => $icon,
			'enabled' => $enabled,
		);
	}

	foreach ($installed_folders as $folder => $meta) {
		$folder = dle_site_lang_clean_folder($folder);
		if (!$folder) continue;

		$key = strtolower($folder);
		if (isset($seen[$key])) continue;

		$title = '';
		$icon = '';

		if (is_array($meta)) {
			$title = isset($meta['title']) ? trim((string)$meta['title']) : '';
			$icon = isset($meta['icon']) ? trim((string)$meta['icon']) : '';
		}

		if (!$title) $title = $folder;

		$rows[] = array(
			'folder' => $folder,
			'name' => $folder,
			'title' => $title,
			'code' => dle_ml_code_from_folder($folder),
			'icon' => $icon,
			'enabled' => 1,
		);
	}

	if (!count($rows)) {
		msg("error", dle_site_lang_t('page_title'), dle_site_lang_t('empty_error'), "?mod=site_languages");
	}

	if (!dle_ml_save_languages_all($rows)) {
		msg("error", dle_site_lang_t('page_title'), dle_site_lang_t('save_error'), "?mod=site_languages");
	}

	$active_languages = dle_ml_get_languages(true);
	if (!isset($active_languages[$config['main_language']])) {
		foreach ($active_languages as $folder => $meta) {
			$config['main_language'] = $folder;
			break;
		}
		dle_ml_write_config_file($config);
	}

	if (isset($_COOKIE['site_language']) && $_COOKIE['site_language'] && !isset($active_languages[$_COOKIE['site_language']])) {
		$reset_folder = dle_ml_main_folder($config);
		set_cookie("site_language", $reset_folder, 365);
		set_cookie("site_lang", dle_ml_code_from_folder_name($reset_folder), 365);
	}

	header("Location: ?mod=site_languages&saved=1");
	die();
}

$all_languages = dle_ml_get_languages_all(true);
$rows_html = '';
$row_index = 0;

foreach ($all_languages as $folder => $meta) {
	$rows_html .= dle_site_lang_render_row($row_index, $meta, empty($meta['installed']));
	$row_index++;
}

if (!$rows_html) {
	$rows_html = dle_site_lang_render_row(0, array('folder' => '', 'title' => '', 'code' => '', 'enabled' => 1, 'installed' => 0), true);
	$row_index = 1;
}

$saved_notice = '';
if (isset($_GET['saved'])) {
	$saved_notice = "<div class=\"alert alert-success alert-styled-left alert-arrow-left alert-component\">" . dle_site_lang_t('saved') . "</div>";
}

$_title_page = htmlspecialchars(dle_site_lang_t('page_title'), ENT_QUOTES, 'UTF-8');
$_hint = htmlspecialchars(dle_site_lang_t('hint'), ENT_QUOTES, 'UTF-8');
$_hint_folder = htmlspecialchars(dle_site_lang_t('hint_folder'), ENT_QUOTES, 'UTF-8');
$_th_folder = htmlspecialchars(dle_site_lang_t('th_folder'), ENT_QUOTES, 'UTF-8');
$_th_title = htmlspecialchars(dle_site_lang_t('th_title'), ENT_QUOTES, 'UTF-8');
$_th_code = htmlspecialchars(dle_site_lang_t('th_code'), ENT_QUOTES, 'UTF-8');
$_th_active = htmlspecialchars(dle_site_lang_t('th_active'), ENT_QUOTES, 'UTF-8');
$_th_installed = htmlspecialchars(dle_site_lang_t('th_installed'), ENT_QUOTES, 'UTF-8');
$_th_actions = htmlspecialchars(dle_site_lang_t('th_actions'), ENT_QUOTES, 'UTF-8');
$_btn_add = htmlspecialchars(dle_site_lang_t('btn_add'), ENT_QUOTES, 'UTF-8');
$_btn_save = htmlspecialchars(dle_site_lang_t('btn_save'), ENT_QUOTES, 'UTF-8');
$_installed_no_js = htmlspecialchars(dle_site_lang_t('installed_no'), ENT_QUOTES, 'UTF-8');

echoheader("<i class=\"fa fa-language position-left\"></i><span class=\"text-semibold\">" . dle_site_lang_t('page_title') . "</span>", dle_site_lang_t('page_subtitle'));

echo <<<HTML
{$saved_notice}
<div class="alert alert-info alert-styled-left alert-arrow-left alert-component">
	<strong>{$_title_page}</strong><br>{$_hint}<br>{$_hint_folder}
</div>
<form action="?mod=site_languages&action=save" method="post">
	<div class="panel panel-default">
		<div class="panel-heading">
			{$_title_page}
		</div>
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>{$_th_folder}</th>
						<th>{$_th_title}</th>
						<th style="width:120px;">{$_th_code}</th>
						<th style="width:100px;" class="text-center">{$_th_active}</th>
						<th style="width:120px;">{$_th_installed}</th>
						<th style="width:90px;" class="text-center">{$_th_actions}</th>
					</tr>
				</thead>
				<tbody id="site-langs-body" data-next-index="{$row_index}">
					{$rows_html}
				</tbody>
			</table>
		</div>
	</div>
	<div style="margin-bottom:30px;">
		<button type="button" class="btn btn-default btn-sm btn-raised position-left" id="add-site-language"><i class="fa fa-plus-circle position-left"></i>{$_btn_add}</button>
		<input type="hidden" name="user_hash" value="{$dle_login_hash}">
		<button type="submit" class="btn bg-teal btn-sm btn-raised position-left"><i class="fa fa-floppy-o position-left"></i>{$_btn_save}</button>
	</div>
</form>
<script>
(function() {
	var body = document.getElementById('site-langs-body');
	var addButton = document.getElementById('add-site-language');
	if (!body || !addButton) return;

	function nextIndex() {
		var n = parseInt(body.getAttribute('data-next-index'), 10);
		if (isNaN(n) || n < 0) n = 0;
		body.setAttribute('data-next-index', n + 1);
		return n;
	}

	function createRow() {
		var i = nextIndex();
		var tr = document.createElement('tr');
		tr.innerHTML = '<td><input type="text" class="form-control" name="site_langs[' + i + '][folder]" value=""></td>'
			+ '<td><input type="text" class="form-control" name="site_langs[' + i + '][title]" value=""></td>'
			+ '<td><input type="text" class="form-control" name="site_langs[' + i + '][code]" value="" maxlength="10"></td>'
			+ '<td class="text-center"><input type="checkbox" class="switch" name="site_langs[' + i + '][enabled]" value="1" checked></td>'
			+ '<td class="text-danger">{$_installed_no_js}<input type="hidden" name="site_langs[' + i + '][icon]" value=""></td>'
			+ '<td class="text-center"><button type="button" class="btn btn-sm bg-danger-400 js-remove-row"><i class="fa fa-trash-o"></i></button></td>';
		return tr;
	}

	addButton.addEventListener('click', function() {
		body.appendChild(createRow());
	});

	body.addEventListener('click', function(event) {
		var target = event.target;
		if (!target) return;
		if (target.classList.contains('js-remove-row') || (target.parentNode && target.parentNode.classList && target.parentNode.classList.contains('js-remove-row'))) {
			var btn = target.classList.contains('js-remove-row') ? target : target.parentNode;
			if (btn.hasAttribute('disabled')) return;
			var row = btn.closest('tr');
			if (row && row.parentNode) {
				row.parentNode.removeChild(row);
			}
		}
	});
})();
</script>
HTML;

echofooter();
?>
