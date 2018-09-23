-- MySQL Script generated by MySQL Workbench
-- Sun Sep 23 16:17:57 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hoteleria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hoteleria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hoteleria` ;
USE `hoteleria` ;

-- -----------------------------------------------------
-- Table `hoteleria`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`usuario` (
  `idusuario` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contrasena` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`administrador` (
  `idadministrador` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idadministrador`, `usuario_idusuario`),
  INDEX `fk_administrador_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_administrador_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `hoteleria`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`tipoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`tipoCliente` (
  `idtipoCliente` INT NOT NULL,
  `nombreTipo` VARCHAR(45) NOT NULL,
  `descuento` DECIMAL NOT NULL,
  PRIMARY KEY (`idtipoCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`cliente` (
  `idcliente` INT NOT NULL,
  `nombreCliente` VARCHAR(45) NOT NULL,
  `apellidoCliente` VARCHAR(45) NOT NULL,
  `dniCliente` INT NOT NULL,
  `emailCliente` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATETIME NOT NULL,
  `lugarResidencia` VARCHAR(45) NOT NULL,
  `telefonoCliente` VARCHAR(45) NOT NULL,
  `tipoCliente_idtipoCliente` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idcliente`, `dniCliente`, `tipoCliente_idtipoCliente`, `usuario_idusuario`),
  INDEX `fk_cliente_tipoCliente1_idx` (`tipoCliente_idtipoCliente` ASC) VISIBLE,
  INDEX `fk_cliente_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_tipoCliente1`
    FOREIGN KEY (`tipoCliente_idtipoCliente`)
    REFERENCES `hoteleria`.`tipoCliente` (`idtipoCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `hoteleria`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`datosTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`datosTarjeta` (
  `iddatosTarjeta` INT NOT NULL,
  `nombreTitular` VARCHAR(45) NOT NULL,
  `fechaVto` VARCHAR(45) NOT NULL,
  `codSeguridad` VARCHAR(45) NOT NULL,
  `cliente_idcliente` INT NOT NULL,
  `cliente_dniCliente` INT NOT NULL,
  PRIMARY KEY (`iddatosTarjeta`, `cliente_idcliente`, `cliente_dniCliente`),
  INDEX `fk_datosTarjeta_cliente_idx` (`cliente_idcliente` ASC, `cliente_dniCliente` ASC) VISIBLE,
  CONSTRAINT `fk_datosTarjeta_cliente`
    FOREIGN KEY (`cliente_idcliente` , `cliente_dniCliente`)
    REFERENCES `hoteleria`.`cliente` (`idcliente` , `dniCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`estadoHabilitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`estadoHabilitacion` (
  `idestadoHabilitacion` INT NOT NULL,
  `NombreEstado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestadoHabilitacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`estadoReserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`estadoReserva` (
  `idestadoReserva` INT NOT NULL,
  `nombreEstadoReserva` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestadoReserva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`tipoHabitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`tipoHabitacion` (
  `idtipoHabitacion` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idtipoHabitacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`habitacion` (
  `idhabitacion` INT NOT NULL,
  `tipoHabitacion_idtipoHabitacion` INT NOT NULL,
  `estadoHabilitacion_idestadoHabilitacion` INT NOT NULL,
  PRIMARY KEY (`idhabitacion`, `tipoHabitacion_idtipoHabitacion`, `estadoHabilitacion_idestadoHabilitacion`),
  INDEX `fk_habitacion_tipoHabitacion1_idx` (`tipoHabitacion_idtipoHabitacion` ASC) VISIBLE,
  INDEX `fk_habitacion_estadoHabilitacion1_idx` (`estadoHabilitacion_idestadoHabilitacion` ASC) VISIBLE,
  CONSTRAINT `fk_habitacion_tipoHabitacion1`
    FOREIGN KEY (`tipoHabitacion_idtipoHabitacion`)
    REFERENCES `hoteleria`.`tipoHabitacion` (`idtipoHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitacion_estadoHabilitacion1`
    FOREIGN KEY (`estadoHabilitacion_idestadoHabilitacion`)
    REFERENCES `hoteleria`.`estadoHabilitacion` (`idestadoHabilitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`reserva` (
  `idreserva` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  `idHabitacion` INT NOT NULL,
  `PrecioTotal` FLOAT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `estadoReserva_idestadoReserva` INT NOT NULL,
  `habitacion_idhabitacion` INT NOT NULL,
  `habitacion_tipoHabitacion_idtipoHabitacion` INT NOT NULL,
  `habitacion_estadoHabilitacion_idestadoHabilitacion` INT NOT NULL,
  PRIMARY KEY (`idreserva`, `idUsuario`, `idHabitacion`, `estadoReserva_idestadoReserva`),
  INDEX `fk_reserva_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_reserva_estadoReserva1_idx` (`estadoReserva_idestadoReserva` ASC) VISIBLE,
  INDEX `fk_reserva_habitacion1_idx` (`habitacion_idhabitacion` ASC, `habitacion_tipoHabitacion_idtipoHabitacion` ASC, `habitacion_estadoHabilitacion_idestadoHabilitacion` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `hoteleria`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_estadoReserva1`
    FOREIGN KEY (`estadoReserva_idestadoReserva`)
    REFERENCES `hoteleria`.`estadoReserva` (`idestadoReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_habitacion1`
    FOREIGN KEY (`habitacion_idhabitacion` , `habitacion_tipoHabitacion_idtipoHabitacion` , `habitacion_estadoHabilitacion_idestadoHabilitacion`)
    REFERENCES `hoteleria`.`habitacion` (`idhabitacion` , `tipoHabitacion_idtipoHabitacion` , `estadoHabilitacion_idestadoHabilitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoteleria`.`promocion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hoteleria`.`promocion` (
  `idpromocion` INT NOT NULL,
  `nombrePromocion` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fechaInicio` DATETIME NOT NULL,
  `fechaFin` DATETIME NOT NULL,
  PRIMARY KEY (`idpromocion`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
