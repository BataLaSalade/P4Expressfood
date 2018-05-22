-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mar. 22 mai 2018 à 16:09
-- Version du serveur :  5.7.19
-- Version de PHP :  7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `expressfood`
--

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `statutPaiement` tinyint(4) NOT NULL,
  `statutLivraison` tinyint(4) NOT NULL,
  `timerLivraison` int(11) NOT NULL DEFAULT '20',
  `adresseDefaut` tinyint(4) NOT NULL DEFAULT '1',
  `numVoie` int(11) NOT NULL,
  `voie` varchar(255) NOT NULL,
  `complementAdresse` varchar(255) NOT NULL,
  `codePostal` varchar(5) NOT NULL,
  `ville` varchar(70) NOT NULL,
  `Utilisateur_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`Utilisateur_id`),
  KEY `fk_Commande_Utilisateur1_idx` (`Utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commande_dessert`
--

DROP TABLE IF EXISTS `commande_dessert`;
CREATE TABLE IF NOT EXISTS `commande_dessert` (
  `Commande_id` int(11) NOT NULL,
  `Dessert_id` int(11) NOT NULL,
  PRIMARY KEY (`Commande_id`,`Dessert_id`),
  KEY `fk_Commande_has_Dessert_Dessert1_idx` (`Dessert_id`),
  KEY `fk_Commande_has_Dessert_Commande1_idx` (`Commande_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commande_plat`
--

DROP TABLE IF EXISTS `commande_plat`;
CREATE TABLE IF NOT EXISTS `commande_plat` (
  `Commande_id` int(11) NOT NULL,
  `Plat_id` int(11) NOT NULL,
  PRIMARY KEY (`Commande_id`,`Plat_id`),
  KEY `fk_Commande_has_Plat_Plat1_idx` (`Plat_id`),
  KEY `fk_Commande_has_Plat_Commande_idx` (`Commande_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `dessert`
--

DROP TABLE IF EXISTS `dessert`;
CREATE TABLE IF NOT EXISTS `dessert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dailyMenu` date NOT NULL,
  `onLine` tinyint(4) NOT NULL,
  `nom` varchar(70) NOT NULL,
  `description` longtext NOT NULL,
  `quantite` int(11) NOT NULL,
  `prixUnitaireHT` decimal(3,2) NOT NULL,
  `tauxTVA100` decimal(3,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dailyMenu` date NOT NULL,
  `onLine` tinyint(4) NOT NULL,
  `nom` varchar(70) NOT NULL,
  `description` longtext NOT NULL,
  `quantite` int(11) NOT NULL,
  `prixUnitaireHT` decimal(3,2) NOT NULL,
  `tauxTVA100` decimal(3,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(45) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `mail` varchar(70) NOT NULL,
  `login` varchar(70) NOT NULL,
  `mdp` varchar(70) NOT NULL,
  `longitude` decimal(9,6) NOT NULL,
  `latitude` decimal(8,6) NOT NULL,
  `isAdmin` tinyint(4) NOT NULL,
  `isLivreur` tinyint(4) NOT NULL,
  `statutLivreur` tinyint(4) NOT NULL,
  `isClient` tinyint(4) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `numVoie` int(11) NOT NULL,
  `voie` varchar(255) NOT NULL,
  `complementAdresse` varchar(255) NOT NULL,
  `codePostal` varchar(5) NOT NULL,
  `ville` varchar(70) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Utilisateur1` FOREIGN KEY (`Utilisateur_id`) REFERENCES `utilisateur` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commande_dessert`
--
ALTER TABLE `commande_dessert`
  ADD CONSTRAINT `fk_Commande_has_Dessert_Commande1` FOREIGN KEY (`Commande_id`) REFERENCES `commande` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Commande_has_Dessert_Dessert1` FOREIGN KEY (`Dessert_id`) REFERENCES `dessert` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `commande_plat`
--
ALTER TABLE `commande_plat`
  ADD CONSTRAINT `fk_Commande_has_Plat_Commande` FOREIGN KEY (`Commande_id`) REFERENCES `commande` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Commande_has_Plat_Plat1` FOREIGN KEY (`Plat_id`) REFERENCES `plat` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
