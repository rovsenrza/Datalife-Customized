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
 File: pm_alert.php
-----------------------------------------------------
 Use: Notification about personal message
=====================================================
*/

if( !defined('DATALIFEENGINE') ) {
	header( "HTTP/1.1 403 Forbidden" );
	header ( 'Location: ../../' );
	die( "Hacking attempt!" );
}

$row = $db->super_query("SELECT c.subject, m.content, c.updated_at, m.sender_id, u.name, CASE WHEN cr.last_read_at IS NULL OR c.updated_at > cr.last_read_at THEN 0 ELSE 1 END AS read_status FROM " . USERPREFIX . "_conversations c JOIN " . USERPREFIX . "_conversation_users cu ON c.id = cu.conversation_id JOIN " . USERPREFIX . "_conversations_messages m ON c.id = m.conversation_id LEFT JOIN " . USERPREFIX . "_conversation_reads cr ON c.id = cr.conversation_id AND cu.user_id = cr.user_id JOIN (SELECT conversation_id, MAX(created_at) AS last_message_time FROM " . USERPREFIX . "_conversations_messages GROUP BY conversation_id) AS lm ON m.conversation_id = lm.conversation_id AND m.created_at = lm.last_message_time JOIN " . USERPREFIX . "_users u ON m.sender_id = u.user_id WHERE cu.user_id = '{$member_id['user_id']}' ORDER BY read_status ASC, c.updated_at DESC LIMIT 1");

$lang['pm_alert'] = str_replace ("{user}"  , $member_id['name'], str_replace ("{num}"  , intval($member_id['pm_unread']), $lang['pm_alert']));

$row['subject'] = stripslashes($row['subject']);

if (dle_strlen($row['subject']) > 50) {

	$row['subject'] = dle_substr($row['subject'], 0, 50);

	if (($temp_dmax = dle_strrpos($row['subject'], ' '))) $row['subject'] = dle_substr($row['subject'], 0, $temp_dmax);

	$row['subject'] .= ' ...';
}
$row['content'] = stripslashes($row['content']);
$row['content'] = remove_quotes_from_text($row['content']);

$row['content'] = clear_content($row['content'], 0, false);

if (dle_strlen($row['content']) > 300) {

	$row['content'] = dle_substr($row['content'], 0, 300);

	if (($temp_dmax = dle_strrpos($row['content'], ' '))) $row['content'] = dle_substr($row['content'], 0, $temp_dmax);

	$row['content'] .= ' ...';
}


$pm_alert = <<<HTML
<div id="newpm" title="{$lang['pm_atitle']}" style="display:none;" >{$lang['pm_alert']}
<br><br>
{$lang['pm_asub']} <b>{$row['subject']}</b><br>
{$lang['pm_from']} <b>{$row['name']}</b><br><br><i>{$row['content']}</i></div>
HTML;

$onload_scripts[] = <<<HTML
var awsize = 550 * getBaseSize();

if (awsize > ($(window).width() * 0.95)) { awsize = $(window).width() * 0.95; }

$('#newpm').dialog({
	autoOpen: true,
	show: 'fade',
	hide: 'fade',
	width: awsize,
	resizable: false,
	dialogClass: "dle-popup-newpm",
	buttons: {
		"{$lang['pm_close']}" : function() { 
			$(this).dialog("close");						
		}, 
		"{$lang['pm_aread']}": function() {
			document.location='{$PHP_SELF}?do=pm';			
		}
	}
});
HTML;
?>