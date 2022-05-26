-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `shop` ;

-- -----------------------------------------------------
-- Table `shop`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`category` (
  `ID` INT NOT NULL,
  `CategoryName` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`customers` (
  `ID` INT NOT NULL,
  `FirstName` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `LastName` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `City` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Address` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `PostalCode` INT UNSIGNED NOT NULL,
  `Phone` INT UNSIGNED NOT NULL,
  `Email` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ShipCity` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `ShipAddress` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ShipPostalCode` INT UNSIGNED NOT NULL,
  `ShipRegion` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`payment` (
  `ID` INT NOT NULL,
  `PaymentType` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Allowed` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`shippers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`shippers` (
  `ID` INT NOT NULL,
  `CompanyName` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Phone` INT UNSIGNED NOT NULL,
  `orders_ID` INT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`orders` (
  `ID` INT NOT NULL,
  `CustomerID` INT UNSIGNED NOT NULL,
  `PaymentID` INT UNSIGNED NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `ShipperID` INT UNSIGNED NOT NULL,
  `TransactStatus` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `PaymentDate` DATETIME NOT NULL,
  `shippers_ID` INT NOT NULL,
  `payment_ID` INT NOT NULL,
  `customers_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `payment_ID`),
  INDEX `fk_orders_shippers_idx` (`shippers_ID` ASC) VISIBLE,
  INDEX `fk_orders_payment1_idx` (`payment_ID` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customers_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_ID`)
    REFERENCES `shop`.`customers` (`ID`),
  CONSTRAINT `fk_orders_payment1`
    FOREIGN KEY (`payment_ID`)
    REFERENCES `shop`.`payment` (`ID`),
  CONSTRAINT `fk_orders_shippers`
    FOREIGN KEY (`shippers_ID`)
    REFERENCES `shop`.`shippers` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`suppliers` (
  `ID` INT NOT NULL,
  `CompanyName` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Address` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `City` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `Country` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `Phone` INT UNSIGNED NOT NULL,
  `Email` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `PaymentMethods` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `DiscountType` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `TypeGoods` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`products` (
  `ID` INT NOT NULL,
  `SKU` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ProductName` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `SupplierID` INT UNSIGNED NOT NULL,
  `CategoryID` INT UNSIGNED NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  `AvailableSizes` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `AvailableColours` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ProductDescription` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `category_ID` INT NOT NULL,
  `suppliers_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_products_category1_idx` (`category_ID` ASC) VISIBLE,
  INDEX `fk_products_suppliers1_idx` (`suppliers_ID` ASC) VISIBLE,
  CONSTRAINT `fk_products_category1`
    FOREIGN KEY (`category_ID`)
    REFERENCES `shop`.`category` (`ID`),
  CONSTRAINT `fk_products_suppliers1`
    FOREIGN KEY (`suppliers_ID`)
    REFERENCES `shop`.`suppliers` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`orderdetails` (
  `ID` INT NOT NULL,
  `ProductID` INT UNSIGNED NOT NULL,
  `OrderID` INT UNSIGNED NOT NULL,
  `Price` INT UNSIGNED NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  `Total` INT UNSIGNED NOT NULL,
  `Size` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `Colour` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `BillDate` DATETIME NOT NULL,
  `orders_ID` INT NOT NULL,
  `products_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_orderdetails_orders1_idx` (`orders_ID` ASC) VISIBLE,
  INDEX `fk_orderdetails_products1_idx` (`products_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orderdetails_orders1`
    FOREIGN KEY (`orders_ID`)
    REFERENCES `shop`.`orders` (`ID`),
  CONSTRAINT `fk_orderdetails_products1`
    FOREIGN KEY (`products_ID`)
    REFERENCES `shop`.`products` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shop`.`product_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shop`.`product_review` (
  `ID` INT NOT NULL,
  `TITLE` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `Rating` INT UNSIGNED NOT NULL,
  `Published_AT` DATETIME NOT NULL,
  `products_ID` INT NOT NULL,
  INDEX `fk_product_review_products1_idx` (`products_ID` ASC) VISIBLE,
  CONSTRAINT `fk_product_review_products1`
    FOREIGN KEY (`products_ID`)
    REFERENCES `shop`.`products` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE products DROP COLUMN CategoryID;
ALTER TABLE products DROP COLUMN SupplierID;
ALTER TABLE orderdetails DROP COLUMN OrderID;
ALTER TABLE shippers DROP COLUMN orders_ID;
ALTER TABLE orderdetails DROP COLUMN ProductID;
ALTER TABLE orders DROP COLUMN ShipperID;
ALTER TABLE orders DROP COLUMN PaymentID;
ALTER TABLE orders DROP COLUMN CustomerID;
ALTER TABLE `shop`.`products` 
ADD COLUMN `Price` INT(45) NOT NULL AFTER `suppliers_ID`;
ALTER TABLE product_review DROP COLUMN Published_AT;
ALTER TABLE `shop`.`product_review` 
ADD COLUMN `Published_at` DATETIME NOT NULL AFTER `Rating`;


INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('1', 'ТОВ “ЕНЕРА”', 'вул. Луганська, 3', 'Львів', 'Україна', '983215012', 'panshind@wpadye.com', 'Готівка, карта', 'немає', 'Одяг, взуття');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('2', 'ТОВ “АІМ”', 'вул. Київська, 77', 'Дніпро', 'Україна', '983498556', 'hjettn@hotmail.red', 'Готівка, карта', 'немає', 'Одяг, взуття');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('3', 'ТОВ \"АС\"', 'вул. Слюсарська, 2в', 'Львів', 'Україна', '0635588765', 'tamara2006art@scdhn.com', 'Готівка, карта', '5% при 1000грн', 'Аксесуари');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('4', 'ТОВ “ЕНСОЛ УКРАЇНА”', 'вул. Зелена, 144', 'Київ', 'Україна', '0985487344', 'benrouse03@gmailiz.com', 'Готівка, карта', '5% при 1000грн', 'Шкарпетки');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('5', 'ТОВ “ОНК-ГРУП”', 'пр. Ч. Калини, 47', 'Львів', 'Україна', '0996533789', 'xehbyfvfhbz@nbobd.com', 'Готівка, карта', 'немає', 'Верхній одяг');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('6', 'ТОВ “НАДІЯ 2000”', 'вул. Садова,56', 'Варшава', 'Польща', '095677267', 'jbyrne500@hotmail.red', 'Карта', 'немає', 'Штани');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('7', 'ТОВ “ОНК-ГРУП”', 'вул. Івана Мазепи, 10А', 'Стамбул', 'Туреччина', '877729488', 'likit420@softmail.site', 'Готівка, карта', 'немає', 'Одяг');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('8', 'ТОВ “А-Б-В”', 'вул. Грушевського,3', 'Одеса', 'Україна', '0636842764', 'namatrosov@mailcuk.com', 'Карта', 'немає', 'Штани');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('9', 'ТОВ “ВЕСНА”', 'пр. Свободи, 12', 'Анкара', 'Туреччина', '804824887', 'wsyrfkjd@eetieg.com', 'Готівка, карта', '5% при 30000грн', 'Верхній одяг');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('10', 'ТОВ “ДРЕСКОД”', 'вул. Лесі Українки, 43Г', 'Одеса', 'Україна', '736487474', 'katrindom@eatneha.com', 'Готівка, карта', '5% при 3000грн', 'Штани');
INSERT INTO `shop`.`suppliers` (`ID`, `CompanyName`, `Address`, `City`, `Country`, `Phone`, `Email`, `PaymentMethods`, `DiscountType`, `TypeGoods`) VALUES ('11', 'ТОВ “ШОВК”', 'вул. Тимошенка Маршала, 37', 'Краків', 'Польща', '794487848', 'datatraveler02@nproxi.com', 'Готівка', 'немає', 'Светри');


INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('1', 'Футболки', 'Найкращий вибір бавовняних футболок, якісний пошив, різноманітні кольори та принти.');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('2', 'Штани', 'Штани для жінок високої якості');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('3', 'Верхній одяг', 'Знайдіть свій улюблений стиль від стьобаних піджаків до довгих вовняних пальт');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('4', 'Шкарпетки', 'Жіночі шкарпетки на будь-який смак ');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('5', 'Светри', 'М\'які та теплі, модні та оригінальні жіночі светри');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('6', 'Сукні', 'Тільки наймодніші жіночі сукні');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('7', 'Спортивні костюми', 'Жіночі спортивні костюми високої якості');
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('8', 'Спідниці', 'Великий вибір жіночих спідниць ');


INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('1', 'фут1', 'Патріотична футболка', '150', '42-50', 'чорний, білий', 'ФУТБОЛКА ЖІНОЧА БІЛА', '1', '1', '350');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('2', 'фут2', 'Патріотична футболка Маки', '120', '44-50', 'червоний', 'Оригінальний принт', '1', '1', '300');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('3', 'фут3', 'Футболка базова', '300', '42-48', 'Беж, чорний, білий', '100% бавовна', '1', '7', '250');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('4', 'фут4', 'Футболка в клітинку', '55', '44', 'Чорний', '100% бавовна', '1', '7', '400');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('5', 'ш1', 'Джинси базові', '100', 'с-л', 'Чорний, сірий', '70% бавовна, 30% еластан', '2', '6', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('6', 'ш2', 'Класичні штани', '1000', 'с-л', 'Чорні, беж, бордо', '70% бавовна, 30% еластан', '2', '6', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('7', 'ш3', 'Спортивні штани', '140', 'с-л', 'Фіолетові, оливка', '70% бавовна, 30% еластан', '2', '8', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('8', 'ш4', 'Брюки-джогери', '400', 'с-л', 'Молочний, білі', '70% бавовна, 30% еластан', '2', '8', '650');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('9', 'ш5', 'Легінси в рубчик', '199', 'с-м', 'Коричневі, хакі, чорні', '70% бавовна, 30% еластан', '2', '8', '400');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('10', 'верх1', 'Куртка зимова', '30', '42-46', 'Біла, молочна, сіра', '100% поліестер', '3', '5', '1200');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('11', 'верх2', 'Куртка двохстороння зимова', '77', '42-46', 'Біло-чорна', 'Утеплювач: синтепух', '3', '5', '4000');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('12', 'верх3', 'Подовжена куртка весна', '800', '42-44', 'Синій, беж, білий', '100% поліестер', '3', '9', '2000');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('13', 'верх4', 'ДВОБОРТНИЙ ТРЕНЧ ІЗ РЕМЕНЕМ', '486', '42-44', 'Зелений, синій, білий', '100% ПОЛІЕСТЕР', '3', '9', '2200');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('14', 'верх5', 'Куртка з накладними кишенями ', '575', '42-44', 'Зелений, рожевий, беж', '100% поліестер', '3', '9', '4000');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('15', 'верх6', 'Вельветова куртка', '223', '42-48', 'Чорний', '100% поліестер', '3', '5', '5000');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('16', 'верх7', 'Тренч оверсайз з вишивкою', '534', '44', 'Білий, хакі, беж', '100% поліестер', '3', '9', '3600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('17', 'верх8', 'Куртка з капюшоном', '100', '42-44', 'Синій, бордовий, хакі', '100% поліестер', '3', '5', '4599');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('18', 'верх9', 'Пальто з коміром', '425', '42-55', 'Молочний, сірий', '100% поліестер', '3', '5', '2300');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('19', 'верх10', 'Укорочена базова куртка', '332', '42-44', 'Помаранчевий, рожевий', '100% поліестер', '3', '9', '2800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('20', 'верх11', 'Пуховик з нат наповнювачем', '5', '46-50', 'Беж', '100% поліестер', '3', '5', '4000');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('21', 'шк1', 'Шкарпетки з авокадо', '1000', '36-44', 'Чорний, білий', '95% бавовна, 5% еластан', '4', '4', '80');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('22', 'шк2', 'Шкарпетки з ананасом', '400', '36-44', 'Білий', '95% бавовна, 5% еластан', '4', '4', '40');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('23', 'шк3', 'Шкарпетки короткі', '800', '36-44', 'Чорний', '95% бавовна, 5% еластан', '4', '4', '50');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('24', 'шк4', 'Шкарпетки в крапочку', '545', '36-49', 'Чорний, білий', '95% бавовна, 5% еластан', '4', '4', '50');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('25', 'шк5', 'Шкарпетки базові', '959', '36-49', 'Білий', '95% бавовна, 5% еластан', '4', '1', '60');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('26', 'шк6', 'Шкарпетки з надписами', '584', '36-44', 'Сірий, білий', '95% бавовна, 5% еластан', '4', '1', '70');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('27', 'шк7', 'Шкарпетки високі', '958', '36-40', 'Сірий', '95% бавовна, 5% еластан', '4', '4', '99');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('28', 'шк8', 'Шкарпетки з маками', '400', '36-40', 'Сірий', '95% бавовна, 5% еластан', '4', '4', '60');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('29', 'шк9', 'Шкарпетки-слідники', '580', '36-44', 'Чорний', '95% бавовна, 5% еластан', '4', '1', '45');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('30', 'шк10', 'Шкарпетки з квітами', '432', '36-44', 'Чорний, сірий', '95% бавовна, 5% еластан', '4', '4', '59');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('31', 'св1', 'Светр однотонний', '687', '42-48', 'Молочний', 'Тканина трикотаж', '5', '7', '500');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('32', 'св2', 'Флісова кофта', '54', '42-48', 'Сірий, білий', 'Тканина трикотаж+фліс', '5', '11', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('33', 'св3', 'В\'язаний светр', '35', '42-48', 'Чорний, вишневий', 'Тканина трикотаж', '5', '11', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('34', 'св4', 'Шерстяний гольф', '2', '42-48', 'Вишневий, білий', 'натуральна шерсть', '5', '1', '500');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('35', 'св5', 'Светр з камінцями', '56', '42-48', 'Синій, хакі', 'Тканина трикотаж', '5', '7', '550');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('36', 'св6', 'Светр в клітинку', '767', '42-44', 'Беж, червоний, синій', 'Тканина трикотаж', '5', '11', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('37', 'св7', 'Светр із малюнком ', '565', '42-44', 'Молочний', 'Тканина трикотаж', '5', '1', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('38', 'св8', 'Кардиган подовжений', '64', '42-44', 'Білий, сірий', 'Тканина трикотаж', '5', '7', '650');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('39', 'св9', 'Кардиган укорочений', '356', '46', 'Рожевий', 'Тканина трикотаж', '5', '7', '570');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('40', 'св10', 'Водолазка однотонна', '357', '46', 'рожевий', 'Тканина трикотаж', '5', '11', '690');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('41', 'св11', 'Трикотажна кофта', '31', '42-44', 'Синій, Жовтий', '100% трикотаж', '5', '11', '500');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('42', 'св12', 'Светр в смужку', '664', '42-48', 'Жовтий', 'Тканина трикотаж', '5', '11', '690');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('43', 'св13', 'Базова кофта в рубчик', '866', '42-50', 'Синій', 'Тканина трикотаж', '5', '7', '470');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('44', 'св14', 'Водолазка з ангори', '45', '42-44', 'Блакитний, синій', '100%ангора', '5', '1', '660');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('45', 'св15', 'Ажурний светр', '35', '42-50', 'Рожевий', 'Тканина трикотаж', '5', '11', '560');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('46', 'св16', 'Спортивна кофта ', '34', '42-44', 'Молочний, сірий', 'Тканина трикотаж', '5', '11', '500');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('47', 'св17', 'Пухнастий светр', '10', '42-44', 'Сірий', '100% норка', '5', '11', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('48', 'св18', 'Пухнастий кардиган', '553', '42-46', 'Блакитний, синій', '100% норка', '5', '11', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('49', 'св19', 'Новорічний светр', '67', '42-46', 'Беж, рожевий', 'Тканина трикотаж', '5', '7', '500');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('50', 'св20', 'Патріотичний светр', '500', '42-56', 'Синій, жовтий', 'Тканина трикотаж', '5', '11', '670');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('51', 'сук1', 'Сукня майка мідкасі ', '490', '42-48', 'Білий', '50% бавовна, 50% віскоза', '6', '1', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('52', 'сук2', 'Сукня-сорочка', '38', '42-44', 'Зелений', '50% бавовна, 50% віскоза', '6', '1', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('53', 'сук3', 'Сукня з зав`язкою', '5', '42-48', 'Сірий, чорний', '50% бавовна, 50% віскоза', '6', '1', '770');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('54', 'сук4', 'Сукня вечірня', '67', '42-48', 'Чорний', '50% бавовна, 50% віскоза', '6', '7', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('55', 'сук5', 'Сукня з відкр спиною', '675', '42-44', 'Чорний', '50% бавовна, 50% віскоза', '6', '7', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('56', 'сук6', 'Сукня в горох', '35', '42-44', 'Молочний, беж', '50% бавовна, 50% віскоза', '6', '7', '880');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('57', 'сук7', 'Сукня в смужку', '805', '42-44', 'молочний', '50% бавовна, 50% віскоза', '6', '7', '900');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('58', 'сук8', 'Сукня на бретелях', '98', '48', 'білий', '50% бавовна, 50% віскоза', '6', '7', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('59', 'сук9', 'Сукня-сарафан', '757', '46', 'чорний', '50% віскоза, 45% поліестр', '6', '1', '670');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('60', 'сук10', 'Сукня ярусна', '858', '42-48', 'рожевий', '50% віскоза, 45% поліестр', '6', '1', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('61', 'сук11', 'Сукня на кнопках', '39', '42-44', 'беж, рожевий', '50% віскоза, 45% поліестр', '6', '7', '600');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('62', 'сук12', 'Сукня на запах', '59', '48', 'Білий', '50% віскоза, 45% поліестр', '6', '7', '650');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('63', 'сук13', 'Сукня із коміром', '390', '46', 'чорний', '50% віскоза, 45% поліестр', '6', '7', '890');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('64', 'сук14', 'Сукня до коліна', '886', '44', 'бежевий', '50% віскоза, 45% поліестр', '6', '1', '900');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('65', 'сук15', 'Сукня нижче коліна', '94', '44', 'блакитний', '100% віскоза', '6', '1', '780');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('66', 'сук16', 'Міні сукня', '86', '42-48', 'жовтий, білий', '100% віскоза', '6', '7', '780');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('67', 'сук17', 'Довга сукня', '58', '42-44', 'рожевий, червоний', '100% бавовна', '6', '7', '830');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('68', 'сп1', 'Вельветовий костюм', '68', '42-48', 'фіотетовий', '95% хлопок, 5% эластан', '7', '1', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('69', 'сп2', 'Костюм в рубчик', '63', '42-48', 'оливковий', '95% хлопок, 5% эластан', '7', '1', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('70', 'сп3', 'Костюм з капюшоном', '24', '42-48', 'Блакитний, жовтий', '95% хлопок, 5% эластан', '7', '1', '900');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('71', 'сп4', 'Костюм без капюшона', '65', '42-48', 'Блакитний', '95% хлопок, 5% эластан', '7', '1', '850');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('72', 'сп5', 'Базовий сп костюм', '64', '42-48', 'Сірий, молочний', '95% хлопок, 5% эластан', '7', '1', '950');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('73', 'сп6', 'Флісовий костюм', '42', '42-44', 'Беж, сірий', '95% хлопок, 5% эластан', '7', '7', '1200');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('74', 'сп7', 'Трикотажний костюм', '64', '42-44', 'Чорний', '100% трикотаж', '7', '7', '780');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('75', 'сп8', 'Спортивний костюм', '98', '42-48', 'чорний', '50% бавовна, 30% віскоза', '7', '7', '800');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('76', 'сп9', 'Патріотичний костюм', '885', '42-48', 'білий', '50% бавовна, 30% віскоза', '7', '1', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('77', 'сп10', 'Літній костюм', '579', '42', 'Малиновий', '50% бавовна, 30% віскоза', '7', '1', '700');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('78', 'сп11', 'Весняний костюм', '846', '42', 'Бордовий', '50% бавовна, 30% віскоза', '7', '7', '650');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('79', 'сп12', 'Унісекс костюм', '484', '44', 'рожевий', '50% бавовна, 30% віскоза', '7', '1', '890');
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('80', 'сп13', 'Костюм в смужку', '846', '44', 'Оливковий', '50% бавовна, 30% віскоза', '7', '1', '1000');


INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('1', 'Marta', 'Lushch', 'Lviv', 'Zelena, 56', '81229', '983215012', 'lushchmarta@gmail.com', 'Kyiv', 'Shevshenka,3', '87345', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('2', 'Щедра', 'Перфецька', 'Одеса', '40 років Перемоги', '67393', '981772250', '34d@gmail.com', 'Тернопіль', 'Луганська', '75684', 'Тернопіль');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('3', 'Йовілла', 'Селезінка', 'Умань', 'Ареф’єва', '65747', '981823445', 'pxacl@mail.com', 'Умань', 'Золота', '65747', 'Умань');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('4', 'Єфросинія', 'Савчин', 'Вінниця', 'Ареф\'єва провулок', '94820', '981848271', '7o1@gmail.com', 'Вінниця', 'Ареф\'єва провулок', '94820', 'Вінниця');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('5', 'Діна', 'Товстоліс', 'Хуст', 'Будівельників', '87079', '981659619', '1@gmail.com', 'Хуст', 'Будівельників', '87079', 'Хуст');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('6', 'Романа', 'Юхимович', 'Kyiv', 'Будівельників провулок', '90992', '981971654', 'iut@gmail.com', 'Kyiv', 'Будівельників провулок', '90992', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('7', 'Цвітана', 'Кирпань', 'Тернопіль', 'Вербова', '94904', '981143977', 'e3t@outlook.com', 'Тернопіль', 'Вербова', '94904', 'Тернопіль');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('8', 'Інга', 'Островська', 'Lviv', 'Весела', '98817', '981120068', '41clb6o2g@yandex.com', 'Lviv', 'Весела', '98817', 'Lviv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('9', 'Елеонора', 'Давиденко', 'Lviv', 'Весняна', '10272', '981391050', '5hsbm8pi3@mail.ua', 'Lviv', 'Весняна', '43424', 'Lviv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('10', 'Елвіна', 'Радиловська', 'Чернівці', 'Вишнева', '10643', '981693575', 'dihf8jxk@gmail.com', 'Чернівці', 'Вишнева', '44423', 'Чернівці');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('11', 'Наталка', 'Єлейко', 'Вінниця', 'Воїнів-афганців бульвар', '11055', '981291335', 'dwej@yandex.ua', 'Вінниця', 'Воїнів-афганців бульвар', '11055', 'Вінниця');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('12', 'Леля', 'Береза', 'Одеса', 'Володимирська', '11448', '981588468', 'zyue8brv@outlook.com', 'Одеса', 'Володимирська', '11448', 'Одеса');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('13', 'Юліанія', 'Джима', 'Одеса', 'Гагаріна', '11381', '981675290', '0a5437@mail.ua', 'Одеса', 'Гагаріна', '11381', 'Одеса');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('14', 'Ждана', 'Конюшенко', 'Тернопіль', 'Ганни Бабій', '12229', '981622737', 'fovtju3q2@yandex.ua', 'Тернопіль', 'Ганни Бабій', '12229', 'Тернопіль');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('15', 'Шанетта', 'Ґойдич', 'Kyiv', 'Герцена ', '16206', '981646965', '5ntglejc9@outlook.com', 'Kyiv', 'Герцена ', '16206', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('16', 'Цецілія', 'Курпіта', 'Рівне', 'Герцена провулок', '13019', '981671192', '61rpbj@mail.ru', 'Рівне', 'Герцена провулок', '13019', 'Рівне');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('17', 'Ігорина', 'Дроб\'язко', 'Житомир', 'Житній провулок', '13403', '981695420', '9m6pfk52r@outlook.com', 'Житомир', 'Житній провулок', '13403', 'Житомир');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('18', 'Люборада', 'Гій', 'Хуст', 'Житня', '13944', '981719648', 'gr@yandex.ru', 'Хуст', 'Житня', '13944', 'Хуст');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('19', 'Марія', 'Чубатенко', 'Kyiv', 'Житомирська', '14857', '981743876', 'v9dux@gmail.com', 'Kyiv', 'Харківська', '14857', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('20', 'Цецілія', 'Горностай', 'Kyiv', 'Житомирський провулок', '15770', '981768104', 'mek975vcx@gmail.com', 'Kyiv', 'Морська', '15770', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('21', 'Либідь', 'Ніколаєнко', 'Дніпро', 'Заводська', '14982', '981792332', 'uakvj8p9d@yandex.ru', 'Дніпро', 'Заводська', '14982', 'Дніпро');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('22', 'Любов', 'Дзерин', 'Житомир', 'Залізнична', '15595', '981816559', 't3m6u8v@gmail.com', 'Житомир', 'Залізнична', '15595', 'Житомир');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('23', 'Зорегляда', 'Зайчук', 'Одеса', 'Зарічна', '15658', '981840787', 'jxqme@gmail.com', 'Одеса', 'Зарічна', '15658', 'Одеса');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('24', 'Дорофея', 'Тернопільська', 'Рівне', 'Миру', '15800', '981865015', 'c3@gmail.com', 'Рівне', 'Миру', '15800', 'Рівне');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('25', 'Богдана', 'Горжий', 'Рівне', 'Незалежності', '15943', '981889243', '3xkgmsd9t@gmail.com', 'Рівне', 'Незалежності', '15943', 'Рівне');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('26', 'Льоля', 'Шарко', 'Кривий Ріг', 'Партизанський провулок', '16086', '981913471', 's9iw@mail.ru', 'Кривий Ріг', 'Партизанський провулок', '16086', 'Кривий Ріг');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('27', 'Наслава', 'Петрина', 'Одеса', 'Першотравнева', '16228', '981937699', 'qo2sc@mail.ru', 'Одеса', 'Першотравнева', '34524', 'Одеса');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('28', 'Жадана', 'Мацола', 'Дніпро', 'Першотравневий провулок', '16371', '981961927', 'xiuq5olft@gmail.com', 'Дніпро', 'Першотравневий провулок', '16371', 'Дніпро');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('29', 'Владлена', 'Бабляк', 'Золочів', 'Покальчука', '16514', '981986154', '8swlo27hd@outlook.com', 'Золочів', 'Покальчука', '16514', 'Золочів');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('30', 'Ядвіга', 'Савчин', 'Чернівці', 'Покальчука провулок', '16657', '982010382', 'r0o6f92@gmail.com', 'Чернівці', 'Покальчука провулок', '16657', 'Чернівці');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('31', 'Ладомира', 'Горобець', 'Lviv', 'Поліська', '16799', '982034610', 'z@gmail.com', 'Kyiv', 'Поліська', '16799', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('32', 'Йосифата', 'Салійчук', 'Кривий Ріг', 'Польова', '16942', '982058838', 'r3p4mgf5@yandex.ua', 'Кривий Ріг', 'Польова', '16942', 'Кривий Ріг');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('33', 'Щазина', 'Липа', 'Lviv', 'Привокзальна', '17085', '982083066', 'p@outlook.com', 'Lviv', 'Привокзальна', '17085', 'Lviv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('34', 'Щедра', 'Откович', 'Lviv', 'Промислова', '17227', '982107294', '61j@yandex.ua', 'Kyiv', 'Промислова', '17227', 'Kyiv');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('35', 'Ірина', 'Лиско', 'Дніпро', 'Промисловий провулок', '17370', '982131522', 't2sr@gmail.com', 'Дніпро', 'Промисловий провулок', '17370', 'Дніпро');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('36', 'Анна', 'Зінько', 'Кривий Ріг', 'Пушкіна', '17513', '982155749', 'u7@outlook.com', 'Кривий Ріг', 'Взуттєва', '17513', 'Кривий Ріг');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('37', 'Софія', 'Єфименко', 'Переяслав', 'Робітничий провулок', '17655', '982179977', '9k15qr2h@gmail.com', 'Переяслав', 'Робітничий провулок', '17655', 'Переяслав');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('38', 'Єлизавета', 'Чачковська', 'Рівне', 'Садова', '17798', '982204205', '3vmtdo1@outlook.com', 'Рівне', 'Садова', '17798', 'Рівне');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('39', 'Йосифата', 'Кльоц', 'Чернівці', 'Свято-Миколаївська', '17941', '982228433', 'q9@mail.ua', 'Чернівці', 'Свято-Миколаївська', '17941', 'Чернівці');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('40', 'Ольга', 'Бідило', 'Lviv', 'Слюсарська', '18084', '982252661', 'jirbold@gmail.com', 'Lviv', 'Слюсарська', '48847', 'Lviv');


INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('1', 'Готівковими грошима кур’єру', 'no');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('2', 'Готівкою через платіжний термінал', 'yes');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('3', 'Післяплата', 'no');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('4', 'Оплата на картку продавця', 'yes');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('5', 'Онлайн-банкінг', 'yes');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('6', 'Електронні платіжні системи', 'yes');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('7', 'Кредит і оплата частинами', 'no');
INSERT INTO `shop`.`payment` (`ID`, `PaymentType`, `Allowed`) VALUES ('8', 'Передплата+післяплата', 'yes');

INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('1', 'Укрпошта', '800300545');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('2', 'Нова Пошта', '984500609');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('3', 'Мееst Express', '504327707');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('4', 'Justin', '800301661');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('5', 'Самовивіз', '0');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('6', 'DELFast', '996534999');
INSERT INTO `shop`.`shippers` (`ID`, `CompanyName`, `Phone`) VALUES ('7', 'ІнТайм', '995678543');


INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (3,'2021-10-19 00:00:00','Payed','2021-10-19 00:00:00',2,5,2);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (4,'2021-10-20 00:00:00','Payed','2021-10-20 00:00:00',2,5,39);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (5,'2021-10-20 00:00:00','Payed','2021-10-20 00:00:00',2,6,31);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (6,'2021-10-20 00:00:00','Payed','2021-10-20 00:00:00',2,8,20);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (7,'2021-10-25 00:00:00','Payed','2021-10-25 00:00:00',1,8,11);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (8,'2021-10-20 00:00:00','Payed','2021-10-20 00:00:00',1,5,37);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (9,'2021-10-21 00:00:00','Payed','2021-10-21 00:00:00',2,5,26);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (10,'2021-10-22 00:00:00','Payed','2021-10-22 00:00:00',2,5,25);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (11,'2021-10-23 00:00:00','Payed','2021-10-23 00:00:00',1,5,28);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (12,'2021-10-24 00:00:00','Payed','2021-10-24 00:00:00',2,5,12);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (13,'2021-10-25 00:00:00','Not payed','2021-10-25 00:00:00',1,6,40);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (14,'2021-10-26 00:00:00','Payed','2021-10-26 00:00:00',2,6,39);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (15,'2021-10-27 00:00:00','Payed','2021-10-27 00:00:00',2,8,34);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (16,'2021-10-28 00:00:00','Payed','2021-10-28 00:00:00',2,5,5);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (17,'2021-10-29 00:00:00','Payed','2021-10-29 00:00:00',5,1,39);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (18,'2021-10-30 00:00:00','Payed','2021-10-30 00:00:00',4,2,7);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (19,'2021-10-31 00:00:00','Payed','2021-10-31 00:00:00',2,5,9);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (20,'2021-11-01 00:00:00','Payed','2021-11-01 00:00:00',2,8,39);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (21,'2021-11-02 00:00:00','Not payed','2021-11-02 00:00:00',2,7,1);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (22,'2021-11-03 00:00:00','Payed','2021-11-03 00:00:00',2,4,29);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (23,'2021-11-04 00:00:00','Payed','2021-11-04 00:00:00',2,3,7);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (24,'2021-11-05 00:00:00','Payed','2021-11-05 00:00:00',2,5,7);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (25,'2021-11-06 00:00:00','Payed','2021-11-06 00:00:00',2,3,8);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (26,'2021-11-07 00:00:00','Payed','2021-11-07 00:00:00',1,7,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (27,'2021-11-08 00:00:00','Payed','2021-11-08 00:00:00',1,8,36);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (28,'2021-11-09 00:00:00','Payed','2021-11-09 00:00:00',6,8,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (29,'2021-11-10 00:00:00','Not payed','2021-11-10 00:00:00',7,6,9);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (30,'2021-11-11 00:00:00','Payed','2021-11-11 00:00:00',6,6,29);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (31,'2021-11-12 00:00:00','Payed','2021-11-12 00:00:00',2,6,27);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (32,'2021-11-13 00:00:00','Payed','2021-11-13 00:00:00',2,6,40);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (33,'2021-11-14 00:00:00','Payed','2021-11-14 00:00:00',2,6,37);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (34,'2021-11-15 00:00:00','Payed','2021-11-15 00:00:00',2,5,38);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (35,'2021-11-16 00:00:00','Payed','2021-11-16 00:00:00',2,5,2);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (36,'2021-11-17 00:00:00','Payed','2021-11-17 00:00:00',4,5,39);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (37,'2021-11-18 00:00:00','Payed','2021-11-18 00:00:00',4,3,21);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (38,'2021-11-19 00:00:00','Payed','2021-11-19 00:00:00',2,2,6);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (39,'2021-11-20 00:00:00','Not payed','2021-11-20 00:00:00',1,1,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (40,'2021-11-21 00:00:00','Payed','2021-11-21 00:00:00',3,6,27);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (41,'2021-11-22 00:00:00','Payed','2021-11-22 00:00:00',3,6,17);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (42,'2021-11-23 00:00:00','Payed','2021-11-23 00:00:00',3,8,29);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (43,'2021-11-24 00:00:00','Payed','2021-11-24 00:00:00',1,5,23);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (44,'2021-11-25 00:00:00','Payed','2021-11-25 00:00:00',2,4,35);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (45,'2021-11-26 00:00:00','Payed','2021-11-26 00:00:00',3,7,12);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (46,'2021-11-15 00:00:00','Payed','2021-11-15 00:00:00',3,7,8);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (47,'2021-11-16 00:00:00','Payed','2021-11-16 00:00:00',2,5,32);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (48,'2021-11-17 00:00:00','Payed','2021-11-17 00:00:00',2,8,17);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (49,'2021-11-14 00:00:00','Payed','2021-11-14 00:00:00',2,8,6);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (50,'2021-11-15 00:00:00','Payed','2021-11-15 00:00:00',2,8,16);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (51,'2021-11-16 00:00:00','Payed','2021-11-16 00:00:00',2,8,36);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (52,'2021-11-17 00:00:00','Payed','2021-11-17 00:00:00',7,8,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (53,'2021-11-14 00:00:00','Payed','2021-11-14 00:00:00',4,8,8);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (54,'2021-11-15 00:00:00','Payed','2021-11-15 00:00:00',3,5,16);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (55,'2021-11-16 00:00:00','Payed','2021-11-16 00:00:00',2,5,9);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (56,'2021-11-17 00:00:00','Payed','2021-11-17 00:00:00',2,5,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (57,'2021-11-18 00:00:00','Payed','2021-11-18 00:00:00',2,6,14);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (58,'2021-11-19 00:00:00','Payed','2021-11-19 00:00:00',1,6,21);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (59,'2021-11-20 00:00:00','Payed','2021-11-20 00:00:00',2,3,2);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (60,'2021-11-21 00:00:00','Payed','2021-11-21 00:00:00',1,4,9);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (61,'2021-11-22 00:00:00','Payed','2021-11-22 00:00:00',4,2,33);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (62,'2021-11-23 00:00:00','Payed','2021-11-23 00:00:00',3,5,12);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (63,'2021-11-24 00:00:00','Payed','2021-11-24 00:00:00',3,2,1);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (64,'2021-11-25 00:00:00','Payed','2021-11-25 00:00:00',2,7,3);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (65,'2021-11-26 00:00:00','Payed','2021-11-26 00:00:00',2,6,12);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (66,'2021-11-27 00:00:00','Payed','2021-11-27 00:00:00',2,5,2);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (67,'2021-11-28 00:00:00','Payed','2021-11-28 00:00:00',2,6,24);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (68,'2021-11-29 00:00:00','Payed','2021-11-29 00:00:00',1,8,19);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (69,'2021-11-30 00:00:00','Payed','2021-11-30 00:00:00',2,8,7);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (70,'2021-12-01 00:00:00','Payed','2021-12-01 00:00:00',2,8,31);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (71,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',1,8,18);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (72,'2021-12-03 00:00:00','Payed','2021-12-03 00:00:00',4,8,19);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (73,'2021-12-04 00:00:00','Payed','2021-12-04 00:00:00',3,8,26);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (74,'2021-12-01 00:00:00','Not payed','2021-12-01 00:00:00',3,8,12);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (75,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',3,5,30);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (76,'2021-12-03 00:00:00','Payed','2021-12-03 00:00:00',2,6,22);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (77,'2021-12-04 00:00:00','Not payed','2021-12-04 00:00:00',2,5,26);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (78,'2021-12-01 00:00:00','Payed','2021-12-01 00:00:00',2,6,38);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (79,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',2,5,17);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (80,'2021-12-03 00:00:00','Payed','2021-12-03 00:00:00',3,5,30);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (81,'2021-12-04 00:00:00','Payed','2021-12-04 00:00:00',1,5,22);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (82,'2021-12-01 00:00:00','Payed','2021-12-01 00:00:00',1,5,16);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (83,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',2,2,5);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (84,'2021-12-03 00:00:00','Payed','2021-12-03 00:00:00',2,4,37);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (85,'2021-12-04 00:00:00','Payed','2021-12-04 00:00:00',2,6,7);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (86,'2021-12-01 00:00:00','Payed','2021-12-01 00:00:00',2,6,32);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (87,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',2,8,36);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (88,'2021-12-03 00:00:00','Payed','2021-12-03 00:00:00',2,6,34);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (89,'2021-12-04 00:00:00','Payed','2021-12-04 00:00:00',2,5,17);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (90,'2021-12-05 00:00:00','Payed','2021-12-05 00:00:00',1,1,35);

INSERT INTO shop.orderdetails VALUES(1, (SELECT Price from shop.products where ID=3), 2, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=3), 3, 1);
INSERT INTO shop.orderdetails VALUES(2, (SELECT Price from shop.products where ID=4), 1, Price*Quantity, '44', "Синій", (select OrderDate from shop.orders where ID=4), 4, 33);
INSERT INTO shop.orderdetails VALUES(3, (SELECT Price from shop.products where ID=5), 1, Price*Quantity, '45', "Жовтий", (select OrderDate from shop.orders where ID=5), 5, 36);
INSERT INTO shop.orderdetails VALUES(4, (SELECT Price from shop.products where ID=6), 1, Price*Quantity, '44', "Блакитний", (select OrderDate from shop.orders where ID=6), 6, 35);
INSERT INTO shop.orderdetails VALUES(5, (SELECT Price from shop.products where ID=7), 1, Price*Quantity, '44', "Червоний", (select OrderDate from shop.orders where ID=7), 7, 10);
INSERT INTO shop.orderdetails VALUES(6, (SELECT Price from shop.products where ID=8), 2, Price*Quantity, '40', "Чорний", (select OrderDate from shop.orders where ID=8), 8, 11);
INSERT INTO shop.orderdetails VALUES(7, (SELECT Price from shop.products where ID=9), 3, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=9), 9, 12);
INSERT INTO shop.orderdetails VALUES(8, (SELECT Price from shop.products where ID=7), 1, Price*Quantity, '44', "Червоний", (select OrderDate from shop.orders where ID=7), 7, 10);
INSERT INTO shop.orderdetails VALUES(9, (SELECT Price from shop.products where ID=8), 2, Price*Quantity, '40', "Чорний", (select OrderDate from shop.orders where ID=8), 8, 11);
INSERT INTO shop.orderdetails VALUES(10, (SELECT Price from shop.products where ID=9), 3, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=9), 9, 12);
INSERT INTO shop.orderdetails VALUES(11, (SELECT Price from shop.products where ID=10), 1, Price*Quantity, '44', "Зелений", (select OrderDate from shop.orders where ID=10), 10, 13);
INSERT INTO shop.orderdetails VALUES(12, (SELECT Price from shop.products where ID=11), 2, Price*Quantity, '40', "Коричневий", (select OrderDate from shop.orders where ID=11), 11, 14);
INSERT INTO shop.orderdetails VALUES(13, (SELECT Price from shop.products where ID=12), 3, Price*Quantity, '39', "Синій", (select OrderDate from shop.orders where ID=12), 12, 15);
INSERT INTO shop.orderdetails VALUES(14, (SELECT Price from shop.products where ID=13), 1, Price*Quantity, '44', "Червоний", (select OrderDate from shop.orders where ID=13), 13, 16);
INSERT INTO shop.orderdetails VALUES(15, (SELECT Price from shop.products where ID=14), 2, Price*Quantity, '36', "Чорний", (select OrderDate from shop.orders where ID=14), 14, 17);
INSERT INTO shop.orderdetails VALUES(16, (SELECT Price from shop.products where ID=15), 3, Price*Quantity, '57', "Червоний", (select OrderDate from shop.orders where ID=15), 15, 18);
INSERT INTO shop.orderdetails VALUES(17, (SELECT Price from shop.products where ID=16), 1, Price*Quantity, '52', "Зелений", (select OrderDate from shop.orders where ID=16), 16, 19);
INSERT INTO shop.orderdetails VALUES(18, (SELECT Price from shop.products where ID=17), 2, Price*Quantity, '50', "Коричневий", (select OrderDate from shop.orders where ID=17), 17, 20);
INSERT INTO shop.orderdetails VALUES(19, (SELECT Price from shop.products where ID=18), 3, Price*Quantity, '49', "Синій", (select OrderDate from shop.orders where ID=18), 18, 21);
INSERT INTO shop.orderdetails VALUES(20, (SELECT Price from shop.products where ID=19), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=19), 19, 22);
INSERT INTO shop.orderdetails VALUES(21, (SELECT Price from shop.products where ID=20), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=20), 20, 23);
INSERT INTO shop.orderdetails VALUES(22, (SELECT Price from shop.products where ID=21), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=21), 21, 24);
INSERT INTO shop.orderdetails VALUES(23, (SELECT Price from shop.products where ID=22), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=22), 22, 25);
INSERT INTO shop.orderdetails VALUES(24, (SELECT Price from shop.products where ID=23), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=23), 23, 26);
INSERT INTO shop.orderdetails VALUES(25, (SELECT Price from shop.products where ID=24), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=24), 24, 27);
INSERT INTO shop.orderdetails VALUES(26, (SELECT Price from shop.products where ID=25), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=25), 25, 28);
INSERT INTO shop.orderdetails VALUES(27, (SELECT Price from shop.products where ID=26), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=26), 26, 29);
INSERT INTO shop.orderdetails VALUES(28, (SELECT Price from shop.products where ID=27), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=27), 27, 30);
INSERT INTO shop.orderdetails VALUES(29, (SELECT Price from shop.products where ID=28), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=28), 28, 31);
INSERT INTO shop.orderdetails VALUES(30, (SELECT Price from shop.products where ID=29), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=29), 19, 32);
INSERT INTO shop.orderdetails VALUES(31, (SELECT Price from shop.products where ID=30), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=30), 20, 33);
INSERT INTO shop.orderdetails VALUES(32, (SELECT Price from shop.products where ID=31), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=31), 31, 34);
INSERT INTO shop.orderdetails VALUES(33, (SELECT Price from shop.products where ID=32), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=32), 32, 35);
INSERT INTO shop.orderdetails VALUES(34, (SELECT Price from shop.products where ID=33), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=33), 33, 36);
INSERT INTO shop.orderdetails VALUES(35, (SELECT Price from shop.products where ID=34), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=34), 34, 37);
INSERT INTO shop.orderdetails VALUES(36, (SELECT Price from shop.products where ID=35), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=35), 35, 38);
INSERT INTO shop.orderdetails VALUES(37, (SELECT Price from shop.products where ID=36), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=36), 36, 39);
INSERT INTO shop.orderdetails VALUES(38, (SELECT Price from shop.products where ID=37), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=37), 37, 40);
INSERT INTO shop.orderdetails VALUES(39, (SELECT Price from shop.products where ID=38), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=38), 38, 41);
INSERT INTO shop.orderdetails VALUES(40, (SELECT Price from shop.products where ID=39), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=39), 39, 42);
INSERT INTO shop.orderdetails VALUES(41, (SELECT Price from shop.products where ID=40), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=40), 40, 43);
INSERT INTO shop.orderdetails VALUES(42, (SELECT Price from shop.products where ID=41), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=41), 41, 44);
INSERT INTO shop.orderdetails VALUES(43, (SELECT Price from shop.products where ID=42), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=42), 42, 45);
INSERT INTO shop.orderdetails VALUES(44, (SELECT Price from shop.products where ID=43), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=43), 43, 46);
INSERT INTO shop.orderdetails VALUES(45, (SELECT Price from shop.products where ID=44), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=44), 44, 47);
INSERT INTO shop.orderdetails VALUES(46, (SELECT Price from shop.products where ID=45), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=45), 45, 48);
INSERT INTO shop.orderdetails VALUES(47, (SELECT Price from shop.products where ID=46), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=46), 46, 49);
INSERT INTO shop.orderdetails VALUES(48, (SELECT Price from shop.products where ID=47), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=47), 47, 50);
INSERT INTO shop.orderdetails VALUES(49, (SELECT Price from shop.products where ID=48), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=48), 48, 51);
INSERT INTO shop.orderdetails VALUES(50, (SELECT Price from shop.products where ID=49), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=49), 49, 52);
INSERT INTO shop.orderdetails VALUES(51, (SELECT Price from shop.products where ID=50), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=50), 50, 53);
INSERT INTO shop.orderdetails VALUES(52, (SELECT Price from shop.products where ID=51), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=51), 51, 54);
INSERT INTO shop.orderdetails VALUES(53, (SELECT Price from shop.products where ID=52), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=52), 52, 55);
INSERT INTO shop.orderdetails VALUES(54, (SELECT Price from shop.products where ID=53), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=53), 53, 56);
INSERT INTO shop.orderdetails VALUES(55, (SELECT Price from shop.products where ID=54), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=54), 54, 57);
INSERT INTO shop.orderdetails VALUES(56, (SELECT Price from shop.products where ID=55), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=55), 55, 58);
INSERT INTO shop.orderdetails VALUES(57, (SELECT Price from shop.products where ID=56), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=56), 56, 59);
INSERT INTO shop.orderdetails VALUES(58, (SELECT Price from shop.products where ID=57), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=57), 57, 60);
INSERT INTO shop.orderdetails VALUES(59, (SELECT Price from shop.products where ID=58), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=58), 58, 61);
INSERT INTO shop.orderdetails VALUES(60, (SELECT Price from shop.products where ID=69), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=69), 69, 72);
INSERT INTO shop.orderdetails VALUES(61, (SELECT Price from shop.products where ID=70), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=70), 70, 73);
INSERT INTO shop.orderdetails VALUES(62, (SELECT Price from shop.products where ID=71), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=71), 71, 74);
INSERT INTO shop.orderdetails VALUES(63, (SELECT Price from shop.products where ID=72), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=72), 72, 75);
INSERT INTO shop.orderdetails VALUES(64, (SELECT Price from shop.products where ID=73), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=73), 73, 76);
INSERT INTO shop.orderdetails VALUES(65, (SELECT Price from shop.products where ID=74), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=74), 74, 77);
INSERT INTO shop.orderdetails VALUES(66, (SELECT Price from shop.products where ID=75), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=75), 75, 78);
INSERT INTO shop.orderdetails VALUES(67, (SELECT Price from shop.products where ID=76), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=76), 76, 79);
INSERT INTO shop.orderdetails VALUES(68, (SELECT Price from shop.products where ID=77), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=77), 77, 80);
INSERT INTO shop.orderdetails VALUES(69, (SELECT Price from shop.products where ID=78), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=78), 78, 31);
INSERT INTO shop.orderdetails VALUES(70, (SELECT Price from shop.products where ID=79), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=79), 79, 22);
INSERT INTO shop.orderdetails VALUES(71, (SELECT Price from shop.products where ID=80), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=80), 80, 43);
INSERT INTO shop.orderdetails VALUES(72, (SELECT Price from shop.products where ID=24), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=81), 81, 24);
INSERT INTO shop.orderdetails VALUES(73, (SELECT Price from shop.products where ID=55), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=82), 82, 55);
INSERT INTO shop.orderdetails VALUES(74, (SELECT Price from shop.products where ID=66), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=83), 83, 66);
INSERT INTO shop.orderdetails VALUES(75, (SELECT Price from shop.products where ID=77), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=84), 84, 77);
INSERT INTO shop.orderdetails VALUES(76, (SELECT Price from shop.products where ID=18), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=85), 85, 18);
INSERT INTO shop.orderdetails VALUES(77, (SELECT Price from shop.products where ID=22), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=86), 86, 22);
INSERT INTO shop.orderdetails VALUES(78, (SELECT Price from shop.products where ID=40), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=87), 87, 40);
INSERT INTO shop.orderdetails VALUES(79, (SELECT Price from shop.products where ID=51), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=88), 88, 51);
INSERT INTO shop.orderdetails VALUES(80, (SELECT Price from shop.products where ID=62), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=89), 89, 62);
INSERT INTO shop.orderdetails VALUES(81, (SELECT Price from shop.products where ID=13), 2, Price*Quantity, '40', "Білий", (select OrderDate from shop.orders where ID=90), 90, 13);
INSERT INTO shop.orderdetails VALUES(82, (SELECT Price from shop.products where ID=24), 1, Price*Quantity, '42', "Зелений", (select OrderDate from shop.orders where ID=21), 21, 24);
INSERT INTO shop.orderdetails VALUES(83, (SELECT Price from shop.products where ID=35), 5, Price*Quantity, '41', "Зелений", (select OrderDate from shop.orders where ID=22), 22, 35);
INSERT INTO shop.orderdetails VALUES(84, (SELECT Price from shop.products where ID=46), 1, Price*Quantity, '44', "Чорний", (select OrderDate from shop.orders where ID=23), 23, 46);
INSERT INTO shop.orderdetails VALUES(85, (SELECT Price from shop.products where ID=57), 7, Price*Quantity, '43', "Сірий", (select OrderDate from shop.orders where ID=24), 24, 57);
INSERT INTO shop.orderdetails VALUES(86, (SELECT Price from shop.products where ID=68), 1, Price*Quantity, '39', "Зелений", (select OrderDate from shop.orders where ID=25), 25, 68);
INSERT INTO shop.orderdetails VALUES(87, (SELECT Price from shop.products where ID=79), 2, Price*Quantity, '39', "Помаранчевий", (select OrderDate from shop.orders where ID=26), 26, 79);
INSERT INTO shop.orderdetails VALUES(88, (SELECT Price from shop.products where ID=9), 1, Price*Quantity, '46', "Білий", (select OrderDate from shop.orders where ID=27), 27, 9);
INSERT INTO shop.orderdetails VALUES(89, (SELECT Price from shop.products where ID=31), 1, Price*Quantity, '39', "Червоний", (select OrderDate from shop.orders where ID=28), 28, 31);
INSERT INTO shop.orderdetails VALUES(90, (SELECT Price from shop.products where ID=77), 1, Price*Quantity, '39', "Білий", (select OrderDate from shop.orders where ID=19), 19, 77);

INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (1,'Все супер',12,'2022-10-09 00:00:00',1);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (2,'Чудово',11,'2022-10-10 00:00:00',2);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (3,'Товар підійшов',12,'2022-10-11 00:00:00',3);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (4,'Дякую, все добре',10,'2022-10-12 00:00:00',4);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (5,'Спасибі за оперативність обслуговування!',12,'2022-10-14 00:00:00',7);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (6,'Як завжди все було швидко',11,'2022-10-13 00:00:00',35);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (7,'Продукція якісна, сервіс на висоті! ',10,'2022-10-15 00:00:00',23);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (8,'Дякую! Буду у Вас замовляти ще!',11,'2022-10-16 00:00:00',76);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (9,'Речі гарної якості',11,'2022-10-18 00:00:00',36);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (10,'. Дуже задоволена я і моя донька.',12,'2022-10-19 00:00:00',46);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (11,'кість товарів та обслуговування клієнтів висока та приємна',11,'2022-10-20 00:00:00',77);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (12,'Надалі планую вдягати доню у вас!)))',10,'2022-10-21 00:00:00',53);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (13,'Дуже вдячна за якісну працю',10,'2022-10-22 00:00:00',18);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (14,'Завжди на вищому рівні! ',10,'2022-10-23 00:00:00',34);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (15,'Як завжди швидко, зручно, якісно',11,'2022-10-24 00:00:00',7);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (16,'Дуже сподобалася посилка з одягом',12,'2022-10-25 00:00:00',65);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (17,'Безсумнівна якість.',11,'2022-10-26 00:00:00',12);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (18,'Якість вражаюча! ',10,'2022-10-27 00:00:00',42);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (19,'Якісні товари, якісний сервіс, прийнятні ціни',10,'2022-10-28 00:00:00',76);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (20,'Дякую за сервіс',12,'2022-10-29 00:00:00',80);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (21,'Надзвичайно крутий магазин',9,'2022-10-30 00:00:00',79);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (22,' якісні речі і доступні ціни',10,'2022-10-31 00:00:00',60);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (23,'опис товару відповідвє реальним характеристикам',11,'2022-11-01 00:00:00',67);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (24,'Чудовий магазин!',11,'2022-11-02 00:00:00',75);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (25,'Без проблем оформили',10,'2022-11-03 00:00:00',38);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (26,' все сподобалося)',12,'2022-11-04 00:00:00',69);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (27,'Чудовий сервіс!',10,'2022-11-05 00:00:00',11);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (28,'Величезний вибір',11,'2022-11-06 00:00:00',77);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (29,'Такого немає у інших магазинах. Рекомендую!',12,'2022-11-07 00:00:00',27);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (30,'Замовляю не вперше. Все подобається. ',12,'2022-11-08 00:00:00',21);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (31,'Швидка доставка.',11,'2022-11-09 00:00:00',38);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (32,'е. Швидко та оперативно доставили.',10,'2022-11-10 00:00:00',35);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (33,'Товар чудової якості!',10,'2022-11-11 00:00:00',33);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (34,'. Дуже задоволена товаром',10,'2022-11-12 00:00:00',31);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (35,'Купівлею залишилася задоволена як завжди',11,'2022-11-13 00:00:00',27);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (36,'Відправка швидка.',12,'2022-11-14 00:00:00',29);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (37,'Рекомендую!',11,'2022-11-15 00:00:00',31);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (38,'Все швидко та лаконічно',10,'2022-11-16 00:00:00',65);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (39,'отова повертатися та рекомендувати магазин знайомим.',11,'2022-11-17 00:00:00',45);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (40,'ціни радують, відмінний сервіс, рекомендую.',12,'2022-11-18 00:00:00',11);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (41,'. Товар завжди високої якості',10,'2022-11-19 00:00:00',73);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (42,'Якість товару на висоті',11,'2022-11-20 00:00:00',9);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (43,' Дякую за роботу. Буду звертатися ще!',12,'2022-11-21 00:00:00',8);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (44,'Все сподобалося, якість товару відмінна, сервіс також.',10,'2022-11-22 00:00:00',34);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (45,'Все сподобалося як комунікація так і швидкість відправлення замовлення.',11,'2022-11-23 00:00:00',74);
-- ----------------------------------------------------------------------------------------


