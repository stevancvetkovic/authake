CREATE DATABASE authake;
USE authake;

CREATE TABLE `authake_users` (
	`id` int(10) unsigned NOT NULL auto_increment,
	`login` varchar(32) NOT NULL,
	`password` varchar(50) NOT NULL,
	`email` varchar(128) NOT NULL,
	`emailcheckcode` varchar(128) NOT NULL,
	`passwordchangecode` varchar(128) NOT NULL,
	`disable` tinyint(1) NOT NULL,
	`expire_account` date NOT NULL,
	`certificate` text NOT NULL,
	`certificatecheck` int(1) NOT NULL,
	`created` datetime default NULL,
	`updated` datetime default NULL,
	PRIMARY KEY (`id`)
);

INSERT INTO `authake_users` VALUES (1,'admin','21232f297a57a5a743894a0e4a801fc3','cvetkovic.stevan@gmail.com','','',0,'0000-00-00','-----BEGIN CERTIFICATE----- MIIC0zCCAjygAwIBAgIJAM7JaD4X+UGfMA0GCSqGSIb3DQEBBQUAMFExCzAJBgNV BAYTAlJTMQ8wDQYDVQQIEwZTZXJiaWExHDAaBgNVBAoTE0tsaW5pY2tpIGNlbnRh ciBOaXMxEzARBgNVBAMTCktDTmlzIENlcnQwHhcNMTAxMTIyMTQ1MTMyWhcNMTEx MTIyMTQ1MTMyWjCBiDELMAkGA1UEBhMCUlMxDzANBgNVBAgTBlNlcmJpYTEMMAoG A1UEBxMDTmlzMRwwGgYDVQQKExNLbGluaWNraSBjZW50YXIgTmlzMREwDwYDVQQD EwhuZXN0by5yczEpMCcGCSqGSIb3DQEJARYaY3ZldGtvdmljLnN0ZXZhbkBnbWFp bC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANEdZprw1lZPNQHmi09K cI4EZ2UfoCWcF2RzBalOatoyfSdyFFCSJXuCqRKs/00XNcPqflcJX0D3BZf25SZC BdT5J/RtDgVTM91xGMnEBNpVqce3Dta1lfx+TpirqP0JXKUQi1pMg0g/1uhgY3i9 gtdUF6nb2exluty0VTnBslCtAgMBAAGjezB5MAkGA1UdEwQCMAAwLAYJYIZIAYb4 QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBTk mrEuBQm2kqLtp7441JgDJfNcQDAfBgNVHSMEGDAWgBRMDWJLGtzrBwLn+s5bK76D oChl+DANBgkqhkiG9w0BAQUFAAOBgQBf7YOXegO8SDWpcRRnOumGbq4moE0B2m12 bmr4zlWOnmjM9Z7l+Mhj0wYQNWypUFat5trgnVEhn3QkHSXROpmTkDnTTgQ1p1MV Ht9Az6IyUmv7s2a9J4JVEf7qzU3SBhbA0aFgAb/nWZkf+kjimLRiIkoDX/tcaFrN vRiR6FZ1gg== -----END CERTIFICATE-----',0,'0000-00-00 00:00:00','2008-02-12 12:19:31'),(2,'acluser','5d35a4a2209c621b2896db016388db31','acluser@example.com','','',0,'0000-00-00','acluser-cert',0,'2008-01-26 19:08:03','2008-02-13 12:22:48'),(4,'otheruser','95e6a007d09887c5681d9b758ad644dd','otheruser@example.com','','',1,'2028-01-01','otheruser-cert',0,'2008-01-30 23:40:03','2008-02-13 08:55:03'),(3,'simpleuser','96c8cd0d4d88181c5f9836457c0d9b1c','simpleuser@example.com','','',0,'2008-02-16','simpleuser-cert',0,'2008-01-31 16:47:09','2008-02-12 12:19:22');

CREATE TABLE `authake_groups` (
	`id` int(10) unsigned NOT NULL auto_increment,
	`name` varchar(64) NOT NULL,
	PRIMARY KEY (`id`)
);

INSERT INTO `authake_groups` VALUES (1,'Administrators'),(3,'Other test group'),(2,'User & group managers'),(0,'Everybody');

CREATE TABLE `authake_rules` (
	`id` int(10) unsigned NOT NULL auto_increment,
	`name` varchar(256) character set latin1 NOT NULL,
	`group_id` int(10) unsigned NOT NULL default '0',
	`order` int(10) unsigned default NULL,
	`action` varchar(512) character set latin1 default NULL,
	`permission` enum('Deny','Allow') collate utf8_unicode_ci NOT NULL default 'Deny',
	`forward` varchar(64) collate utf8_unicode_ci NOT NULL,
	`message` varchar(512) collate utf8_unicode_ci NOT NULL,
	PRIMARY KEY  (`id`)
);

INSERT INTO `authake_rules` VALUES (1,'Allow everything for Administrators',1,999999,'*','Allow','',''),(2,'Allow anybody to see the home page, the error page, to register, to log in, see profile and log out',0,200,'/ or /authake/user/*','Allow','',''),(3,'(example) Allow anybody to view the rules list',0,700,'/authake/rules/index','Allow','',''),(4,'Deny everything for everybody by default (allow to have allow by default then deny)',0,0,'*','Deny','','Access denied!'),(5,'Allow \"user & group managers\" to edit users, groups and view rules',2,800,'/authake(/index)? or /authake/*/index/tableonly or /authake/users/(index|add/?|edit/[0-9]+|view/[0-9]+|delete/[0-9]+) or /authake/groups/(index|add/?|edit/[0-9]+|view/[0-9]+|delete/[0-9]+) or /authake/rules/(index|view/[0-9]+)','Allow','',''),(6,'Display a message for denied admin page',0,100,'/authake(/index)? or /authake/users* or /authake/groups* or /authake/rules*','Deny','','You are not allowed to access the administration page!');

CREATE TABLE `authake_groups_users` (
	`user_id` int(10) unsigned NOT NULL default '0',
	`group_id` int(10) unsigned NOT NULL default '0'
);

INSERT INTO `authake_groups_users` VALUES (1,2),(1,3),(2,0),(4,3),(1,1);
