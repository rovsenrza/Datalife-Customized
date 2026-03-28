-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:8889
-- Üretim Zamanı: 26 Mar 2026, 11:40:51
-- Sunucu sürümü: 8.0.44
-- PHP Sürümü: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `dle`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_admin_logs`
--

CREATE TABLE `dle_admin_logs` (
  `id` int NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` int UNSIGNED NOT NULL DEFAULT '0',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `action` int NOT NULL DEFAULT '0',
  `extras` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_admin_logs`
--

INSERT INTO `dle_admin_logs` (`id`, `name`, `date`, `ip`, `action`, `extras`) VALUES
(1, 'admin', 1774422652, '::1', 89, ''),
(2, 'admin', 1774422658, '::1', 89, ''),
(3, 'admin', 1774422661, '::1', 89, ''),
(4, 'admin', 1774422665, '::1', 82, ''),
(5, 'admin', 1774422793, '::1', 89, ''),
(6, 'admin', 1774422797, '::1', 82, ''),
(7, 'admin', 1774422976, '::1', 89, ''),
(8, 'admin', 1774422979, '::1', 82, ''),
(9, 'admin', 1774423895, '::1', 82, ''),
(10, 'admin', 1774423917, '::1', 82, ''),
(11, 'admin', 1774430281, '::1', 74, 'text'),
(12, 'admin', 1774434646, '::1', 38, ''),
(13, 'admin', 1774434972, '::1', 38, ''),
(14, 'admin', 1774435151, '::1', 48, ''),
(15, 'admin', 1774435347, '::1', 48, ''),
(16, 'admin', 1774435368, '::1', 48, ''),
(17, 'admin', 1774435597, '::1', 48, ''),
(18, 'admin', 1774436235, '::1', 36, 'sentrum_scene_event_2_-_foto_oleonstad_4ro4ajpab.webp'),
(19, 'admin', 1774436291, '::1', 25, 'Welcome'),
(20, 'admin', 1774519818, '::1', 48, ''),
(21, 'admin', 1774519864, '::1', 38, ''),
(22, 'admin', 1774519954, '::1', 89, ''),
(23, 'admin', 1774519961, '::1', 82, '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_admin_sections`
--

