-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Adotante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Adotante` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Adotante` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(40) NOT NULL,
  `D_nascimento` DATETIME NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
		CONSTRAINT `SexoAdotante` CHECK (`Sexo` IN ('M', 'F')),
  `N_Porta` INT NOT NULL,
  `Rua` VARCHAR(50) NOT NULL,
  `CódigoPostal` INT NOT NULL,
		CONSTRAINT `CódigoPostalAdotante` CHECK (`CódigoPostal`  BETWEEN 1000000 AND 9999999),
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Animal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Animal` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Animal` (
  `id` INT NOT NULL,
  `Nome` VARCHAR(40) NULL,
  `Idade` INT NULL,
  `Perfil` VARCHAR(45) NULL,
  `D_nascimento` DATE NULL,
  `Registo_clinico` TEXT NULL,
  `Categoria` VARCHAR(20) NOT NULL,
  `Cor` VARCHAR(20) NOT NULL,
  `D_adoção` DATETIME NULL,
  `D_saida` DATETIME NULL,
  `D_chegada` DATETIME NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
		CONSTRAINT `SexoAnimal` CHECK (`Sexo` IN ('M', 'F')),
  `Raça e espécie` VARCHAR(20) NOT NULL,
  `Peso` INT NOT NULL,
  `Adotante_Id` INT NULL,
  PRIMARY KEY (`id`),
    FOREIGN KEY (`Adotante_Id`) REFERENCES `mydb`.`Adotante` (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionário`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcionário` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcionário` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Estatuto` VARCHAR(1) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `N_Porta` INT NOT NULL,
  `CódigoPostal` INT NOT NULL,
  `Número` INT NOT NULL,
	CONSTRAINT `CódigoPostalFuncionário` CHECK (`CódigoPostal`  BETWEEN 1000000 AND 9999999),
	CONSTRAINT `NúmeroFuncionário` CHECK (`Número` BETWEEN 100000000 AND 999999999),
    CONSTRAINT `EstatutoFuncionário` CHECK (`Estatuto` IN ('V', 'P')),
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Disponibilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Disponibilidade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Disponibilidade` (
	
    `Funcionário_Id` INT NOT NULL,
    `DiaDaSemana` ENUM('Segunda-feira', 'Terca-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sabado', 'Domingo') NOT NULL,
	
	PRIMARY KEY(`Funcionário_Id`,`DiaDaSemana`),
    CONSTRAINT `DisponibilidadeConstrain` 
    FOREIGN KEY (`Funcionário_Id`) REFERENCES `mydb`.`Funcionário` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Doador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Doador` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Doador` (
  `Id` INT NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Nome` VARCHAR(40) NOT NULL,
  `Número` INT NOT NULL,
	CONSTRAINT `NúmeroDoador` CHECK (`Número` BETWEEN 100000000 AND 999999999),
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Donativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Donativo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Donativo` (
  `Id` INT NOT NULL,
  `Categoria` VARCHAR(20) NOT NULL,
  `D_validade` DATE NULL,
  `Quantidade` DOUBLE NULL,
  `Doador_Id` INT NOT NULL,
  PRIMARY KEY (`Id`, `Doador_Id`),
  CONSTRAINT `fk_Donativo_Doador1`
    FOREIGN KEY (`Doador_Id`) REFERENCES `mydb`.`Doador` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`TB_AnimalFuncionário`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TB_AnimalFuncionário` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TB_AnimalFuncionário` (
  `Animal_id` INT NOT NULL,
  `Funcionário_Id` INT NOT NULL,
  `D_tratamento` DATETIME NOT NULL,
  PRIMARY KEY (`Animal_id`, `Funcionário_Id`, `D_tratamento`),
  CONSTRAINT `fk_Animal_has_Funcionário_Animal1`
    FOREIGN KEY (`Animal_id`) REFERENCES `mydb`.`Animal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Animal_has_Funcionário_Funcionário1`
    FOREIGN KEY (`Funcionário_Id`) REFERENCES `mydb`.`Funcionário` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TB_FuncionárioDonativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TB_FuncionárioDonativo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TB_FuncionárioDonativo` (
  `Donativo_Id` INT NOT NULL,
  `Funcionário_Id` INT NOT NULL,
  `D_acesso` DATETIME NOT NULL,
  PRIMARY KEY (`Donativo_Id`,`Funcionário_Id`,`D_acesso`),
  CONSTRAINT `fk_Funcionário_has_Donativo1_Donativo1`
    FOREIGN KEY (`Donativo_Id`) REFERENCES `mydb`.`Donativo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_FuncionárioDonativo_Funcionário1`
    FOREIGN KEY (`Funcionário_Id`) REFERENCES `mydb`.`Funcionário` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Contacto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Contacto` (
  `Número` INT NOT NULL,
		CONSTRAINT `NúmeroContacto`  CHECK (`Número`  BETWEEN 100000000 AND 999999999),
  `Adotante_Id` INT NOT NULL,
  PRIMARY KEY (`Número`, `Adotante_Id`),
  CONSTRAINT `fk_Contacto_Adotante1`
    FOREIGN KEY (`Adotante_Id`) REFERENCES `mydb`.`Adotante` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Competências`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Competência` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Competência` (
  `Aptidão` VARCHAR(40) NOT NULL,
  `Funcionário_Id` INT NOT NULL,
  PRIMARY KEY (`Aptidão`, `Funcionário_Id`),
  CONSTRAINT `fk_Competência_Funcionário`
    FOREIGN KEY (`Funcionário_Id`) REFERENCES `mydb`.`Funcionário` (`Id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Comprovativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Comprovativo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Comprovativo` (
  `IBAN` VARCHAR(45) NOT NULL,
  `Operação` VARCHAR(45) NOT NULL,
  `Montante` DOUBLE NOT NULL,
  `NomeBanco` VARCHAR(60) NOT NULL,
  `Donativo_Id` INT NOT NULL,
  `DataMovimento` DATETIME NOT NULL,
  PRIMARY KEY (`IBAN`, `Donativo_Id`),
  
  CONSTRAINT `fk_Comprovativo_Donativo`
    FOREIGN KEY (`Donativo_Id`)
    REFERENCES `mydb`.`Donativo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX dataChegada ON Animal (D_chegada); 
CREATE INDEX fk ON Animal (Adotante_Id);
CREATE INDEX dataValidade ON Donativo (D_validade); 


DROP TRIGGER  IF EXISTS trigger_update_quantidade ;
DELIMITER $$
CREATE TRIGGER trigger_update_quantidade
AFTER INSERT ON comprovativo
FOR EACH ROW
BEGIN
	UPDATE donativo SET donativo.quantidade = new.montante
		WHERE donativo.Id = new.Donativo_Id;

END $$
DELIMITER $$;

DROP TRIGGER  IF EXISTS trigger_update_disponiblidade ;
DELIMITER %%
CREATE TRIGGER trigger_update_disponiblidade
AFTER INSERT ON Funcionário
FOR EACH ROW
BEGIN
	IF new.Estatuto = 'P' THEN
	INSERT IGNORE INTO mydb.Disponibilidade (Funcionário_Id, DiaDaSemana) VALUES (NEW.Id, 'Segunda-feira');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Terca-feira');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Quarta-feira');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Quinta-feira');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Sexta-feira');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Sabado');
    INSERT IGNORE INTO mydb.Disponibilidade(Funcionário_Id,DiaDaSemana) VALUES (new.Id,'Domingo');
    END IF;

END %%
DELIMITER %%;

SET SQL_SAFE_UPDATES = 0;
DROP EVENT IF EXISTS delete_old_animals ;

-- | Evento 1
DELIMITER $$
CREATE EVENT IF NOT EXISTS  delete_old_animals
ON SCHEDULE EVERY 1 DAY
STARTS now()
DO
BEGIN
    DELETE FROM Animal WHERE DATE_ADD(D_saida, INTERVAL 60 DAY) < CURDATE();
END $$
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
