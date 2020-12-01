-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Movie_Buff
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Movie_Buff
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Movie_Buff` DEFAULT CHARACTER SET utf8 ;
USE `Movie_Buff` ;

-- -----------------------------------------------------
-- Table `Movie_Buff`.`영화`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movie_Buff`.`영화` (
  `영화코드번호` CHAR(4) NOT NULL,
  `제목` VARCHAR(30) NOT NULL,
  `제작년도` INT NULL,
  `제작국가` VARCHAR(10) NULL,
  `상영시간` INT NULL,
  `개봉일자` DATE NULL,
  `제작사` VARCHAR(10) NULL,
  `배급사` VARCHAR(10) NULL,
  PRIMARY KEY (`영화코드번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Movie_Buff`.`감독`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movie_Buff`.`감독` (
  `등록번호` CHAR(4) NOT NULL,
  `이름` VARCHAR(10) NOT NULL,
  `성별` CHAR(2) NULL,
  `생년월일` DATE NULL,
  `출생지` VARCHAR(20) NULL,
  `키` INT NULL,
  `몸무게` INT NULL,
  `혈액형` CHAR(2) NULL,
  PRIMARY KEY (`등록번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Movie_Buff`.`배우`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movie_Buff`.`배우` (
  `배우번호` CHAR(4) NOT NULL,
  `이름` VARCHAR(10) NOT NULL,
  `성별` CHAR(2) NULL,
  `생년월일` DATE NULL,
  `출생지` VARCHAR(20) NULL,
  `키` INT NULL,
  `몸무게` INT NULL,
  `혈액형` CHAR(2) NULL,
  PRIMARY KEY (`배우번호`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Movie_Buff`.`촬영`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movie_Buff`.`촬영` (
  `등록번호` CHAR(4) NOT NULL,
  `영화코드번호` CHAR(4) NOT NULL,
  PRIMARY KEY (`등록번호`, `영화코드번호`),
  INDEX `fk_감독_has_영화_영화1_idx` (`영화코드번호` ASC) VISIBLE,
  INDEX `fk_감독_has_영화_감독_idx` (`등록번호` ASC) VISIBLE,
  CONSTRAINT `fk_감독_has_영화_감독`
    FOREIGN KEY (`등록번호`)
    REFERENCES `Movie_Buff`.`감독` (`등록번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_감독_has_영화_영화1`
    FOREIGN KEY (`영화코드번호`)
    REFERENCES `Movie_Buff`.`영화` (`영화코드번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Movie_Buff`.`캐스팅`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movie_Buff`.`캐스팅` (
  `배우번호` CHAR(4) NOT NULL,
  `영화코드번호` CHAR(4) NOT NULL,
  `배역` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`배우번호`, `영화코드번호`),
  INDEX `fk_배우_has_영화_영화1_idx` (`영화코드번호` ASC) VISIBLE,
  INDEX `fk_배우_has_영화_배우1_idx` (`배우번호` ASC) VISIBLE,
  CONSTRAINT `fk_배우_has_영화_배우1`
    FOREIGN KEY (`배우번호`)
    REFERENCES `Movie_Buff`.`배우` (`배우번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_배우_has_영화_영화1`
    FOREIGN KEY (`영화코드번호`)
    REFERENCES `Movie_Buff`.`영화` (`영화코드번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