-- ----------------------------------------------------------------------------------------
-- як клієнт..
--
-- login
-- 7
SELECT p.*, BillDate, TransactStatus from shop.customers c join shop.orders o on c.ID = o.customers_ID 
join shop.orderdetails od on od.orders_ID=o.ID join shop.products p on p.ID=od.products_ID where customers_ID=2;

-- registration
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('39', 'Йосифата', 'Кльоц', 'Чернівці', 'Свято-Миколаївська', '17941', '982228433', 'q9@mail.ua', 'Чернівці', 'Свято-Миколаївська', '17941', 'Чернівці');
INSERT INTO `shop`.`customers` (`ID`, `FirstName`, `LastName`, `City`, `Address`, `PostalCode`, `Phone`, `Email`, `ShipCity`, `ShipAddress`, `ShipPostalCode`, `ShipRegion`) VALUES ('40', 'Ольга', 'Бідило', 'Lviv', 'Слюсарська', '18084', '982252661', 'jirbold@gmail.com', 'Lviv', 'Слюсарська', '48847', 'Lviv');

-- view item\account information
SELECT * FROM shop.products;
SELECT * FROM shop.customers where ID=33;

-- update account information
UPDATE `shop`.`customers` SET `PostalCode` = '37409', `Phone` = '981671178' WHERE (`ID` = '16');

