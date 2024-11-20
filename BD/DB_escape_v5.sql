-- MySQL Workbench Synchronization
-- Generated: 2024-11-17 23:06
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alien

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `escaperoom` DEFAULT CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`certificates` (
  `id_certificate` INT(11) NOT NULL AUTO_INCREMENT,
  `achievement_details` VARCHAR(45) NULL DEFAULT NULL,
  `award_date` DATE NULL DEFAULT NULL,
  `id_user` INT(11) NOT NULL,
  PRIMARY KEY (`id_certificate`),
  INDEX `fk_certificate_user1_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_certificate_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `escaperoom`.`players` (`id_player`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`clues` (
  `id_item` INT(11) NOT NULL,
  `thematic` ENUM('HALLOWEEN', 'SCIENCE_FICTION', 'CHRISTMAS', 'JURASSIC_PARK') NOT NULL,
  `details` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_item`),
  INDEX `fk_clues_items1_idx` (`id_item` ASC) VISIBLE,
  CONSTRAINT `fk_clues_items1`
    FOREIGN KEY (`id_item`)
    REFERENCES `escaperoom`.`items` (`id_item`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`decorations` (
  `id_item` INT(11) NOT NULL,
  `material_type` ENUM('WOOD', 'PLASTIC', 'METALLIC', 'CRYSTAL') NOT NULL,
  PRIMARY KEY (`id_item`),
  INDEX `fk_decorations_items1_idx` (`id_item` ASC) VISIBLE,
  CONSTRAINT `fk_decorations_items1`
    FOREIGN KEY (`id_item`)
    REFERENCES `escaperoom`.`items` (`id_item`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`escape_room` (
  `id_escape_room` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_escape_room`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`items` (
  `id_item` INT(11) NOT NULL AUTO_INCREMENT,
  `name_item` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `id_room` INT(11) NULL DEFAULT NULL,
  `type` ENUM('CLUE', 'DECORATION') NOT NULL,
  PRIMARY KEY (`id_item`),
  INDEX `fk_items_room1_idx` (`id_room` ASC) VISIBLE,
  CONSTRAINT `fk_items_room1`
    FOREIGN KEY (`id_room`)
    REFERENCES `escaperoom`.`rooms` (`id_room`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`player_is_playing` (
  `id_player` INT(11) NOT NULL,
  `id_ticket` INT(11) NOT NULL,
  `id_room` INT(11) NOT NULL,
  `play_date` DATETIME NULL DEFAULT NULL,
  `achievements` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_player`, `id_ticket`, `id_room`),
  INDEX `fk_player_has_room_room1_idx` (`id_room` ASC) VISIBLE,
  INDEX `fk_player_has_room_player1_idx` (`id_player` ASC) VISIBLE,
  INDEX `fk_player_is_playing_tickets1_idx` (`id_ticket` ASC) VISIBLE,
  CONSTRAINT `fk_player_has_room_player1`
    FOREIGN KEY (`id_player`)
    REFERENCES `escaperoom`.`players` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_player_has_room_room1`
    FOREIGN KEY (`id_room`)
    REFERENCES `escaperoom`.`rooms` (`id_room`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_player_is_playing_tickets1`
    FOREIGN KEY (`id_ticket`)
    REFERENCES `escaperoom`.`tickets` (`id_ticket`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`players` (
  `id_player` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `subscription` TINYINT(4) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_player`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`rooms` (
  `id_room` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `difficulty` INT(11) NOT NULL,
  `thematic` ENUM('HALLOWEEN', 'SCIENCE_FICTION', 'CHRISTMAS', 'JURASSIC_PARK') NOT NULL,
  `base_price` DECIMAL(10,2) NOT NULL,
  `id_escape_room` INT(11) NOT NULL,
  PRIMARY KEY (`id_room`),
  INDEX `fk_room_escape_room1_idx` (`id_escape_room` ASC) VISIBLE,
  CONSTRAINT `fk_room_escape_room1`
    FOREIGN KEY (`id_escape_room`)
    REFERENCES `escaperoom`.`escape_room` (`id_escape_room`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `escaperoom`.`tickets` (
  `id_ticket` INT(11) NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME NOT NULL,
  `total_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `id_player` INT(11) NOT NULL,
  PRIMARY KEY (`id_ticket`),
  INDEX `fk_ticket_player1_idx` (`id_player` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_player1`
    FOREIGN KEY (`id_player`)
    REFERENCES `escaperoom`.`players` (`id_player`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
