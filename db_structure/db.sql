-- Adminer 5.3.0 MariaDB 11.1.2-MariaDB-1:11.1.2+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `cms4py` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `cms4py`;

DROP TABLE IF EXISTS `as_list`;
CREATE TABLE `as_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `self_userid` bigint(20) DEFAULT NULL,
  `target_userid` bigint(20) DEFAULT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `as_list_uk_uts` (`self_userid`,`target_userid`,`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP VIEW IF EXISTS `as_list_with_details`;
CREATE TABLE `as_list_with_details` (`id` bigint(20), `target_userid` bigint(20), `target_user_nicename` varchar(512), `target_user_login_name` varchar(128), `self_userid` bigint(20), `school_id` bigint(20), `school_name` varchar(512));


DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `school` (`id`, `name`) VALUES
(4,	'山东蓝翔高等职业技术学院'),
(3,	'江西蓝天大学'),
(1,	'驻马店皇家理工学院'),
(2,	'黄河科技大学');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(128) DEFAULT NULL,
  `nicename` varchar(512) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `avatar` varchar(512) DEFAULT NULL,
  `gender` varchar(128) DEFAULT NULL,
  `is_super` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `login_name` (`login_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user` (`id`, `login_name`, `nicename`, `password`, `email`, `phone`, `avatar`, `gender`, `is_super`, `created_at`, `updated_at`, `deleted_at`) VALUES
(46,	'小云',	NULL,	'pbkdf2(1000,20,sha512)$947861808093a48f$cd1b2ec20935a86780cbf9677711b3a5256a5767',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(47,	'佳佳',	NULL,	'pbkdf2(1000,20,sha512)$bf8b4de1e0bb99d2$ed9ce1dbca1ba9c8c24128a7eeedb4b940881156',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(49,	'小宇',	NULL,	'pbkdf2(1000,20,sha512)$a6ed2a6b9890b0ab$1d3e45e2217f176d6073b3f98cc54053e958c332',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(50,	'欢欢',	NULL,	'pbkdf2(1000,20,sha512)$92c14e57736c7d7e$e9aca48391d428b9b55a55ac71e1dbb4e5a3fa59',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP VIEW IF EXISTS `user_related_school`;
CREATE TABLE `user_related_school` (`id` bigint(20), `relation_id` bigint(20), `user_id` bigint(20), `school_id` bigint(20), `name` varchar(512), `user_nicename` varchar(512), `user_loginname` varchar(128));


DROP TABLE IF EXISTS `user_school_relation`;
CREATE TABLE `user_school_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user_school_relation` (`id`, `user_id`, `school_id`) VALUES
(15,	46,	4),
(17,	46,	3),
(18,	47,	1),
(19,	46,	1);

DROP TABLE IF EXISTS `as_list_with_details`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `as_list_with_details` AS select `as_list`.`id` AS `id`,`as_list`.`target_userid` AS `target_userid`,`user`.`nicename` AS `target_user_nicename`,`user`.`login_name` AS `target_user_login_name`,`as_list`.`self_userid` AS `self_userid`,`as_list`.`school_id` AS `school_id`,`school`.`name` AS `school_name` from ((`as_list` left join `user` on(`as_list`.`target_userid` = `user`.`id`)) left join `school` on(`as_list`.`school_id` = `school`.`id`));

DROP TABLE IF EXISTS `user_related_school`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `user_related_school` AS select `user_school_relation`.`id` AS `id`,`user_school_relation`.`id` AS `relation_id`,`user_school_relation`.`user_id` AS `user_id`,`user_school_relation`.`school_id` AS `school_id`,`school`.`name` AS `name`,`user`.`nicename` AS `user_nicename`,`user`.`login_name` AS `user_loginname` from ((`user_school_relation` left join `school` on(`user_school_relation`.`school_id` = `school`.`id`)) left join `user` on(`user_school_relation`.`user_id` = `user`.`id`));

-- 2025-10-01 06:28:03 UTC