-- sort products
-- 1.	Бачити усю інформацію про всі товари магазину, де присутній мій улюблений чорний колір.
SELECT * FROM shop.products where AvailableColours LIKE '%чорний%';

-- 2.	Бачити усю інформацію про светри 44 розміру з ціною не дорожче 600 грн.
SELECT * FROM shop.products where SKU LIKE 'св%' AND Price < 600 order by AvailableSizes;

-- 3.	Бачити усю інформацію про усі жовті, сині, блакитні товари від українських постачальників, щоб цим підтримати укр. економіку.
SELECT p.*, s.Country
FROM shop.products p JOIN shop.suppliers s ON p.suppliers_ID = s.ID
WHERE s.Country = 'Україна'
        AND (p.AvailableColours LIKE '%синій%'
        OR p.AvailableColours LIKE '%жовтий%'
        OR p.AvailableColours LIKE '%блакитний%')

-- 4.	Знайти усю інформацію про костюми, яких є у наявності більше 50 шт ціною до 800 грн.\шт.
SELECT * FROM shop.products where SKU LIKE 'сп%' AND Price < 800 AND Quantity > 50;

-- view reviews
-- 5.	Бачити 15 найсвіжіших відгуків про товари (назви їх) у даному магазині.
SELECT TITLE, ProductName, Published_at FROM shop.product_review pr join shop.products p on pr.products_ID=p.ID 
ORDER BY Published_at DESC LIMIT 15;
-- place reviews
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (41,'. Товар завжди високої якості',10,'2022-11-19 00:00:00',73);
INSERT INTO shop.product_review (`ID`,`TITLE`,`Rating`,`Published_at`,`products_ID`) VALUES (42,'Якість товару на висоті',11,'2022-11-20 00:00:00',9);