CREATE TABLE `dle_admin_sections` (
  `id` mediumint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_groups` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_banned`
--

CREATE TABLE `dle_banned` (
  `id` smallint NOT NULL,
  `users_id` int NOT NULL DEFAULT '0',
  `descr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `days` smallint NOT NULL DEFAULT '0',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `banned_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_banners`
--

CREATE TABLE `dle_banners` (
  `id` smallint NOT NULL,
  `banner_tag` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `code` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `approve` tinyint(1) NOT NULL DEFAULT '0',
  `short_place` tinyint(1) NOT NULL DEFAULT '0',
  `bstick` tinyint(1) NOT NULL DEFAULT '0',
  `main` tinyint(1) NOT NULL DEFAULT '0',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `grouplevel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'all',
  `start` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `end` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `fpage` tinyint(1) NOT NULL DEFAULT '0',
  `innews` tinyint(1) NOT NULL DEFAULT '0',
  `devicelevel` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_views` tinyint(1) NOT NULL DEFAULT '0',
  `max_views` int NOT NULL DEFAULT '0',
  `allow_counts` tinyint(1) NOT NULL DEFAULT '0',
  `max_counts` int NOT NULL DEFAULT '0',
  `views` int NOT NULL DEFAULT '0',
  `clicks` int NOT NULL DEFAULT '0',
  `rubric` mediumint NOT NULL DEFAULT '0',
  `comments_place` tinyint(1) NOT NULL DEFAULT '0',
  `allowed_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `not_allowed_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_banners`
--

INSERT INTO `dle_banners` (`id`, `banner_tag`, `descr`, `code`, `approve`, `short_place`, `bstick`, `main`, `category`, `grouplevel`, `start`, `end`, `fpage`, `innews`, `devicelevel`, `allow_views`, `max_views`, `allow_counts`, `max_counts`, `views`, `clicks`, `rubric`, `comments_place`, `allowed_country`, `not_allowed_country`) VALUES
(1, 'header', 'Top banner', '<div style=\"text-align:center;\"><a href=\"https://dle-news.ru/\" target=\"_blank\"><img src=\"http://test.digitale.az/templates/Default/images/_banner_.gif\" style=\"border: none;\" alt=\"\" /></a></div>', 1, 0, 0, 0, '0', 'all', '', '', 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_banners_logs`
--

CREATE TABLE `dle_banners_logs` (
  `id` int UNSIGNED NOT NULL,
  `bid` int NOT NULL DEFAULT '0',
  `click` tinyint(1) NOT NULL DEFAULT '0',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_banners_rubrics`
--

CREATE TABLE `dle_banners_rubrics` (
  `id` mediumint NOT NULL,
  `parentid` mediumint NOT NULL DEFAULT '0',
  `title` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_category`
--

CREATE TABLE `dle_category` (
  `id` mediumint NOT NULL,
  `parentid` mediumint NOT NULL DEFAULT '0',
  `posi` mediumint NOT NULL DEFAULT '1',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `alt_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `skin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `news_sort` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `news_msort` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `news_number` smallint NOT NULL DEFAULT '0',
  `short_tpl` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `full_tpl` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metatitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `show_sub` tinyint(1) NOT NULL DEFAULT '0',
  `allow_rss` tinyint(1) NOT NULL DEFAULT '1',
  `fulldescr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `disable_search` tinyint(1) NOT NULL DEFAULT '0',
  `disable_main` tinyint(1) NOT NULL DEFAULT '0',
  `disable_rating` tinyint(1) NOT NULL DEFAULT '0',
  `disable_comments` tinyint(1) NOT NULL DEFAULT '0',
  `enable_dzen` tinyint(1) NOT NULL DEFAULT '1',
  `enable_turbo` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `rating_type` tinyint(1) NOT NULL DEFAULT '-1',
  `schema_org` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1',
  `disable_index` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_category`
--

INSERT INTO `dle_category` (`id`, `parentid`, `posi`, `name`, `alt_name`, `icon`, `skin`, `descr`, `keywords`, `news_sort`, `news_msort`, `news_number`, `short_tpl`, `full_tpl`, `metatitle`, `show_sub`, `allow_rss`, `fulldescr`, `disable_search`, `disable_main`, `disable_rating`, `disable_comments`, `enable_dzen`, `enable_turbo`, `active`, `rating_type`, `schema_org`, `disable_index`) VALUES
(1, 0, 1, 'About DLE', 'o-skripte', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(2, 0, 1, 'World', 'v-mire', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(3, 0, 1, 'Economy', 'ekonomika', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(4, 0, 1, 'Religion', 'religiya', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(5, 0, 1, 'Crime', 'kriminal', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(6, 0, 1, 'Sport', 'sport', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(7, 0, 1, 'Culture', 'kultura', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0),
(8, 0, 1, 'Press', 'inopressa', '', '', '', '', '', '', 0, '', '', '', 0, 1, '', 0, 0, 0, 0, 1, 1, 1, -1, '1', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_category_i18n`
--

CREATE TABLE `dle_category_i18n` (
  `category_id` int UNSIGNED NOT NULL,
  `lang` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alt_name` varchar(255) NOT NULL DEFAULT '',
  `descr` varchar(300) NOT NULL DEFAULT '',
  `keywords` text NOT NULL,
  `metatitle` varchar(300) NOT NULL DEFAULT '',
  `fulldescr` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `dle_category_i18n`
--

INSERT INTO `dle_category_i18n` (`category_id`, `lang`, `name`, `descr`, `keywords`, `metatitle`, `fulldescr`) VALUES
(1, 'Azerbaijan', 'About DLE', '', '', '', ''),
(1, 'English', 'About DLE', '', '', '', ''),
(1, 'Russian', 'About DLE', '', '', '', ''),
(2, 'Azerbaijan', 'World', '', '', '', ''),
(2, 'English', 'World', '', '', '', ''),
(2, 'Russian', 'World', '', '', '', ''),
(3, 'Azerbaijan', 'Economy', '', '', '', ''),
(3, 'English', 'Economy', '', '', '', ''),
(3, 'Russian', 'Economy', '', '', '', ''),
(4, 'Azerbaijan', 'Religion', '', '', '', ''),
(4, 'English', 'Religion', '', '', '', ''),
(4, 'Russian', 'Religion', '', '', '', ''),
(5, 'Azerbaijan', 'Crime', '', '', '', ''),
(5, 'English', 'Crime', '', '', '', ''),
(5, 'Russian', 'Crime', '', '', '', ''),
(6, 'Azerbaijan', 'Sport', '', '', '', ''),
(6, 'English', 'Sport', '', '', '', ''),
(6, 'Russian', 'Sport', '', '', '', ''),
(7, 'Azerbaijan', 'Culture', '', '', '', ''),
(7, 'English', 'Culture', '', '', '', ''),
(7, 'Russian', 'Culture', '', '', '', ''),
(8, 'Azerbaijan', 'Press', '', '', '', ''),
(8, 'English', 'Press', '', '', '', ''),
(8, 'Russian', 'Press', '', '', '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_comments`
--

CREATE TABLE `dle_comments` (
  `id` int UNSIGNED NOT NULL,
  `post_id` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `autor` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_register` tinyint(1) NOT NULL DEFAULT '0',
  `approve` tinyint(1) NOT NULL DEFAULT '1',
  `rating` int NOT NULL DEFAULT '0',
  `vote_num` int NOT NULL DEFAULT '0',
  `parent` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_comments_files`
--

CREATE TABLE `dle_comments_files` (
  `id` int NOT NULL,
  `c_id` int NOT NULL DEFAULT '0',
  `author` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `driver` mediumint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_comment_rating_log`
--

CREATE TABLE `dle_comment_rating_log` (
  `id` int UNSIGNED NOT NULL,
  `c_id` int NOT NULL DEFAULT '0',
  `member` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `rating` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_complaint`
--

CREATE TABLE `dle_complaint` (
  `id` int UNSIGNED NOT NULL,
  `p_id` int NOT NULL DEFAULT '0',
  `c_id` int NOT NULL DEFAULT '0',
  `n_id` int NOT NULL DEFAULT '0',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` int UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_conversations`
--

CREATE TABLE `dle_conversations` (
  `id` int UNSIGNED NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created_at` int UNSIGNED NOT NULL DEFAULT '0',
  `updated_at` int UNSIGNED NOT NULL DEFAULT '0',
  `sender_id` int NOT NULL,
  `recipient_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_conversations_messages`
--

CREATE TABLE `dle_conversations_messages` (
  `id` int UNSIGNED NOT NULL,
  `conversation_id` int UNSIGNED NOT NULL,
  `sender_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_conversation_reads`
--

CREATE TABLE `dle_conversation_reads` (
  `user_id` int UNSIGNED NOT NULL,
  `conversation_id` int UNSIGNED NOT NULL,
  `last_read_at` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_conversation_users`
--

CREATE TABLE `dle_conversation_users` (
  `user_id` int UNSIGNED NOT NULL,
  `conversation_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_downloads_log`
--

CREATE TABLE `dle_downloads_log` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `file_id` int NOT NULL DEFAULT '0',
  `date` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_email`
--

CREATE TABLE `dle_email` (
  `id` tinyint UNSIGNED NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `use_html` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_email`
--

INSERT INTO `dle_email` (`id`, `name`, `template`, `use_html`) VALUES
(1, 'reg_mail', '{%username%},\r\n\r\nThis letter was sent from the http://test.digitale.az/\r\n\r\nYou are receiving this email because this e-mail address was used for registration on the website. If you are not registered on this website, just ignore this email and delete it. You will not get this letter in the future.\r\n\r\n------------------------------------------------\r\nYour username and password on the website:\r\n------------------------------------------------\r\n\r\nUsername: {%username%}\r\nPassword: {%password%}\r\n\r\n------------------------------------------------\r\nActivation Instructions\r\n------------------------------------------------\r\n\r\nThank you for registering.\r\nWe require you to confirm your registration to verify that e-mail address that you have entered is real. This is required to protect against unwanted spam and abuse.\r\n\r\nTo activate your account, go to the following link:\r\n\r\n{%validationlink%}\r\n\r\nIf these actions do not work, maybe your account has been deleted. In this case, contact the administrator to resolve the problem.\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/.', 0),
(2, 'feed_mail', '{%username_to%},\r\n\r\n{%username_from%} has sent this letter from http://test.digitale.az/\r\n\r\n------------------------------------------------\r\nMessage text\r\n------------------------------------------------\r\n\r\n{%text%}\r\n\r\nIP address of the sender: {%ip%}\r\nGroup: {%group%}\r\n\r\n------------------------------------------------\r\nRemember that website administration is not responsible for the content of this letter\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(3, 'lost_mail', 'Dear {%username%},\r\n\r\nYou have requested the password recovery on http://test.digitale.az/ However, passwords are stored in encrypted form for security, so we can not tell you your old password. If you want generate a new password, go to the following link: \r\n\r\n{%lostlink%}\r\n\r\nIf you did not make a request for a password recovery, then simply delete this email. Your password in a safe place and is inaccessible to unauthorized persons.\r\n\r\nIP address of sender: {%ip%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(4, 'new_news', 'Dear Administrator,\r\n\r\nThe article was added on http://test.digitale.az/, which is currently awaiting moderation.\r\n\r\n------------------------------------------------\r\nSummary of the article\r\n------------------------------------------------\r\n\r\nAuthor: {%username%}\r\nArticle title: {%title%}\r\nCategory: {%category%}\r\nDate: {%date%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(5, 'comments', 'Dear {%username_to%},\r\n\r\nThe comment for the article that you have subscribed to was added on http://test.digitale.az/.\r\n\r\n------------------------------------------------\r\nSummary of the comment\r\n------------------------------------------------\r\n\r\nAuthor: {%username%}\r\nDate: {%date%}\r\nLink to the article: {%link%}\r\n\r\n------------------------------------------------\r\nComment text\r\n------------------------------------------------\r\n\r\n{%text%}\r\n\r\n------------------------------------------------\r\n\r\nIf you do not want to receive notifications about new comments to this article, then follow this link: {%unsubscribe%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(6, 'pm', 'Dear {%username%},\r\n\r\nYou received a personal message on http://test.digitale.az/.\r\n\r\n------------------------------------------------\r\nSummary of the message\r\n------------------------------------------------\r\n\r\nSender: {%fromusername%}\r\nDate: {%date%}\r\nSubject: {%title%}\r\n\r\n------------------------------------------------\r\nMessage text\r\n------------------------------------------------\r\n\r\n{%text%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(7, 'wait_mail', 'Dear {%username%},\r\n\r\nYou have requested the association of you account on http://test.digitale.az/ with the social network account on {%network%}. However, for security reasons you need to confirm this action on the following link: \r\n\r\n------------------------------------------------\r\n{%link%}\r\n------------------------------------------------\r\n\r\nIf you did not make this request, then just delete this email. Your account details are stored in a secure place and are inaccessible to unauthorized persons.\r\n\r\nIP address of sender: {%ip%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0),
(8, 'newsletter', '<html>\r\n<head>\r\n<title>{%title%}</title>\r\n<meta content=\"text/html; charset={%charset%}\" http-equiv=Content-Type>\r\n<style type=\"text/css\">\r\nhtml,body{\r\n    font-family: Verdana;\r\n    word-spacing: 0.1em;\r\n    letter-spacing: 0;\r\n    line-height: 1.5em;\r\n    font-size: 11px;\r\n}\r\n\r\np {\r\n	margin:0px;\r\n	padding: 0px;\r\n}\r\n\r\na:active,\r\na:visited,\r\na:link {\r\n	color: #4b719e;\r\n	text-decoration:none;\r\n}\r\n\r\na:hover {\r\n	color: #4b719e;\r\n	text-decoration: underline;\r\n}\r\n</style>\r\n</head>\r\n<body>\r\n{%content%}\r\n</body>\r\n</html>', 0),
(9, 'twofactor', '{%username%},\r\n\r\nThis letter was sent from the http://test.digitale.az/\r\n\r\nYou received this email because for your account two-factor authentication enabled. To login on a website you must enter your pin.\r\n\r\n------------------------------------------------\r\nPin:\r\n------------------------------------------------\r\n\r\n{%pin%}\r\n\r\n------------------------------------------------\r\n\r\nThe IP of the user: {%ip%}\r\n\r\nSincerely,\r\n\r\nAdministration http://test.digitale.az/', 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_files`
--

CREATE TABLE `dle_files` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `onserver` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `author` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dcount` int NOT NULL DEFAULT '0',
  `size` bigint NOT NULL DEFAULT '0',
  `checksum` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `driver` mediumint NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_flood`
--

CREATE TABLE `dle_flood` (
  `f_id` int UNSIGNED NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `flag` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_ignore_list`
--

CREATE TABLE `dle_ignore_list` (
  `id` int UNSIGNED NOT NULL,
  `user` int NOT NULL DEFAULT '0',
  `user_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_images`
--

CREATE TABLE `dle_images` (
  `id` int UNSIGNED NOT NULL,
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `author` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_images`
--

INSERT INTO `dle_images` (`id`, `images`, `news_id`, `author`, `date`) VALUES
(1, '2026-03/sentrum_scene_event_2_-_foto_oleonstad_4ro4ajpab.webp|1|1|1920x1080|130.2 Kb|0', 1, 'admin', '1774436235');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_links`
--

CREATE TABLE `dle_links` (
  `id` int UNSIGNED NOT NULL,
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `only_one` tinyint(1) NOT NULL DEFAULT '0',
  `replacearea` tinyint(1) NOT NULL DEFAULT '1',
  `rcount` tinyint NOT NULL DEFAULT '0',
  `targetblank` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_login_log`
--

CREATE TABLE `dle_login_log` (
  `id` int UNSIGNED NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `count` smallint NOT NULL DEFAULT '0',
  `date` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_logs`
--

CREATE TABLE `dle_logs` (
  `id` int UNSIGNED NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `member` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `rating` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_lostdb`
--

CREATE TABLE `dle_lostdb` (
  `id` mediumint NOT NULL,
  `lostname` mediumint NOT NULL DEFAULT '0',
  `lostid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_mail_log`
--

CREATE TABLE `dle_mail_log` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `mail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `hash` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_metatags`
--

CREATE TABLE `dle_metatags` (
  `id` int UNSIGNED NOT NULL,
  `url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `page_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `page_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `robots` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_notice`
--

CREATE TABLE `dle_notice` (
  `id` mediumint NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_plugins`
--

CREATE TABLE `dle_plugins` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `version` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dleversion` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `versioncompare` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `mysqlinstall` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mysqlupgrade` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mysqlenable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mysqldisable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mysqldelete` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `filedelete` tinyint(1) NOT NULL DEFAULT '0',
  `filelist` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `upgradeurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `needplugin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `phpinstall` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phpupgrade` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phpenable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phpdisable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phpdelete` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mnotice` tinyint(1) NOT NULL DEFAULT '0',
  `posi` mediumint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_plugins_files`
--

CREATE TABLE `dle_plugins_files` (
  `id` int NOT NULL,
  `plugin_id` int NOT NULL DEFAULT '0',
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `action` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `searchcode` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `replacecode` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `searchcount` smallint NOT NULL DEFAULT '0',
  `replacecount` smallint NOT NULL DEFAULT '0',
  `filedisable` tinyint(1) NOT NULL DEFAULT '1',
  `filedleversion` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `fileversioncompare` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_plugins_logs`
--

CREATE TABLE `dle_plugins_logs` (
  `id` int NOT NULL,
  `plugin_id` int NOT NULL DEFAULT '0',
  `area` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `action_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_poll`
--

CREATE TABLE `dle_poll` (
  `id` mediumint UNSIGNED NOT NULL,
  `news_id` int UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `frage` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `votes` mediumint NOT NULL DEFAULT '0',
  `multiple` tinyint(1) NOT NULL DEFAULT '0',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `date_closed` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_poll_log`
--

CREATE TABLE `dle_poll_log` (
  `id` int UNSIGNED NOT NULL,
  `news_id` int UNSIGNED NOT NULL DEFAULT '0',
  `member` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post`
--

CREATE TABLE `dle_post` (
  `id` int NOT NULL,
  `autor` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `short_story` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_story` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `xfields` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `alt_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `comm_num` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `allow_comm` tinyint(1) NOT NULL DEFAULT '1',
  `allow_main` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `approve` tinyint(1) NOT NULL DEFAULT '0',
  `fixed` tinyint(1) NOT NULL DEFAULT '0',
  `allow_br` tinyint(1) NOT NULL DEFAULT '1',
  `symbol` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metatitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_post`
--

INSERT INTO `dle_post` (`id`, `autor`, `date`, `short_story`, `full_story`, `xfields`, `title`, `descr`, `keywords`, `category`, `alt_name`, `comm_num`, `allow_comm`, `allow_main`, `approve`, `fixed`, `allow_br`, `symbol`, `tags`, `metatitle`) VALUES
(1, 'admin', '2026-02-19 10:24:57', '', '', '', 'Welcome', '', '', '1', 'post1', 0, 1, 1, 1, 0, 0, '', 'по, новости', ''),
(2, 'admin', '2026-02-19 10:24:37', 'Dear webmaster, we would like to add something. Before asking our technical support any questions, make sure that you carefully read the documentation on script and did not find the needed answer. We reserve the right to ignore questions received by us from users using a non-commercial version of the script or users who did not pay for the license that includes the technical support service. You can purchase one of two types of DataLife Engine license of your choice:<br><br>- <b>Basic license.</b> When you purchase this license, you also get the opportunity to receive new versions of script for free within <b>one year</b>.<br><br>- <b>Advanced license.</b> When you purchase this license you get everything that is included in the basic license and additionally you get technical support of the script and you are allowed to remove copyrights from the user part of the website (that is visible to visitors).<br><br><b>Validity of the license</b> is <span style=\"color:#FF0000\">1 year</span>, during which you will receive all the new versions and updates of the script for free, and if you purchase the advanced license you\'ll get the technical support. After expiration of the license, you can extend it, or use the current version of the script without updates.<br><br><b>Here you can read how to purchase the script</b> <a href=\"https://dle-news.com/price.html\" target=\"_blank\">https://dle-news.com/price.html</a><br><br>Note that one license can be used for one domain (project) and it can not be used on other websites. It is also prohibited to give your license file to others.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', 'Script purchase and payment', '', '', '1', 'post2', 0, 1, 1, 1, 0, 1, '', 'по, новости', ''),
(3, 'admin', '2026-02-19 10:24:07', '<b>Technical support is </b> provided by the <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">support forum</a> and via E-Mail. We try to answer all your questions, but due to the large number of visitors, it is not always possible. Therefore, guaranteed technical support is available only to users who have purchased the extended license. <br><br><b>Technical support service includes:</b><br><br>1. Users who faced with the script for the first time and of course do not know all the nuances of its work have the priority of answering the questions. Only failures of the script itself are the responsibility of technical support. If the reason of failure is your template that doesn\'t meet the requirements of the engine, then the support you may be denied.<br><br>2. Also you get a one-time opportunity to install the script on your server, including setting it up to full operation with current server settings (sometimes it is needed to correctly disable the User-Friendly URL, enable the specific features of Russian Apache for the correct images uploading, etc...).<br><br>3. You receive a consultancy support on working with the structure of the script. For example, if you want to make small changes to the script for more convenient work for you, you can save time on finding the correct piece of code by just asking us. You will be given an advice where to find it and how to implement your task better. (Note that we do not write additional modules for you, but only help you to understand the structure of the script better, so always ask related questions. Questions like: \"How to make this stuff\" may be ignored by customer support)<br><br>4. Another common problem is incorrect updating of the script. For example the server has failed during the update, where part of the new data was entered into the database and configurations, and the other part was not entered. As a result, you get a non-working script with all the consequences. In this case, you will be held manual correction of the damaged database structure.<br><br>If you are not subscribed to additional support services, your questions can be ignored and unanswered.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', 'Technical support of the engine', '', '', '1', 'post4', 0, 1, 1, 1, 0, 1, '', '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post_extras`
--

CREATE TABLE `dle_post_extras` (
  `eid` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `news_read` int NOT NULL DEFAULT '0',
  `allow_rate` tinyint(1) NOT NULL DEFAULT '1',
  `rating` int NOT NULL DEFAULT '0',
  `vote_num` int NOT NULL DEFAULT '0',
  `votes` tinyint(1) NOT NULL DEFAULT '0',
  `view_edit` tinyint(1) NOT NULL DEFAULT '0',
  `disable_index` tinyint(1) NOT NULL DEFAULT '0',
  `related_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `access` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `editdate` int UNSIGNED NOT NULL DEFAULT '0',
  `editor` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `user_id` int NOT NULL DEFAULT '0',
  `disable_search` tinyint(1) NOT NULL DEFAULT '0',
  `need_pass` tinyint(1) NOT NULL DEFAULT '0',
  `allow_rss` tinyint(1) NOT NULL DEFAULT '1',
  `allow_rss_turbo` tinyint(1) NOT NULL DEFAULT '1',
  `allow_rss_dzen` tinyint(1) NOT NULL DEFAULT '1',
  `edited_now` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allowed_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `not_allowed_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_post_extras`
--

INSERT INTO `dle_post_extras` (`eid`, `news_id`, `news_read`, `allow_rate`, `rating`, `vote_num`, `votes`, `view_edit`, `disable_index`, `related_ids`, `access`, `editdate`, `editor`, `reason`, `user_id`, `disable_search`, `need_pass`, `allow_rss`, `allow_rss_turbo`, `allow_rss_dzen`, `edited_now`, `allowed_country`, `not_allowed_country`) VALUES
(1, 1, 21, 1, 0, 0, 0, 0, 0, '2,3', '', 1774436291, 'admin', '', 1, 0, 0, 1, 1, 1, '{\"name\":\"admin\",\"time\":1774519943}', '', ''),
(2, 2, 0, 1, 0, 0, 0, 0, 0, '3,1', '', 0, '', '', 1, 0, 0, 1, 1, 1, '', '', ''),
(3, 3, 0, 1, 0, 0, 0, 0, 0, '', '', 0, '', '', 1, 0, 0, 1, 1, 1, '', '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post_extras_cats`
--

CREATE TABLE `dle_post_extras_cats` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `cat_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_post_extras_cats`
--

INSERT INTO `dle_post_extras_cats` (`id`, `news_id`, `cat_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post_i18n`
--

CREATE TABLE `dle_post_i18n` (
  `news_id` int UNSIGNED NOT NULL,
  `lang` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `alt_name` varchar(255) NOT NULL DEFAULT '',
  `short_story` mediumtext NOT NULL,
  `full_story` mediumtext NOT NULL,
  `descr` varchar(300) NOT NULL DEFAULT '',
  `keywords` text NOT NULL,
  `metatitle` varchar(300) NOT NULL DEFAULT '',
  `tags` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `dle_post_i18n`
--

INSERT INTO `dle_post_i18n` (`news_id`, `lang`, `title`, `alt_name`, `short_story`, `full_story`, `descr`, `keywords`, `metatitle`, `tags`) VALUES
(1, 'Azerbaijan', 'Welcome', 'welcome', '', '', '', '', '', 'по, новости'),
(1, 'English', 'Welcome', 'post1', '<div style=\"text-align:center;\"><img src=\"http://test.digitale.az/uploads/boxsmall.jpg\" alt=\"\" /></div>Welcome to the demo page of DataLife Engine. DataLife Engine is a multi-user news engine with a high functionality. First of all, the engine is designed to create news blogs and websites with a large information context. However, it has a lot of settings that allow you to use it for any purpose. The engine can be integrated into almost any existing design and it has no limatations for making new templates for it. Another key feature of DataLife Engine - is a low load on system resources. Server load will be minimal even when many users will be online, and you will not experience any problems with the information displaying. The engine is optimized for search engines. You can read about all the functional features on <a href=\"https://dle-news.com/\" target=\"_blank\">our page</a>.<br><br>Discussion of all issues on the script is conducted <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">here</a>. Also, you can get prompt assistance there.', '', '', '', '', 'по, новости'),
(1, 'Russian', 'Welcome', 'post1', '<div style=\"text-align:center;\"><img src=\"http://test.digitale.az/uploads/boxsmall.jpg\" alt=\"\" /></div>Welcome to the demo page of DataLife Engine. DataLife Engine is a multi-user news engine with a high functionality. First of all, the engine is designed to create news blogs and websites with a large information context. However, it has a lot of settings that allow you to use it for any purpose. The engine can be integrated into almost any existing design and it has no limatations for making new templates for it. Another key feature of DataLife Engine - is a low load on system resources. Server load will be minimal even when many users will be online, and you will not experience any problems with the information displaying. The engine is optimized for search engines. You can read about all the functional features on <a href=\"https://dle-news.com/\" target=\"_blank\">our page</a>.<br><br>Discussion of all issues on the script is conducted <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">here</a>. Also, you can get prompt assistance there.', '', '', '', '', 'по, новости'),
(2, 'Azerbaijan', 'Script purchase and payment', 'post2', 'Dear webmaster, we would like to add something. Before asking our technical support any questions, make sure that you carefully read the documentation on script and did not find the needed answer. We reserve the right to ignore questions received by us from users using a non-commercial version of the script or users who did not pay for the license that includes the technical support service. You can purchase one of two types of DataLife Engine license of your choice:<br><br>- <b>Basic license.</b> When you purchase this license, you also get the opportunity to receive new versions of script for free within <b>one year</b>.<br><br>- <b>Advanced license.</b> When you purchase this license you get everything that is included in the basic license and additionally you get technical support of the script and you are allowed to remove copyrights from the user part of the website (that is visible to visitors).<br><br><b>Validity of the license</b> is <span style=\"color:#FF0000\">1 year</span>, during which you will receive all the new versions and updates of the script for free, and if you purchase the advanced license you\'ll get the technical support. After expiration of the license, you can extend it, or use the current version of the script without updates.<br><br><b>Here you can read how to purchase the script</b> <a href=\"https://dle-news.com/price.html\" target=\"_blank\">https://dle-news.com/price.html</a><br><br>Note that one license can be used for one domain (project) and it can not be used on other websites. It is also prohibited to give your license file to others.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', 'по, новости'),
(2, 'English', 'Script purchase and payment', 'post2', 'Dear webmaster, we would like to add something. Before asking our technical support any questions, make sure that you carefully read the documentation on script and did not find the needed answer. We reserve the right to ignore questions received by us from users using a non-commercial version of the script or users who did not pay for the license that includes the technical support service. You can purchase one of two types of DataLife Engine license of your choice:<br><br>- <b>Basic license.</b> When you purchase this license, you also get the opportunity to receive new versions of script for free within <b>one year</b>.<br><br>- <b>Advanced license.</b> When you purchase this license you get everything that is included in the basic license and additionally you get technical support of the script and you are allowed to remove copyrights from the user part of the website (that is visible to visitors).<br><br><b>Validity of the license</b> is <span style=\"color:#FF0000\">1 year</span>, during which you will receive all the new versions and updates of the script for free, and if you purchase the advanced license you\'ll get the technical support. After expiration of the license, you can extend it, or use the current version of the script without updates.<br><br><b>Here you can read how to purchase the script</b> <a href=\"https://dle-news.com/price.html\" target=\"_blank\">https://dle-news.com/price.html</a><br><br>Note that one license can be used for one domain (project) and it can not be used on other websites. It is also prohibited to give your license file to others.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', 'по, новости'),
(2, 'Russian', 'Script purchase and payment', 'post2', 'Dear webmaster, we would like to add something. Before asking our technical support any questions, make sure that you carefully read the documentation on script and did not find the needed answer. We reserve the right to ignore questions received by us from users using a non-commercial version of the script or users who did not pay for the license that includes the technical support service. You can purchase one of two types of DataLife Engine license of your choice:<br><br>- <b>Basic license.</b> When you purchase this license, you also get the opportunity to receive new versions of script for free within <b>one year</b>.<br><br>- <b>Advanced license.</b> When you purchase this license you get everything that is included in the basic license and additionally you get technical support of the script and you are allowed to remove copyrights from the user part of the website (that is visible to visitors).<br><br><b>Validity of the license</b> is <span style=\"color:#FF0000\">1 year</span>, during which you will receive all the new versions and updates of the script for free, and if you purchase the advanced license you\'ll get the technical support. After expiration of the license, you can extend it, or use the current version of the script without updates.<br><br><b>Here you can read how to purchase the script</b> <a href=\"https://dle-news.com/price.html\" target=\"_blank\">https://dle-news.com/price.html</a><br><br>Note that one license can be used for one domain (project) and it can not be used on other websites. It is also prohibited to give your license file to others.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', 'по, новости'),
(3, 'Azerbaijan', 'Technical support of the engine', 'post4', '<b>Technical support is </b> provided by the <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">support forum</a> and via E-Mail. We try to answer all your questions, but due to the large number of visitors, it is not always possible. Therefore, guaranteed technical support is available only to users who have purchased the extended license. <br><br><b>Technical support service includes:</b><br><br>1. Users who faced with the script for the first time and of course do not know all the nuances of its work have the priority of answering the questions. Only failures of the script itself are the responsibility of technical support. If the reason of failure is your template that doesn\'t meet the requirements of the engine, then the support you may be denied.<br><br>2. Also you get a one-time opportunity to install the script on your server, including setting it up to full operation with current server settings (sometimes it is needed to correctly disable the User-Friendly URL, enable the specific features of Russian Apache for the correct images uploading, etc...).<br><br>3. You receive a consultancy support on working with the structure of the script. For example, if you want to make small changes to the script for more convenient work for you, you can save time on finding the correct piece of code by just asking us. You will be given an advice where to find it and how to implement your task better. (Note that we do not write additional modules for you, but only help you to understand the structure of the script better, so always ask related questions. Questions like: \"How to make this stuff\" may be ignored by customer support)<br><br>4. Another common problem is incorrect updating of the script. For example the server has failed during the update, where part of the new data was entered into the database and configurations, and the other part was not entered. As a result, you get a non-working script with all the consequences. In this case, you will be held manual correction of the damaged database structure.<br><br>If you are not subscribed to additional support services, your questions can be ignored and unanswered.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', ''),
(3, 'English', 'Technical support of the engine', 'post4', '<b>Technical support is </b> provided by the <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">support forum</a> and via E-Mail. We try to answer all your questions, but due to the large number of visitors, it is not always possible. Therefore, guaranteed technical support is available only to users who have purchased the extended license. <br><br><b>Technical support service includes:</b><br><br>1. Users who faced with the script for the first time and of course do not know all the nuances of its work have the priority of answering the questions. Only failures of the script itself are the responsibility of technical support. If the reason of failure is your template that doesn\'t meet the requirements of the engine, then the support you may be denied.<br><br>2. Also you get a one-time opportunity to install the script on your server, including setting it up to full operation with current server settings (sometimes it is needed to correctly disable the User-Friendly URL, enable the specific features of Russian Apache for the correct images uploading, etc...).<br><br>3. You receive a consultancy support on working with the structure of the script. For example, if you want to make small changes to the script for more convenient work for you, you can save time on finding the correct piece of code by just asking us. You will be given an advice where to find it and how to implement your task better. (Note that we do not write additional modules for you, but only help you to understand the structure of the script better, so always ask related questions. Questions like: \"How to make this stuff\" may be ignored by customer support)<br><br>4. Another common problem is incorrect updating of the script. For example the server has failed during the update, where part of the new data was entered into the database and configurations, and the other part was not entered. As a result, you get a non-working script with all the consequences. In this case, you will be held manual correction of the damaged database structure.<br><br>If you are not subscribed to additional support services, your questions can be ignored and unanswered.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', ''),
(3, 'Russian', 'Technical support of the engine', 'post4', '<b>Technical support is </b> provided by the <a href=\"https://forum.dle-news.ru/index.php\" target=\"_blank\">support forum</a> and via E-Mail. We try to answer all your questions, but due to the large number of visitors, it is not always possible. Therefore, guaranteed technical support is available only to users who have purchased the extended license. <br><br><b>Technical support service includes:</b><br><br>1. Users who faced with the script for the first time and of course do not know all the nuances of its work have the priority of answering the questions. Only failures of the script itself are the responsibility of technical support. If the reason of failure is your template that doesn\'t meet the requirements of the engine, then the support you may be denied.<br><br>2. Also you get a one-time opportunity to install the script on your server, including setting it up to full operation with current server settings (sometimes it is needed to correctly disable the User-Friendly URL, enable the specific features of Russian Apache for the correct images uploading, etc...).<br><br>3. You receive a consultancy support on working with the structure of the script. For example, if you want to make small changes to the script for more convenient work for you, you can save time on finding the correct piece of code by just asking us. You will be given an advice where to find it and how to implement your task better. (Note that we do not write additional modules for you, but only help you to understand the structure of the script better, so always ask related questions. Questions like: \"How to make this stuff\" may be ignored by customer support)<br><br>4. Another common problem is incorrect updating of the script. For example the server has failed during the update, where part of the new data was entered into the database and configurations, and the other part was not entered. As a result, you get a non-working script with all the consequences. In this case, you will be held manual correction of the damaged database structure.<br><br>If you are not subscribed to additional support services, your questions can be ignored and unanswered.<br><br><b>Sincerely,<br><br>SoftNews Media Group</b>', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post_log`
--

CREATE TABLE `dle_post_log` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `expires` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `action` tinyint(1) NOT NULL DEFAULT '0',
  `move_cat` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_post_pass`
--

CREATE TABLE `dle_post_pass` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_question`
--

CREATE TABLE `dle_question` (
  `id` int NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_read_log`
--

CREATE TABLE `dle_read_log` (
  `id` int UNSIGNED NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_redirects`
--

CREATE TABLE `dle_redirects` (
  `id` int UNSIGNED NOT NULL,
  `from` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `to` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_rss`
--

CREATE TABLE `dle_rss` (
  `id` smallint NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_main` tinyint(1) NOT NULL DEFAULT '0',
  `allow_rating` tinyint(1) NOT NULL DEFAULT '0',
  `allow_comm` tinyint(1) NOT NULL DEFAULT '0',
  `text_type` tinyint(1) NOT NULL DEFAULT '0',
  `date` tinyint(1) NOT NULL DEFAULT '0',
  `search` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `max_news` tinyint NOT NULL DEFAULT '0',
  `cookie` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category` smallint NOT NULL DEFAULT '0',
  `lastdate` int UNSIGNED NOT NULL DEFAULT '0',
  `allow_source` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_rss`
--

INSERT INTO `dle_rss` (`id`, `url`, `description`, `allow_main`, `allow_rating`, `allow_comm`, `text_type`, `date`, `search`, `max_news`, `cookie`, `category`, `lastdate`, `allow_source`) VALUES
(1, 'https://dle-news.ru/rss.xml', 'DataLife Engine Official Website', 1, 1, 1, 1, 1, '<div class=\"card-body post-body pl-4 pr-3 pb-4 pt-0\">{get}<div class=\"card-footer d-flex align-content-center pt-0 pl-0 pr-4 pb-3\">', 5, '', 1, 0, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_rssinform`
--

CREATE TABLE `dle_rssinform` (
  `id` smallint NOT NULL,
  `tag` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `template` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `news_max` smallint NOT NULL DEFAULT '0',
  `tmax` smallint NOT NULL DEFAULT '0',
  `dmax` smallint NOT NULL DEFAULT '0',
  `approve` tinyint(1) NOT NULL DEFAULT '1',
  `rss_date_format` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_rssinform`
--

INSERT INTO `dle_rssinform` (`id`, `tag`, `descr`, `category`, `url`, `template`, `news_max`, `tmax`, `dmax`, `approve`, `rss_date_format`) VALUES
(1, 'dle', 'News', '0', 'https://news.google.com/rss?q=technology&hl=en', 'informer', 3, 0, 200, 1, 'j F Y H:i');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_sendlog`
--

CREATE TABLE `dle_sendlog` (
  `id` int UNSIGNED NOT NULL,
  `user` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` int UNSIGNED NOT NULL DEFAULT '0',
  `flag` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_settings_i18n`
--

CREATE TABLE `dle_settings_i18n` (
  `setting_key` varchar(100) NOT NULL,
  `lang` varchar(32) NOT NULL,
  `setting_value` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `dle_settings_i18n`
--

INSERT INTO `dle_settings_i18n` (`setting_key`, `lang`, `setting_value`) VALUES
('home_title', 'Azerbaijan', 'DataLife Engine'),
('home_title', 'English', 'DataLife Engine'),
('home_title', 'Russian', 'DataLife Engine'),
('short_title', 'Azerbaijan', 'Website Demo'),
('short_title', 'English', 'Website Demo'),
('short_title', 'Russian', 'Website Demo');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_social_login`
--

CREATE TABLE `dle_social_login` (
  `id` int NOT NULL,
  `sid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `uid` int NOT NULL DEFAULT '0',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `provider` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `wait` tinyint(1) NOT NULL DEFAULT '0',
  `waitlogin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_spam_log`
--

CREATE TABLE `dle_spam_log` (
  `id` int UNSIGNED NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_spammer` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_static`
--

CREATE TABLE `dle_static` (
  `id` mediumint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `template` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_br` tinyint(1) NOT NULL DEFAULT '0',
  `allow_template` tinyint(1) NOT NULL DEFAULT '0',
  `grouplevel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'all',
  `tpl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metadescr` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metakeys` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `views` mediumint NOT NULL DEFAULT '0',
  `template_folder` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` int UNSIGNED NOT NULL DEFAULT '0',
  `metatitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_count` tinyint(1) NOT NULL DEFAULT '1',
  `sitemap` tinyint(1) NOT NULL DEFAULT '1',
  `disable_index` tinyint(1) NOT NULL DEFAULT '0',
  `disable_search` tinyint(1) NOT NULL DEFAULT '0',
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_static`
--

INSERT INTO `dle_static` (`id`, `name`, `descr`, `template`, `allow_br`, `allow_template`, `grouplevel`, `tpl`, `metadescr`, `metakeys`, `views`, `template_folder`, `date`, `metatitle`, `allow_count`, `sitemap`, `disable_index`, `disable_search`, `password`) VALUES
(1, 'dle-rules-page', 'General rules on the website', '<b>General rules of conduct on the website:</b><br><br>To begin with, hundreds of people of different religions and beliefs are communicate on the website, and all of them are full-fledged visitors of our website, so if we want a community of people to function, then we need rules. We strongly recommend that you read these rules. It will take just five minutes, but it will save your and our time and will help make the website more interesting and organized.<br><br>Firstly, you should behave respectfully to all visitors on our website. Do not insult to the participants, it is always unwanted. If you have a complaint - contact administrators or moderators (use personal messages). We considered insulting of other visitors one of the most serious violations and it is severely punished by the administration. <b>Racism, religious and political speech are strictly forbidden.</b> Thank you for your understanding and desire to make our website more polite and friendly.<br><br><b>The following is strictly prohibited:</b> <br><br>- messages not related to the content of the article or to the context of the discussion<br>- insults and threats to other visitors<br>- expressions that contain profanity, degrading, inciting ethnic strife are prohibited in comments<br>- spam and advertising of any goods and services, other resources, media or events not related to the context of discussion of the article<br><br>Let us respect each other and the site where you and other readers come to talk and express their thoughts. The Administration reserves the right to remove comments, or comment parts, if they do not meet these requirements.<br><br>If you violate the rules you may be given a <b>warning</b>. In some cases, you may be banned <b>without warning</b>. Contact the Administrator regarding ban removal.<br><br><b>Insulting</b> of administrators and moderators is also punished by a <b>ban</b> - Respect other people\'s labor.<br><br><div style=\"text-align:center;\">{ACCEPT-DECLINE}</div>', 1, 1, 'all', '', 'General rules on the website', 'General rules on the website', 16, '', 1771496697, '', 1, 1, 0, 0, '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_static_files`
--

CREATE TABLE `dle_static_files` (
  `id` int NOT NULL,
  `static_id` int NOT NULL DEFAULT '0',
  `author` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `onserver` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `dcount` int NOT NULL DEFAULT '0',
  `size` bigint NOT NULL DEFAULT '0',
  `checksum` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `driver` mediumint NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_static_i18n`
--

CREATE TABLE `dle_static_i18n` (
  `static_id` int UNSIGNED NOT NULL,
  `lang` varchar(32) NOT NULL,
  `descr` varchar(255) NOT NULL DEFAULT '',
  `template` mediumtext NOT NULL,
  `metadescr` varchar(300) NOT NULL DEFAULT '',
  `metakeys` text NOT NULL,
  `metatitle` varchar(300) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `dle_static_i18n`
--

INSERT INTO `dle_static_i18n` (`static_id`, `lang`, `descr`, `template`, `metadescr`, `metakeys`, `metatitle`) VALUES
(1, 'Azerbaijan', 'General rules on the website', '<b>General rules of conduct on the website:</b><br><br>To begin with, hundreds of people of different religions and beliefs are communicate on the website, and all of them are full-fledged visitors of our website, so if we want a community of people to function, then we need rules. We strongly recommend that you read these rules. It will take just five minutes, but it will save your and our time and will help make the website more interesting and organized.<br><br>Firstly, you should behave respectfully to all visitors on our website. Do not insult to the participants, it is always unwanted. If you have a complaint - contact administrators or moderators (use personal messages). We considered insulting of other visitors one of the most serious violations and it is severely punished by the administration. <b>Racism, religious and political speech are strictly forbidden.</b> Thank you for your understanding and desire to make our website more polite and friendly.<br><br><b>The following is strictly prohibited:</b> <br><br>- messages not related to the content of the article or to the context of the discussion<br>- insults and threats to other visitors<br>- expressions that contain profanity, degrading, inciting ethnic strife are prohibited in comments<br>- spam and advertising of any goods and services, other resources, media or events not related to the context of discussion of the article<br><br>Let us respect each other and the site where you and other readers come to talk and express their thoughts. The Administration reserves the right to remove comments, or comment parts, if they do not meet these requirements.<br><br>If you violate the rules you may be given a <b>warning</b>. In some cases, you may be banned <b>without warning</b>. Contact the Administrator regarding ban removal.<br><br><b>Insulting</b> of administrators and moderators is also punished by a <b>ban</b> - Respect other people\'s labor.<br><br><div style=\"text-align:center;\">{ACCEPT-DECLINE}</div>', 'General rules on the website', 'General rules on the website', ''),
(1, 'English', 'General rules on the website', '<b>General rules of conduct on the website:</b><br><br>To begin with, hundreds of people of different religions and beliefs are communicate on the website, and all of them are full-fledged visitors of our website, so if we want a community of people to function, then we need rules. We strongly recommend that you read these rules. It will take just five minutes, but it will save your and our time and will help make the website more interesting and organized.<br><br>Firstly, you should behave respectfully to all visitors on our website. Do not insult to the participants, it is always unwanted. If you have a complaint - contact administrators or moderators (use personal messages). We considered insulting of other visitors one of the most serious violations and it is severely punished by the administration. <b>Racism, religious and political speech are strictly forbidden.</b> Thank you for your understanding and desire to make our website more polite and friendly.<br><br><b>The following is strictly prohibited:</b> <br><br>- messages not related to the content of the article or to the context of the discussion<br>- insults and threats to other visitors<br>- expressions that contain profanity, degrading, inciting ethnic strife are prohibited in comments<br>- spam and advertising of any goods and services, other resources, media or events not related to the context of discussion of the article<br><br>Let us respect each other and the site where you and other readers come to talk and express their thoughts. The Administration reserves the right to remove comments, or comment parts, if they do not meet these requirements.<br><br>If you violate the rules you may be given a <b>warning</b>. In some cases, you may be banned <b>without warning</b>. Contact the Administrator regarding ban removal.<br><br><b>Insulting</b> of administrators and moderators is also punished by a <b>ban</b> - Respect other people\'s labor.<br><br><div style=\"text-align:center;\">{ACCEPT-DECLINE}</div>', 'General rules on the website', 'General rules on the website', ''),
(1, 'Russian', 'General rules on the website', '<b>General rules of conduct on the website:</b><br><br>To begin with, hundreds of people of different religions and beliefs are communicate on the website, and all of them are full-fledged visitors of our website, so if we want a community of people to function, then we need rules. We strongly recommend that you read these rules. It will take just five minutes, but it will save your and our time and will help make the website more interesting and organized.<br><br>Firstly, you should behave respectfully to all visitors on our website. Do not insult to the participants, it is always unwanted. If you have a complaint - contact administrators or moderators (use personal messages). We considered insulting of other visitors one of the most serious violations and it is severely punished by the administration. <b>Racism, religious and political speech are strictly forbidden.</b> Thank you for your understanding and desire to make our website more polite and friendly.<br><br><b>The following is strictly prohibited:</b> <br><br>- messages not related to the content of the article or to the context of the discussion<br>- insults and threats to other visitors<br>- expressions that contain profanity, degrading, inciting ethnic strife are prohibited in comments<br>- spam and advertising of any goods and services, other resources, media or events not related to the context of discussion of the article<br><br>Let us respect each other and the site where you and other readers come to talk and express their thoughts. The Administration reserves the right to remove comments, or comment parts, if they do not meet these requirements.<br><br>If you violate the rules you may be given a <b>warning</b>. In some cases, you may be banned <b>without warning</b>. Contact the Administrator regarding ban removal.<br><br><b>Insulting</b> of administrators and moderators is also punished by a <b>ban</b> - Respect other people\'s labor.<br><br><div style=\"text-align:center;\">{ACCEPT-DECLINE}</div>', 'General rules on the website', 'General rules on the website', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_storage`
--

CREATE TABLE `dle_storage` (
  `id` mediumint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `type` smallint NOT NULL DEFAULT '0',
  `accesstype` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `connect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `connect_port` mediumint NOT NULL DEFAULT '0',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `http_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `client_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `default_storage` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `posi` mediumint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_subscribe`
--

CREATE TABLE `dle_subscribe` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `news_id` int NOT NULL DEFAULT '0',
  `hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_tags`
--

CREATE TABLE `dle_tags` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_tags`
--

INSERT INTO `dle_tags` (`id`, `news_id`, `tag`) VALUES
(1, 1, 'software'),
(2, 2, 'software'),
(3, 3, 'software'),
(4, 1, 'news'),
(5, 2, 'news');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_twofactor`
--

CREATE TABLE `dle_twofactor` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `pin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `attempt` tinyint(1) NOT NULL DEFAULT '0',
  `date` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_usergroups`
--

CREATE TABLE `dle_usergroups` (
  `id` smallint NOT NULL,
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_cats` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_adds` tinyint(1) NOT NULL DEFAULT '1',
  `cat_add` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_admin` tinyint(1) NOT NULL DEFAULT '0',
  `allow_addc` tinyint(1) NOT NULL DEFAULT '0',
  `allow_editc` tinyint(1) NOT NULL DEFAULT '0',
  `allow_delc` tinyint(1) NOT NULL DEFAULT '0',
  `edit_allc` tinyint(1) NOT NULL DEFAULT '0',
  `del_allc` tinyint(1) NOT NULL DEFAULT '0',
  `moderation` tinyint(1) NOT NULL DEFAULT '0',
  `allow_all_edit` tinyint(1) NOT NULL DEFAULT '0',
  `allow_edit` tinyint(1) NOT NULL DEFAULT '0',
  `allow_pm` tinyint(1) NOT NULL DEFAULT '0',
  `max_pm` smallint NOT NULL DEFAULT '0',
  `max_foto` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_files` tinyint(1) NOT NULL DEFAULT '0',
  `allow_hide` tinyint(1) NOT NULL DEFAULT '1',
  `allow_short` tinyint(1) NOT NULL DEFAULT '0',
  `time_limit` tinyint(1) NOT NULL DEFAULT '0',
  `rid` smallint NOT NULL DEFAULT '0',
  `allow_fixed` tinyint(1) NOT NULL DEFAULT '0',
  `allow_feed` tinyint(1) NOT NULL DEFAULT '1',
  `allow_search` tinyint(1) NOT NULL DEFAULT '1',
  `allow_poll` tinyint(1) NOT NULL DEFAULT '1',
  `allow_main` tinyint(1) NOT NULL DEFAULT '1',
  `captcha` tinyint(1) NOT NULL DEFAULT '0',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_modc` tinyint(1) NOT NULL DEFAULT '0',
  `allow_rating` tinyint(1) NOT NULL DEFAULT '1',
  `allow_offline` tinyint(1) NOT NULL DEFAULT '0',
  `allow_image_upload` tinyint(1) NOT NULL DEFAULT '0',
  `allow_file_upload` tinyint(1) NOT NULL DEFAULT '0',
  `allow_signature` tinyint(1) NOT NULL DEFAULT '0',
  `allow_url` tinyint(1) NOT NULL DEFAULT '1',
  `news_sec_code` tinyint(1) NOT NULL DEFAULT '1',
  `allow_image` tinyint(1) NOT NULL DEFAULT '0',
  `max_signature` smallint NOT NULL DEFAULT '0',
  `max_info` smallint NOT NULL DEFAULT '0',
  `admin_addnews` tinyint(1) NOT NULL DEFAULT '0',
  `admin_editnews` tinyint(1) NOT NULL DEFAULT '0',
  `admin_comments` tinyint(1) NOT NULL DEFAULT '0',
  `admin_categories` tinyint(1) NOT NULL DEFAULT '0',
  `admin_editusers` tinyint(1) NOT NULL DEFAULT '0',
  `admin_wordfilter` tinyint(1) NOT NULL DEFAULT '0',
  `admin_xfields` tinyint(1) NOT NULL DEFAULT '0',
  `admin_userfields` tinyint(1) NOT NULL DEFAULT '0',
  `admin_static` tinyint(1) NOT NULL DEFAULT '0',
  `admin_editvote` tinyint(1) NOT NULL DEFAULT '0',
  `admin_newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `admin_blockip` tinyint(1) NOT NULL DEFAULT '0',
  `admin_banners` tinyint(1) NOT NULL DEFAULT '0',
  `admin_rss` tinyint(1) NOT NULL DEFAULT '0',
  `admin_iptools` tinyint(1) NOT NULL DEFAULT '0',
  `admin_rssinform` tinyint(1) NOT NULL DEFAULT '0',
  `admin_googlemap` tinyint(1) NOT NULL DEFAULT '0',
  `allow_html` tinyint(1) NOT NULL DEFAULT '1',
  `group_prefix` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group_suffix` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_subscribe` tinyint(1) NOT NULL DEFAULT '0',
  `allow_image_size` tinyint(1) NOT NULL DEFAULT '0',
  `cat_allow_addnews` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flood_news` smallint NOT NULL DEFAULT '0',
  `max_day_news` smallint NOT NULL DEFAULT '0',
  `force_leech` tinyint(1) NOT NULL DEFAULT '0',
  `edit_limit` smallint NOT NULL DEFAULT '0',
  `captcha_pm` tinyint(1) NOT NULL DEFAULT '0',
  `max_pm_day` smallint NOT NULL DEFAULT '0',
  `max_mail_day` smallint NOT NULL DEFAULT '0',
  `admin_tagscloud` tinyint(1) NOT NULL DEFAULT '0',
  `allow_vote` tinyint(1) NOT NULL DEFAULT '0',
  `admin_complaint` tinyint(1) NOT NULL DEFAULT '0',
  `news_question` tinyint(1) NOT NULL DEFAULT '0',
  `comments_question` tinyint(1) NOT NULL DEFAULT '0',
  `max_comment_day` smallint NOT NULL DEFAULT '0',
  `max_images` smallint NOT NULL DEFAULT '0',
  `max_files` smallint NOT NULL DEFAULT '0',
  `disable_news_captcha` smallint NOT NULL DEFAULT '0',
  `disable_comments_captcha` smallint NOT NULL DEFAULT '0',
  `pm_question` tinyint(1) NOT NULL DEFAULT '0',
  `captcha_feedback` tinyint(1) NOT NULL DEFAULT '1',
  `feedback_question` tinyint(1) NOT NULL DEFAULT '0',
  `files_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `max_file_size` mediumint NOT NULL DEFAULT '0',
  `files_max_speed` smallint NOT NULL DEFAULT '0',
  `spamfilter` tinyint(1) NOT NULL DEFAULT '2',
  `allow_comments_rating` tinyint(1) NOT NULL DEFAULT '1',
  `max_edit_days` tinyint(1) NOT NULL DEFAULT '0',
  `spampmfilter` tinyint(1) NOT NULL DEFAULT '0',
  `force_reg` tinyint(1) NOT NULL DEFAULT '0',
  `force_reg_days` mediumint NOT NULL DEFAULT '0',
  `force_reg_group` smallint NOT NULL DEFAULT '4',
  `force_news` tinyint(1) NOT NULL DEFAULT '0',
  `force_news_count` mediumint NOT NULL DEFAULT '0',
  `force_news_group` smallint NOT NULL DEFAULT '4',
  `force_comments` tinyint(1) NOT NULL DEFAULT '0',
  `force_comments_count` mediumint NOT NULL DEFAULT '0',
  `force_comments_group` smallint NOT NULL DEFAULT '4',
  `force_rating` tinyint(1) NOT NULL DEFAULT '0',
  `force_rating_count` mediumint NOT NULL DEFAULT '0',
  `force_rating_group` smallint NOT NULL DEFAULT '4',
  `not_allow_cats` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allow_up_image` tinyint(1) NOT NULL DEFAULT '0',
  `allow_up_watermark` tinyint(1) NOT NULL DEFAULT '0',
  `allow_up_thumb` tinyint(1) NOT NULL DEFAULT '0',
  `up_count_image` smallint NOT NULL DEFAULT '0',
  `up_image_side` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `up_image_size` mediumint NOT NULL DEFAULT '0',
  `up_thumb_size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_mail_files` tinyint(1) NOT NULL DEFAULT '0',
  `max_mail_files` smallint NOT NULL DEFAULT '0',
  `max_mail_allfiles` mediumint NOT NULL DEFAULT '0',
  `mail_files_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `video_comments` tinyint(1) NOT NULL DEFAULT '0',
  `media_comments` tinyint(1) NOT NULL DEFAULT '0',
  `min_image_side` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_public_file_upload` tinyint(1) NOT NULL DEFAULT '0',
  `force_comments_rating` tinyint(1) NOT NULL DEFAULT '0',
  `force_comments_rating_count` mediumint NOT NULL DEFAULT '0',
  `force_comments_rating_group` smallint NOT NULL DEFAULT '0',
  `max_downloads` smallint NOT NULL DEFAULT '0',
  `admin_links` tinyint(1) NOT NULL DEFAULT '0',
  `admin_meta` tinyint(1) NOT NULL DEFAULT '0',
  `admin_redirects` tinyint(1) NOT NULL DEFAULT '0',
  `allow_change_storage` tinyint(1) NOT NULL DEFAULT '0',
  `self_delete` tinyint(1) NOT NULL DEFAULT '2',
  `allow_complaint_news` tinyint(1) NOT NULL DEFAULT '1',
  `allow_complaint_comments` tinyint(1) NOT NULL DEFAULT '1',
  `allow_complaint_orfo` tinyint(1) NOT NULL DEFAULT '1',
  `flood_time` smallint NOT NULL DEFAULT '0',
  `max_c_negative` smallint NOT NULL DEFAULT '0',
  `max_n_negative` smallint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_usergroups`
--

INSERT INTO `dle_usergroups` (`id`, `group_name`, `allow_cats`, `allow_adds`, `cat_add`, `allow_admin`, `allow_addc`, `allow_editc`, `allow_delc`, `edit_allc`, `del_allc`, `moderation`, `allow_all_edit`, `allow_edit`, `allow_pm`, `max_pm`, `max_foto`, `allow_files`, `allow_hide`, `allow_short`, `time_limit`, `rid`, `allow_fixed`, `allow_feed`, `allow_search`, `allow_poll`, `allow_main`, `captcha`, `icon`, `allow_modc`, `allow_rating`, `allow_offline`, `allow_image_upload`, `allow_file_upload`, `allow_signature`, `allow_url`, `news_sec_code`, `allow_image`, `max_signature`, `max_info`, `admin_addnews`, `admin_editnews`, `admin_comments`, `admin_categories`, `admin_editusers`, `admin_wordfilter`, `admin_xfields`, `admin_userfields`, `admin_static`, `admin_editvote`, `admin_newsletter`, `admin_blockip`, `admin_banners`, `admin_rss`, `admin_iptools`, `admin_rssinform`, `admin_googlemap`, `allow_html`, `group_prefix`, `group_suffix`, `allow_subscribe`, `allow_image_size`, `cat_allow_addnews`, `flood_news`, `max_day_news`, `force_leech`, `edit_limit`, `captcha_pm`, `max_pm_day`, `max_mail_day`, `admin_tagscloud`, `allow_vote`, `admin_complaint`, `news_question`, `comments_question`, `max_comment_day`, `max_images`, `max_files`, `disable_news_captcha`, `disable_comments_captcha`, `pm_question`, `captcha_feedback`, `feedback_question`, `files_type`, `max_file_size`, `files_max_speed`, `spamfilter`, `allow_comments_rating`, `max_edit_days`, `spampmfilter`, `force_reg`, `force_reg_days`, `force_reg_group`, `force_news`, `force_news_count`, `force_news_group`, `force_comments`, `force_comments_count`, `force_comments_group`, `force_rating`, `force_rating_count`, `force_rating_group`, `not_allow_cats`, `allow_up_image`, `allow_up_watermark`, `allow_up_thumb`, `up_count_image`, `up_image_side`, `up_image_size`, `up_thumb_size`, `allow_mail_files`, `max_mail_files`, `max_mail_allfiles`, `mail_files_type`, `video_comments`, `media_comments`, `min_image_side`, `allow_public_file_upload`, `force_comments_rating`, `force_comments_rating_count`, `force_comments_rating_group`, `max_downloads`, `admin_links`, `admin_meta`, `admin_redirects`, `allow_change_storage`, `self_delete`, `allow_complaint_news`, `allow_complaint_comments`, `allow_complaint_orfo`, `flood_time`, `max_c_negative`, `max_n_negative`) VALUES
(1, 'Administrators', 'all', 1, 'all', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 50, '101', 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, '{THEME}/images/icon_1.gif', 0, 1, 1, 1, 1, 1, 1, 0, 1, 500, 1000, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '<b><span style=\"color:red\">', '</span></b>', 1, 1, 'all', 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 'zip,rar,doc,pdf,mp3,mp4', 4096, 0, 2, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, '', 1, 1, 1, 3, '800x600', 300, '200x150', 1, 3, 1000, 'jpg,png,zip,pdf', 1, 1, '10x10', 1, 0, 0, 4, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0),
(2, 'Chief Editors', 'all', 1, 'all', 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 50, '101', 1, 1, 1, 0, 2, 1, 1, 1, 1, 1, 0, '{THEME}/images/icon_2.gif', 0, 1, 0, 1, 1, 1, 1, 0, 1, 500, 1000, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '', 1, 1, 'all', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 'zip,rar,doc,pdf,mp3,mp4', 4096, 0, 2, 1, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 2, 0, 0, 2, '', 1, 1, 1, 3, '800x600', 300, '200x150', 1, 3, 1000, 'jpg,png,zip,pdf', 1, 1, '10x10', 1, 0, 0, 4, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0),
(3, 'Journalists', 'all', 1, 'all', 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 50, '101', 1, 1, 1, 0, 3, 0, 1, 1, 1, 1, 0, '{THEME}/images/icon_3.gif', 0, 1, 0, 1, 1, 1, 1, 0, 1, 500, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '', 1, 1, 'all', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 'zip,rar,doc,pdf,mp3,mp4', 4096, 0, 2, 1, 0, 0, 0, 0, 3, 0, 0, 3, 0, 0, 3, 0, 0, 3, '', 1, 1, 1, 3, '800x600', 300, '200x150', 0, 3, 1000, 'jpg,png,zip,pdf', 1, 1, '10x10', 0, 0, 0, 4, 0, 0, 0, 0, 1, 2, 1, 1, 1, 30, 0, 0),
(4, 'Visitors', 'all', 1, 'all', 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 20, '101', 1, 1, 1, 0, 4, 0, 1, 1, 1, 1, 0, '{THEME}/images/icon_4.gif', 0, 1, 0, 1, 0, 1, 1, 1, 0, 500, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '', '', 1, 0, 'all', 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 'zip,rar,doc,pdf,mp3,mp4', 4096, 0, 2, 1, 0, 2, 0, 0, 4, 0, 0, 4, 0, 0, 4, 0, 0, 4, '', 0, 0, 0, 1, '800x600', 300, '200x150', 0, 3, 1000, 'jpg,png,zip,pdf', 0, 0, '10x10', 0, 0, 0, 4, 0, 0, 0, 0, 0, 2, 1, 1, 1, 30, 3, 3),
(5, 'Guests', 'all', 0, 'all', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0', 1, 0, 1, 0, 5, 0, 1, 1, 1, 0, 1, '{THEME}/images/icon_5.gif', 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 'all', 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, '', 0, 0, 2, 1, 0, 2, 0, 0, 5, 0, 0, 5, 0, 0, 5, 0, 0, 5, '', 0, 0, 0, 1, '800x600', 300, '200x150', 0, 3, 1000, 'jpg,png,zip,pdf', 0, 0, '10x10', 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 1, 1, 1, 30, 3, 3);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_users`
--

CREATE TABLE `dle_users` (
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `user_id` int NOT NULL,
  `news_num` mediumint NOT NULL DEFAULT '0',
  `comm_num` mediumint NOT NULL DEFAULT '0',
  `user_group` smallint NOT NULL DEFAULT '4',
  `lastdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `reg_date` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `banned` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `allow_mail` tinyint(1) NOT NULL DEFAULT '1',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `signature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `land` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `favorites` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pm_all` smallint NOT NULL DEFAULT '0',
  `pm_unread` smallint NOT NULL DEFAULT '0',
  `time_limit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `xfields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `allowed_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `logged_ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  `restricted_days` smallint NOT NULL DEFAULT '0',
  `restricted_date` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `timezone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `news_subscribe` tinyint(1) NOT NULL DEFAULT '0',
  `comments_reply_subscribe` tinyint(1) NOT NULL DEFAULT '0',
  `twofactor_auth` tinyint(1) NOT NULL DEFAULT '0',
  `cat_add` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `cat_allow_addnews` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `twofactor_secret` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_users`
--

INSERT INTO `dle_users` (`email`, `password`, `name`, `user_id`, `news_num`, `comm_num`, `user_group`, `lastdate`, `reg_date`, `banned`, `allow_mail`, `info`, `signature`, `foto`, `fullname`, `land`, `favorites`, `pm_all`, `pm_unread`, `time_limit`, `xfields`, `allowed_ip`, `hash`, `logged_ip`, `restricted`, `restricted_days`, `restricted_date`, `timezone`, `news_subscribe`, `comments_reply_subscribe`, `twofactor_auth`, `cat_add`, `cat_allow_addnews`, `twofactor_secret`) VALUES
('admin@mail.ru', '$2y$10$TSOetRtIgSxBOrzDtbsjlevT5PvXaOeLzkzBjxVeEeKFN7s2JQQg2', 'admin', 1, 3, 0, 1, '1774519962', '1771496697', '', 1, '', '', '', '', '', '', 0, 0, '', '', '', '48cfcc14c983577debe1ef73cc4e3fca', '::1', 0, 0, '', '', 0, 0, 0, '', '', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_users_delete`
--

CREATE TABLE `dle_users_delete` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_views`
--

CREATE TABLE `dle_views` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_vote`
--

CREATE TABLE `dle_vote` (
  `id` mediumint NOT NULL,
  `category` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `vote_num` mediumint NOT NULL DEFAULT '0',
  `date` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `approve` tinyint(1) NOT NULL DEFAULT '1',
  `start` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `end` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `grouplevel` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'all'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `dle_vote`
--

INSERT INTO `dle_vote` (`id`, `category`, `vote_num`, `date`, `title`, `body`, `approve`, `start`, `end`, `grouplevel`) VALUES
(1, 'all', 0, '2026-02-19 10:24:57', 'Please, rate the engine', 'The best of news engines<br>A good engine<br>It\'s ok, but...<br>I have seen better<br>Don\'t like it at all', 1, '', '', 'all');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_vote_result`
--

CREATE TABLE `dle_vote_result` (
  `id` int NOT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `vote_id` mediumint NOT NULL DEFAULT '0',
  `answer` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dle_xfsearch`
--

CREATE TABLE `dle_xfsearch` (
  `id` int NOT NULL,
  `news_id` int NOT NULL DEFAULT '0',
  `tagname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `tagvalue` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `dle_admin_logs`
--
ALTER TABLE `dle_admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date` (`date`);

--
-- Tablo için indeksler `dle_admin_sections`
--
ALTER TABLE `dle_admin_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Tablo için indeksler `dle_banned`
--
ALTER TABLE `dle_banned`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`users_id`);

--
-- Tablo için indeksler `dle_banners`
--
ALTER TABLE `dle_banners`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_banners_logs`
--
ALTER TABLE `dle_banners_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bid` (`bid`),
  ADD KEY `ip` (`ip`);

--
-- Tablo için indeksler `dle_banners_rubrics`
--
ALTER TABLE `dle_banners_rubrics`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_category`
--
ALTER TABLE `dle_category`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_category_i18n`
--
ALTER TABLE `dle_category_i18n`
  ADD PRIMARY KEY (`category_id`,`lang`),
  ADD KEY `lang` (`lang`);

--
-- Tablo için indeksler `dle_comments`
--
ALTER TABLE `dle_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `approve` (`approve`),
  ADD KEY `parent` (`parent`),
  ADD KEY `rating` (`rating`);
ALTER TABLE `dle_comments` ADD FULLTEXT KEY `text` (`text`);

--
-- Tablo için indeksler `dle_comments_files`
--
ALTER TABLE `dle_comments_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `author` (`author`),
  ADD KEY `idx_comments_files_cid_author` (`c_id`,`author`);

--
-- Tablo için indeksler `dle_comment_rating_log`
--
ALTER TABLE `dle_comment_rating_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `member` (`member`),
  ADD KEY `ip` (`ip`);

--
-- Tablo için indeksler `dle_complaint`
--
ALTER TABLE `dle_complaint`
  ADD PRIMARY KEY (`id`),
  ADD KEY `c_id` (`c_id`),
  ADD KEY `p_id` (`p_id`),
  ADD KEY `n_id` (`n_id`);

--
-- Tablo için indeksler `dle_conversations`
--
ALTER TABLE `dle_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `recipient_id` (`recipient_id`),
  ADD KEY `updated_at` (`updated_at`);

--
-- Tablo için indeksler `dle_conversations_messages`
--
ALTER TABLE `dle_conversations_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `conversation_id` (`conversation_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Tablo için indeksler `dle_conversation_reads`
--
ALTER TABLE `dle_conversation_reads`
  ADD PRIMARY KEY (`user_id`,`conversation_id`),
  ADD KEY `last_read_at` (`last_read_at`);

--
-- Tablo için indeksler `dle_conversation_users`
--
ALTER TABLE `dle_conversation_users`
  ADD PRIMARY KEY (`user_id`,`conversation_id`);

--
-- Tablo için indeksler `dle_downloads_log`
--
ALTER TABLE `dle_downloads_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ip` (`ip`),
  ADD KEY `file_id` (`file_id`),
  ADD KEY `date` (`date`);

--
-- Tablo için indeksler `dle_email`
--
ALTER TABLE `dle_email`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_files`
--
ALTER TABLE `dle_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `idx_files_author_news` (`author`,`news_id`),
  ADD KEY `idx_files_author_news_onserver` (`author`,`news_id`,`onserver`);

--
-- Tablo için indeksler `dle_flood`
--
ALTER TABLE `dle_flood`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `ip` (`ip`),
  ADD KEY `id` (`id`),
  ADD KEY `flag` (`flag`);

--
-- Tablo için indeksler `dle_ignore_list`
--
ALTER TABLE `dle_ignore_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `user_from` (`user_from`);

--
-- Tablo için indeksler `dle_images`
--
ALTER TABLE `dle_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author` (`author`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `idx_images_author_news` (`author`,`news_id`);

--
-- Tablo için indeksler `dle_links`
--
ALTER TABLE `dle_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enabled` (`enabled`);

--
-- Tablo için indeksler `dle_login_log`
--
ALTER TABLE `dle_login_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`),
  ADD KEY `date` (`date`);

--
-- Tablo için indeksler `dle_logs`
--
ALTER TABLE `dle_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `member` (`member`),
  ADD KEY `ip` (`ip`);

--
-- Tablo için indeksler `dle_lostdb`
--
ALTER TABLE `dle_lostdb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lostid` (`lostid`);

--
-- Tablo için indeksler `dle_mail_log`
--
ALTER TABLE `dle_mail_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hash` (`hash`);

--
-- Tablo için indeksler `dle_metatags`
--
ALTER TABLE `dle_metatags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enabled` (`enabled`);

--
-- Tablo için indeksler `dle_notice`
--
ALTER TABLE `dle_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `dle_plugins`
--
ALTER TABLE `dle_plugins`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_plugins_files`
--
ALTER TABLE `dle_plugins_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plugin_id` (`plugin_id`),
  ADD KEY `active` (`active`);

--
-- Tablo için indeksler `dle_plugins_logs`
--
ALTER TABLE `dle_plugins_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plugin_id` (`plugin_id`);

--
-- Tablo için indeksler `dle_poll`
--
ALTER TABLE `dle_poll`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`);

--
-- Tablo için indeksler `dle_poll_log`
--
ALTER TABLE `dle_poll_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `member` (`member`);

--
-- Tablo için indeksler `dle_post`
--
ALTER TABLE `dle_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor` (`autor`),
  ADD KEY `alt_name` (`alt_name`),
  ADD KEY `category` (`category`),
  ADD KEY `approve` (`approve`),
  ADD KEY `allow_main` (`allow_main`),
  ADD KEY `date` (`date`),
  ADD KEY `symbol` (`symbol`),
  ADD KEY `comm_num` (`comm_num`),
  ADD KEY `fixed` (`fixed`);
ALTER TABLE `dle_post` ADD FULLTEXT KEY `short_story` (`short_story`,`full_story`,`xfields`,`title`);

--
-- Tablo için indeksler `dle_post_extras`
--
ALTER TABLE `dle_post_extras`
  ADD PRIMARY KEY (`eid`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `editdate` (`editdate`),
  ADD KEY `rating` (`rating`),
  ADD KEY `disable_search` (`disable_search`),
  ADD KEY `allow_rss` (`allow_rss`),
  ADD KEY `allow_rss_turbo` (`allow_rss_turbo`),
  ADD KEY `allow_rss_dzen` (`allow_rss_dzen`),
  ADD KEY `news_read` (`news_read`);

--
-- Tablo için indeksler `dle_post_extras_cats`
--
ALTER TABLE `dle_post_extras_cats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Tablo için indeksler `dle_post_i18n`
--
ALTER TABLE `dle_post_i18n`
  ADD PRIMARY KEY (`news_id`,`lang`),
  ADD KEY `lang` (`lang`);

--
-- Tablo için indeksler `dle_post_log`
--
ALTER TABLE `dle_post_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `expires` (`expires`);

--
-- Tablo için indeksler `dle_post_pass`
--
ALTER TABLE `dle_post_pass`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`);

--
-- Tablo için indeksler `dle_question`
--
ALTER TABLE `dle_question`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_read_log`
--
ALTER TABLE `dle_read_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `ip` (`ip`);

--
-- Tablo için indeksler `dle_redirects`
--
ALTER TABLE `dle_redirects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enabled` (`enabled`);

--
-- Tablo için indeksler `dle_rss`
--
ALTER TABLE `dle_rss`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_rssinform`
--
ALTER TABLE `dle_rssinform`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_sendlog`
--
ALTER TABLE `dle_sendlog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `date` (`date`),
  ADD KEY `flag` (`flag`);

--
-- Tablo için indeksler `dle_settings_i18n`
--
ALTER TABLE `dle_settings_i18n`
  ADD PRIMARY KEY (`setting_key`,`lang`),
  ADD KEY `lang` (`lang`);

--
-- Tablo için indeksler `dle_social_login`
--
ALTER TABLE `dle_social_login`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sid` (`sid`);

--
-- Tablo için indeksler `dle_spam_log`
--
ALTER TABLE `dle_spam_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip` (`ip`),
  ADD KEY `is_spammer` (`is_spammer`);

--
-- Tablo için indeksler `dle_static`
--
ALTER TABLE `dle_static`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `disable_search` (`disable_search`);
ALTER TABLE `dle_static` ADD FULLTEXT KEY `template` (`template`);

--
-- Tablo için indeksler `dle_static_files`
--
ALTER TABLE `dle_static_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `static_id` (`static_id`),
  ADD KEY `onserver` (`onserver`),
  ADD KEY `author` (`author`),
  ADD KEY `idx_static_files_static_onserver` (`static_id`,`onserver`);

--
-- Tablo için indeksler `dle_static_i18n`
--
ALTER TABLE `dle_static_i18n`
  ADD PRIMARY KEY (`static_id`,`lang`),
  ADD KEY `lang` (`lang`);

--
-- Tablo için indeksler `dle_storage`
--
ALTER TABLE `dle_storage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enabled` (`enabled`);

--
-- Tablo için indeksler `dle_subscribe`
--
ALTER TABLE `dle_subscribe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `dle_tags`
--
ALTER TABLE `dle_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `tag` (`tag`);

--
-- Tablo için indeksler `dle_twofactor`
--
ALTER TABLE `dle_twofactor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pin` (`pin`),
  ADD KEY `date` (`date`);

--
-- Tablo için indeksler `dle_usergroups`
--
ALTER TABLE `dle_usergroups`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `dle_users`
--
ALTER TABLE `dle_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Tablo için indeksler `dle_users_delete`
--
ALTER TABLE `dle_users_delete`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `dle_views`
--
ALTER TABLE `dle_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_views_news_id` (`news_id`);

--
-- Tablo için indeksler `dle_vote`
--
ALTER TABLE `dle_vote`
  ADD PRIMARY KEY (`id`),
  ADD KEY `approve` (`approve`);

--
-- Tablo için indeksler `dle_vote_result`
--
ALTER TABLE `dle_vote_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `answer` (`answer`),
  ADD KEY `vote_id` (`vote_id`),
  ADD KEY `ip` (`ip`),
  ADD KEY `name` (`name`);

--
-- Tablo için indeksler `dle_xfsearch`
--
ALTER TABLE `dle_xfsearch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `tagname` (`tagname`),
  ADD KEY `tagvalue` (`tagvalue`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `dle_admin_logs`
--
ALTER TABLE `dle_admin_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Tablo için AUTO_INCREMENT değeri `dle_admin_sections`
--
ALTER TABLE `dle_admin_sections`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_banned`
--
ALTER TABLE `dle_banned`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_banners`
--
ALTER TABLE `dle_banners`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_banners_logs`
--
ALTER TABLE `dle_banners_logs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_banners_rubrics`
--
ALTER TABLE `dle_banners_rubrics`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_category`
--
ALTER TABLE `dle_category`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `dle_comments`
--
ALTER TABLE `dle_comments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_comments_files`
--
ALTER TABLE `dle_comments_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_comment_rating_log`
--
ALTER TABLE `dle_comment_rating_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_complaint`
--
ALTER TABLE `dle_complaint`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_conversations`
--
ALTER TABLE `dle_conversations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_conversations_messages`
--
ALTER TABLE `dle_conversations_messages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_downloads_log`
--
ALTER TABLE `dle_downloads_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_email`
--
ALTER TABLE `dle_email`
  MODIFY `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `dle_files`
--
ALTER TABLE `dle_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_flood`
--
ALTER TABLE `dle_flood`
  MODIFY `f_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_ignore_list`
--
ALTER TABLE `dle_ignore_list`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_images`
--
ALTER TABLE `dle_images`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_links`
--
ALTER TABLE `dle_links`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_login_log`
--
ALTER TABLE `dle_login_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_logs`
--
ALTER TABLE `dle_logs`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_lostdb`
--
ALTER TABLE `dle_lostdb`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_mail_log`
--
ALTER TABLE `dle_mail_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_metatags`
--
ALTER TABLE `dle_metatags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_notice`
--
ALTER TABLE `dle_notice`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_plugins`
--
ALTER TABLE `dle_plugins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_plugins_files`
--
ALTER TABLE `dle_plugins_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_plugins_logs`
--
ALTER TABLE `dle_plugins_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_poll`
--
ALTER TABLE `dle_poll`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_poll_log`
--
ALTER TABLE `dle_poll_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_post`
--
ALTER TABLE `dle_post`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `dle_post_extras`
--
ALTER TABLE `dle_post_extras`
  MODIFY `eid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `dle_post_extras_cats`
--
ALTER TABLE `dle_post_extras_cats`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `dle_post_log`
--
ALTER TABLE `dle_post_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_post_pass`
--
ALTER TABLE `dle_post_pass`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_question`
--
ALTER TABLE `dle_question`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_read_log`
--
ALTER TABLE `dle_read_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_redirects`
--
ALTER TABLE `dle_redirects`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_rss`
--
ALTER TABLE `dle_rss`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_rssinform`
--
ALTER TABLE `dle_rssinform`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_sendlog`
--
ALTER TABLE `dle_sendlog`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_social_login`
--
ALTER TABLE `dle_social_login`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_spam_log`
--
ALTER TABLE `dle_spam_log`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_static`
--
ALTER TABLE `dle_static`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_static_files`
--
ALTER TABLE `dle_static_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_storage`
--
ALTER TABLE `dle_storage`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_subscribe`
--
ALTER TABLE `dle_subscribe`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_tags`
--
ALTER TABLE `dle_tags`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `dle_twofactor`
--
ALTER TABLE `dle_twofactor`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_usergroups`
--
ALTER TABLE `dle_usergroups`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `dle_users`
--
ALTER TABLE `dle_users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_users_delete`
--
ALTER TABLE `dle_users_delete`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_views`
--
ALTER TABLE `dle_views`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_vote`
--
ALTER TABLE `dle_vote`
  MODIFY `id` mediumint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `dle_vote_result`
--
ALTER TABLE `dle_vote_result`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `dle_xfsearch`
--
ALTER TABLE `dle_xfsearch`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
