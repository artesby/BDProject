-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'user'
-- 
-- ---
CREATE SCHEMA IF NOT EXISTS `BDProject` ;
USE `BDProject`;
		
DROP TABLE IF EXISTS `certificate`;
DROP TABLE IF EXISTS `request`;
DROP TABLE IF EXISTS `office`;
DROP TABLE IF EXISTS `city`;
DROP TABLE IF EXISTS `note`;
DROP TABLE IF EXISTS `answer`;
DROP TABLE IF EXISTS `question`;
DROP TABLE IF EXISTS `subtest`;
DROP TABLE IF EXISTS `subtest_type`;
DROP TABLE IF EXISTS `block`;
DROP TABLE IF EXISTS `block_type`;
DROP TABLE IF EXISTS `test`;
DROP TABLE IF EXISTS `result`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `passport_data`;

CREATE TABLE `user` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `surname` VARCHAR(30) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `second_name` VARCHAR(30) NOT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `passport_id` INTEGER NULL DEFAULT NULL,
  `registration_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'passport_data'
-- 
-- ---

CREATE TABLE `passport_data` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `series` VARCHAR(10) NULL DEFAULT NULL,
  `number` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'office'
-- 
-- ---
		
CREATE TABLE `office` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  `city_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'city'
-- 
-- ---
	
CREATE TABLE `city` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'request'
-- 
-- ---
		
CREATE TABLE `request` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `creation_date` DATE NOT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  `office_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'result'
-- 
-- ---
		
CREATE TABLE `result` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  `test_status` TINYINT NULL DEFAULT NULL,
  `test_score` INTEGER NULL DEFAULT NULL,
  `start` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'subtest'
-- 
-- ---
		
CREATE TABLE `subtest` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `block_id` INTEGER NULL DEFAULT NULL,
  `type_id` INTEGER NULL DEFAULT NULL,
  `countable_max` INTEGER NULL DEFAULT NULL,
  `medium_threshold` INTEGER NULL DEFAULT NULL,
  `minimum_threshold` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'subtest_type'
-- 
-- ---
	
CREATE TABLE `subtest_type` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `subtest_type_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'answer'
-- 
-- ---
		
CREATE TABLE `answer` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `answer_doc` VARCHAR(30) NULL DEFAULT NULL,
  `question_id` INTEGER NULL DEFAULT NULL,
  `result_id` INTEGER NULL DEFAULT NULL,
  `answer_score` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);


-- ---
-- Table 'note'
-- 
-- ---
	
CREATE TABLE `note` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `result_id` INTEGER NULL DEFAULT NULL,
  `issuance_date` DATETIME NULL DEFAULT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'certificate'
-- 
-- ---
		
CREATE TABLE `certificate` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `user_id` INTEGER NULL DEFAULT NULL,
  `issuance_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'test'
-- 
-- ---
	
CREATE TABLE `test` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `result_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'block'
-- 
-- ---

CREATE TABLE `block` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `test_id` INTEGER NULL DEFAULT NULL,
  `block_type_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'question'
-- 
-- ---
	
CREATE TABLE `question` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `question_doc` VARCHAR(30) NULL DEFAULT NULL,
  `subtest_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'block_type'
-- 
-- ---
		
CREATE TABLE `block_type` (
  `id` INTEGER AUTO_INCREMENT NOT NULL,
  `block_type_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `user` ADD FOREIGN KEY (passport_id) REFERENCES `passport_data` (`id`);
ALTER TABLE `office` ADD FOREIGN KEY (city_id) REFERENCES `city` (`id`);
ALTER TABLE `request` ADD FOREIGN KEY (user_id) REFERENCES `user` (`id`);
ALTER TABLE `request` ADD FOREIGN KEY (office_id) REFERENCES `office` (`id`);
ALTER TABLE `result` ADD FOREIGN KEY (user_id) REFERENCES `user` (`id`);
ALTER TABLE `subtest` ADD FOREIGN KEY (block_id) REFERENCES `block` (`id`);
ALTER TABLE `subtest` ADD FOREIGN KEY (type_id) REFERENCES `subtest_type` (`id`);
ALTER TABLE `answer` ADD FOREIGN KEY (question_id) REFERENCES `question` (`id`);
ALTER TABLE `answer` ADD FOREIGN KEY (result_id) REFERENCES `result` (`id`);
ALTER TABLE `note` ADD FOREIGN KEY (result_id) REFERENCES `result` (`id`);
ALTER TABLE `note` ADD FOREIGN KEY (user_id) REFERENCES `user` (`id`);
ALTER TABLE `certificate` ADD FOREIGN KEY (user_id) REFERENCES `user` (`id`);
ALTER TABLE `test` ADD FOREIGN KEY (result_id) REFERENCES `result` (`id`);
ALTER TABLE `block` ADD FOREIGN KEY (test_id) REFERENCES `test` (`id`);
ALTER TABLE `block` ADD FOREIGN KEY (block_type_id) REFERENCES `block_type` (`id`);
ALTER TABLE `question` ADD FOREIGN KEY (subtest_id) REFERENCES `subtest` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `user` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `passport_data` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `office` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `city` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `request` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `result` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `subtest` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `subtest_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `answer` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `note` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `certificate` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `test` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `block` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `question` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `block_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `user` (`id`,`surname`,`name`,`second_name`,`birth_date`,`passport_id`,`registration_date`) VALUES
-- ('','','','','','','');
-- INSERT INTO `passport_data` (`id`,`series`,`number`) VALUES
-- ('','','');
-- INSERT INTO `office` (`id`,`name`,`city_id`) VALUES
-- ('','','');
-- INSERT INTO `city` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `request` (`id`,`creation_date`,`user_id`,`office_id`) VALUES
-- ('','','','');
-- INSERT INTO `result` (`id`,`user_id`,`test_status`,`test_score`,`start`) VALUES
-- ('','','','','');
-- INSERT INTO `subtest` (`id`,`block_id`,`type_id`,`countable_max`,`medium_threshold`,`minimum_threshold`) VALUES
-- ('','','','','','');
-- INSERT INTO `subtest_type` (`id`,`subtest_type_name`) VALUES
-- ('','');
-- INSERT INTO `answer` (`id`,`answer_doc`,`question_id`,`result_id`,`answer_score`) VALUES
-- ('','','','','');
-- INSERT INTO `note` (`id`,`result_id`,`issuance_date`,`user_id`) VALUES
-- ('','','','');
-- INSERT INTO `certificate` (`id`,`user_id`,`issuance_date`) VALUES
-- ('','','');
-- INSERT INTO `test` (`id`,`result_id`) VALUES
-- ('','');
-- INSERT INTO `block` (`id`,`test_id`,`block_type_id`) VALUES
-- ('','','');
-- INSERT INTO `question` (`id`,`question_doc`,`subtest_id`) VALUES
-- ('','','');
-- INSERT INTO `block_type` (`id`,`block_type_name`) VALUES
-- ('','');