-- view shipping methods
-- 6.	Бачити якими методами оплати я можу скористатися при оплаті замовлення.
SELECT PaymentType from shop.payment where Allowed = "yes";

-- place orders
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (70,'2021-12-01 00:00:00','Payed','2021-12-01 00:00:00',2,8,31);
INSERT INTO shop.orders (`ID`,`OrderDate`,`TransactStatus`,`PaymentDate`,`shippers_ID`,`payment_ID`,`customers_ID`) VALUES (71,'2021-12-02 00:00:00','Payed','2021-12-02 00:00:00',1,8,18);


-- 7 check order status
SELECT p.*, BillDate, TransactStatus from shop.customers c join shop.orders o on c.ID = o.customers_ID 
join shop.orderdetails od on od.orders_ID=o.ID join shop.products p on p.ID=od.products_ID where customers_ID=2;


-- --
-- ЯК керівник, я хочу..
-- 
-- sort products
-- 1.	Знати усю інформацію про 3 постачальників, від яких у нашому магазині найбільше товарів(їх кількість)
SELECT s.*, count(*) cnt from shop.products p join shop.suppliers s on p.suppliers_ID=s.ID 
group by suppliers_ID order by cnt desc limit 3;

-- 2.	Бачити, усю інформацію про ті товари, яких у наявності залишилось менше 10 шт.
select * from shop.products where Quantity < 10;

