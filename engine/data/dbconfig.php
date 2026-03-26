<?php

if( !defined( 'DATALIFEENGINE' ) ) {
	header( "HTTP/1.1 403 Forbidden" );
	header ( 'Location: ../../' );
	die( "Hacking attempt!" );
}

define ("DBHOST", "localhost");

define ("DBNAME", "dle");

define ("DBUSER", "dle_app");

define ("DBPASS", "f9pUJDSRi1ucSmMGbxDjh0P7");

define ("PREFIX", "dle");

define ("USERPREFIX", "dle");

define ("COLLATE", "utf8mb4");

define('SECURE_AUTH_KEY', 'fa4852df6dc66a69b65de7eddddf89c10e062dee0e4fdb6f5dd99e972956dd4592836c1446669b9e6defb815ccc1c6cf');

$db = new db;

?>