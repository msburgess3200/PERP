<?php
	
$con = mysql_connect("Hostname", "Username", "Password"); // Change this line to your information.

if (!$con) { die('a'); }

mysql_select_db("DatabaseName"); // Change this line to your database
	
$steamid = $_GET['steamid'];

$q = mysql_query("SELECT * FROM `smf_members_pending` WHERE `steamid`='" . $steamid ."' LIMIT 1");

if (!$q){ die('b'); }

while ($row = mysql_fetch_assoc($q)){
	$regOptions = array(
		'memberName' => "'" . $row['username'] . "'",
		'emailAddress' => "'notavailable@gmail.com'",
		'passwd' => '\'' . sha1(strtolower($row['username']) . $row['password']) . '\'',
		'passwordSalt' => '\'' . substr(md5(mt_rand()), 0, 4) . '\'',
		'posts' => 0,
		'ID_GROUP' => 4,
		'dateRegistered' => time(),
		'memberIP' => "'$row[ipaddress]'",
		'memberIP2' => "'$row[ipaddress]'",
		'validation_code' => "''",
		'realName' => "'$row[nick]'",
		'personalText' => '',
		'pm_email_notify' => 1,
		'ID_THEME' => 6,
		'ID_POST_GROUP' => 4,
		'lngfile' => "''",
		'buddy_list' => "''",
		'pm_ignore_list' => "''",
		'messageLabels' => "''",
		'personalText' => "''",
		'websiteTitle' => "''",
		'websiteUrl' => "''",
		'location' => "''",
		'ICQ' => "''",
		'AIM' => "''",
		'YIM' => "''",
		'MSN' => "''",
		'timeFormat' => "''",
		'signature' => "''",
		'avatar' => "''",
		'usertitle' => "''",
		'secretQuestion' => "''",
		'secretAnswer' => "''",
		'additionalGroups' => "''",
		'smileySet' => "''",
		'steamid' => "'$row[steamid]'",
	);

	
	mysql_query("
		INSERT INTO smf_members
			(" . implode(', ', array_keys($regOptions)) . ")
		VALUES (" . implode(', ', $regOptions) . ')');
	
	echo mysql_error();
	
	mysql_query("DELETE FROM `smf_members_pending` WHERE `steamid`='" . $steamid . "' LIMIT 1");
	
	die('s');
}

die('c');


?>
	