-- add\delete category
INSERT INTO `shop`.`category` (`ID`, `CategoryName`, `Description`) VALUES ('9', 'Аксесуари', 'Стильні прикраси');
DELETE FROM `shop`.`category` WHERE (`ID` = '9');

-- add\delete item
INSERT INTO `shop`.`products` (`ID`, `SKU`, `ProductName`, `Quantity`, `AvailableSizes`, `AvailableColours`, `ProductDescription`, `category_ID`, `suppliers_ID`, `Price`) VALUES ('81', 'cп14', 'Костюм', '434', '44', 'Білий', '50% бавовна, 30% віскоза', '7', '1', '500');
DELETE FROM `shop`.`products` WHERE (`ID` = '81');

-- manage item
UPDATE `shop`.`products` SET `AvailableSizes` = '44-48', `AvailableColours` = 'Оливковий, беж', `Price` = '1200' 
WHERE (`ID` = '80');


-- collect/manage order
SELECT * FROM shop.orders;
-- 3.	Бачити якщо замовлення з тих чи інших причин не оплачено номер ід та мобільного, ім’я, прізвище клієнта, який товар замовлено
SELECT c.*, o.TransactStatus, od.Total, p.ProductName from shop.orders o join shop.customers c on o.customers_ID=c.ID 
join shop.orderdetails od on o.ID=od.orders_ID 
join shop.products p on od.products_ID=p.ID  where TransactStatus = "Not payed";

