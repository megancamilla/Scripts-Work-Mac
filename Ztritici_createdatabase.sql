SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `Ztritici_resequencing` ;
CREATE SCHEMA IF NOT EXISTS `Ztritici_resequencing` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `Ztritici_resequencing` ;

-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`IPO323`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`IPO323` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`IPO323` (
  `ID_Primary` INT NOT NULL AUTO_INCREMENT,
  `Sample_ID` VARCHAR(45) NOT NULL,
  `Alternate_name` VARCHAR(45) NULL,
  `Year_Sampled` INT NULL,
  `Location_Sampled` VARCHAR(45) NULL,
  `Sampled_by` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_Primary`, `Sample_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012` (
  `Assembly_id` VARCHAR(45) NOT NULL,
  `Sample_id` VARCHAR(45) NULL,
  `DateDownloaded` DATE NULL,
  `Weblink` VARCHAR(45) NULL,
  PRIMARY KEY (`Assembly_id`),
  INDEX `fk_Sample_id_idx` (`Sample_id` ASC),
  CONSTRAINT `fk_Sample_id`
    FOREIGN KEY (`Sample_id`)
    REFERENCES `Ztritici_resequencing`.`IPO323` (`Sample_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`Chromosomes_IPO323`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`Chromosomes_IPO323` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`Chromosomes_IPO323` (
  `ChromosomeNumber_id` VARCHAR(24) NOT NULL,
  `assembly_id` VARCHAR(45) NULL,
  `Masked Sequence` LONGTEXT NULL,
  INDEX `Reference_assebly_downloadedAug2013_idx` (`assembly_id` ASC),
  PRIMARY KEY (`ChromosomeNumber_id`),
  CONSTRAINT `fk_assembly_id`
    FOREIGN KEY (`assembly_id`)
    REFERENCES `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012` (`Assembly_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`Genes_IPO323`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`Genes_IPO323` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`Genes_IPO323` (
  `assembly_id` VARCHAR(45) NOT NULL,
  `Gene_ID_numeric` INT NOT NULL,
  `Gene_ID_name` VARCHAR(45) NOT NULL,
  `DNAseq` VARCHAR(45) NULL,
  `ProteinSeq` MEDIUMTEXT NULL,
  PRIMARY KEY (`Gene_ID_numeric`),
  INDEX `Reference_assembly_Aug2102_idx` (`assembly_id` ASC),
  UNIQUE INDEX `Prediction_ID_UNIQUE` (`Gene_ID_name` ASC),
  CONSTRAINT `fk_assembly_id`
    FOREIGN KEY (`assembly_id`)
    REFERENCES `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012` (`Assembly_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`GeneFeatures_IPO323`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`GeneFeatures_IPO323` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`GeneFeatures_IPO323` (
  `Assembly_id` VARCHAR(45) NOT NULL,
  `Gene_ID_name` VARCHAR(65) NOT NULL,
  `Gene_feature_id` VARCHAR(25) NOT NULL,
  `Gene_feature_description` VARCHAR(45) NULL,
  `ChromosomeNum` VARCHAR(24) NOT NULL,
  `StartPos` VARCHAR(25) NULL,
  `StopPos` VARCHAR(25) NULL,
  `Strand` VARCHAR(5) NULL,
  `Coding_frame` INT NULL,
  `Source` VARCHAR(45) NULL,
  INDEX `Reference_assembly_Aug2012_idx` (`Assembly_id` ASC),
  PRIMARY KEY (`Gene_feature_id`),
  INDEX `fk_gene_name_idx` (`Gene_ID_name` ASC),
  INDEX `fk_chromosome_num_idx` (`ChromosomeNum` ASC),
  CONSTRAINT `Reference_assembly_Aug2012`
    FOREIGN KEY (`Assembly_id`)
    REFERENCES `Ztritici_resequencing`.`Reference_assembly_downloadedAug2012` (`Assembly_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_gene_name`
    FOREIGN KEY (`Gene_ID_name`)
    REFERENCES `Ztritici_resequencing`.`Genes_IPO323` (`Gene_ID_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_chromosome_num`
    FOREIGN KEY (`ChromosomeNum`)
    REFERENCES `Ztritici_resequencing`.`Chromosomes_IPO323` (`ChromosomeNumber_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`WAI320`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`WAI320` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`WAI320` (
  `isolate_id` VARCHAR(30) NOT NULL,
  `SingleSporeSource` VARCHAR(45) NULL,
  `AlternateName` VARCHAR(45) NULL,
  `Collection Location` VARCHAR(45) NULL,
  `CollectionDate` VARCHAR(45) NULL,
  `ColectionCode_AndrewMilgate` VARCHAR(45) NULL,
  `GPS` VARCHAR(45) NULL,
  `Host` VARCHAR(45) NULL,
  `Variety` VARCHAR(45) NULL,
  PRIMARY KEY (`isolate_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`WAI320_GATK_trial_VCF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`WAI320_GATK_trial_VCF` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`WAI320_GATK_trial_VCF` (
  `isolate_id` VARCHAR(45) NULL,
  `Analysis_id` VARCHAR(45) NOT NULL,
  `Analysis_name` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NULL,
  `Command_executed` MEDIUMBLOB NULL,
  `ReferenceUsed` VARCHAR(45) NULL,
  INDEX `Isolate_id_idx` (`isolate_id` ASC),
  PRIMARY KEY (`Analysis_id`),
  CONSTRAINT `fk_idolate_id`
    FOREIGN KEY (`isolate_id`)
    REFERENCES `Ztritici_resequencing`.`WAI320` (`isolate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`WAI320_GATK_trial_VCF_results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`WAI320_GATK_trial_VCF_results` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`WAI320_GATK_trial_VCF_results` (
  `analysis_id` VARCHAR(45) NULL,
  `Gene_ID_numeric` INT NULL,
  `Variant_id` INT NOT NULL,
  `Chromosome` VARCHAR(45) NULL,
  `Ref_Position` INT NULL,
  `Reference_Base` VARCHAR(45) NULL,
  `Alternate_Base` VARCHAR(45) NULL,
  `Isolate_allele` INT NULL COMMENT '0 Matches Reference\n1 Alternate Allele\n.  Allele not called due to missing information\n',
  `GATK_score` FLOAT NULL,
  `LowQualityFlag` VARCHAR(45) NULL,
  `Effect` TINYTEXT NULL,
  `Effect_impact` TINYTEXT NULL,
  `Functional_class` INT(11) NULL,
  `Codon_change` VARCHAR(45) NULL COMMENT 'Codon change: old_codon/new_codon OR distance to transcript in upstream/downstream\n',
  `Amino_Acid_change` VARCHAR(45) NULL COMMENT 'Amino acid change: old_ AA AA_position/new_AAa (e.g. \"E356K\")',
  `Amino_Acid_length` VARCHAR(45) NULL,
  `Gene_name` VARCHAR(45) NULL,
  `Gene_Coding` VARCHAR(45) NULL,
  `Transcript` VARCHAR(45) NULL,
  `Allele_number` VARCHAR(45) NULL COMMENT 'Genotype number corresponding to this effect (e.g. 2 if the effect corresponds to the second ALT allele with a different effect from ALT allele 1)\n',
  PRIMARY KEY (`Variant_id`),
  INDEX `GATK_trial_VCF_idx` (`analysis_id` ASC),
  INDEX `fk_transcript_id_idx` (`Gene_ID_numeric` ASC),
  CONSTRAINT `Analysis`
    FOREIGN KEY (`analysis_id`)
    REFERENCES `Ztritici_resequencing`.`WAI320_GATK_trial_VCF` (`Analysis_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transcript_id`
    FOREIGN KEY (`Gene_ID_numeric`)
    REFERENCES `Ztritici_resequencing`.`Genes_IPO323` (`Gene_ID_numeric`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`WAI320_MissingExon_analysis_Aug2013`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`WAI320_MissingExon_analysis_Aug2013` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`WAI320_MissingExon_analysis_Aug2013` (
  `Isolate_id` VARCHAR(45) NULL,
  `Analysis_id` INT NOT NULL AUTO_INCREMENT,
  `Analysis_name` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NULL,
  `Command` VARCHAR(45) NULL,
  PRIMARY KEY (`Analysis_id`),
  UNIQUE INDEX `Sample_id_idx` (`Isolate_id` ASC),
  CONSTRAINT `fk_isolate_id`
    FOREIGN KEY (`Isolate_id`)
    REFERENCES `Ztritici_resequencing`.`WAI320` (`isolate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`WAI320_Phenotype_Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`WAI320_Phenotype_Table` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`WAI320_Phenotype_Table` (
  `Id_Phenotype` INT NOT NULL AUTO_INCREMENT,
  `Cultivar` VARCHAR(45) NOT NULL,
  `Isolate_id` VARCHAR(45) NULL,
  `Reaction` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Phenotype`, `Cultivar`),
  INDEX `fk_isolate_id_idx` (`Isolate_id` ASC),
  CONSTRAINT `fk_isolate_id`
    FOREIGN KEY (`Isolate_id`)
    REFERENCES `Ztritici_resequencing`.`WAI320` (`isolate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ztritici_resequencing`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ztritici_resequencing`.`user` ;

CREATE TABLE IF NOT EXISTS `Ztritici_resequencing`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);

SET SQL_MODE = '';
GRANT USAGE ON *.* TO meganm;
 DROP USER meganm;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'meganm' IDENTIFIED BY 'pnodoruma27';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