UPDATE `shop`.`orders` SET `TransactStatus` = 'not payed' WHERE (`ID` = '31') and (`payment_ID` = '6');

-- analyze sales statistics
-- 4.	Бачити усю інформацію про те, який варіант доставки найпопулярніший серед клієнтів.
SELECT s.CompanyName, count(*) cnt FROM shop.orders o join shop.shippers s on o.shippers_ID=s.ID 
group by shippers_id order by cnt desc limit 1;

-- 5. 	Знати усю інформацію з якої категорії товари найбільше замовляють і побачити відгуки про товари з цієї категорії.
SELECT c.CategoryName, count(*) cnt, pr.* FROM shop.products p join shop.category c on p.category_ID=c.ID 
join shop.product_review pr on pr.products_ID=p.ID group by category_ID order by cnt desc limit 3;

-- 6.	Бачити назву, контакти постачальників товарів, і назви товарів з найгіршими оцінками
SELECT s.*, p.ProductName, pr.Rating FROM shop.product_review pr join shop.products p on pr.products_ID=p.ID 
join shop.suppliers s on p.suppliers_ID=s.ID order by rating limit 3;

-- 7.	Бачити  к-ть куплених товарів по категоріях.
SELECT c.CategoryName, sum(od.Quantity) as cnt from shop.orderdetails od join shop.products p on od.products_ID=p.ID 
join shop.category c on p.category_ID=c.ID where MONTH(BillDate) = 11 group by category_ID

-- 8.	Знати, скільки загалом виручки надійшло за лист. 2021р.
select sum(Total) from shop.orderdetails where MONTH(BillDate) = 11;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));


