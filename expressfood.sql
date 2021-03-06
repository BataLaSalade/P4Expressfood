-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le :  lun. 28 mai 2018 à 15:19
-- Version du serveur :  10.2.8-MariaDB
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
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `label`) VALUES
(1, 'plat'),
(2, 'dessert');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Utilisateur_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `statutPaiement` tinyint(4) NOT NULL,
  `statutLivraison` tinyint(4) NOT NULL,
  `adresseDefaut` tinyint(4) NOT NULL DEFAULT 1,
  `numVoie` int(11) DEFAULT NULL,
  `voie` varchar(255) DEFAULT NULL,
  `complementAdresse` varchar(255) DEFAULT NULL,
  `codePostal` varchar(5) DEFAULT NULL,
  `ville` varchar(70) DEFAULT NULL,
  `datePriseEnCharge` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`Utilisateur_id`),
  KEY `fk_Commande_Utilisateur1_idx` (`Utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `Utilisateur_id`, `date`, `statutPaiement`, `statutLivraison`, `adresseDefaut`, `numVoie`, `voie`, `complementAdresse`, `codePostal`, `ville`, `datePriseEnCharge`) VALUES
(1, 5, '2018-05-23 12:24:12', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '0000-00-00 00:00:00'),
(2, 1, '2018-05-23 12:25:12', 0, 0, 1, NULL, NULL, NULL, NULL, NULL, '0000-00-00 00:00:00'),
(3, 6, '2018-05-23 12:26:12', 1, 0, 0, 3, 'rue de ma ville', NULL, '13013', 'Marseille', '0000-00-00 00:00:00'),
(4, 6, '2018-05-23 12:28:12', 1, 0, 1, NULL, NULL, NULL, NULL, NULL, '0000-00-00 00:00:00'),
(5, 1, '2018-05-28 13:13:38', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, '2018-05-23 12:32:05'),
(6, 7, '2018-05-28 13:14:24', 1, 2, 0, 113, 'chemin de la pinède bleue', 'en bas à droite', '13013', 'Marseille', '2018-05-23 12:28:15');

-- --------------------------------------------------------

--
-- Structure de la table `détail_commande`
--

DROP TABLE IF EXISTS `détail_commande`;
CREATE TABLE IF NOT EXISTS `détail_commande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantité` int(11) NOT NULL DEFAULT 1,
  `produitsDuJour_id` int(11) NOT NULL,
  `Commande_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`produitsDuJour_id`,`Commande_id`),
  KEY `fk_Détail_Commande_Commande1_idx` (`Commande_id`),
  KEY `fk_Détail_Commande_produitsDuJour1_idx` (`produitsDuJour_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `détail_commande`
--

INSERT INTO `détail_commande` (`id`, `quantité`, `produitsDuJour_id`, `Commande_id`) VALUES
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 2, 3, 2),
(4, 2, 2, 2),
(5, 1, 5, 3),
(6, 1, 7, 3),
(7, 1, 6, 4),
(8, 1, 7, 4),
(9, 2, 8, 4),
(10, 2, 5, 4),
(11, 2, 6, 5),
(12, 2, 8, 5),
(13, 5, 1, 6),
(14, 5, 7, 6);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Categorie_id` int(11) NOT NULL,
  `dateCreation` date NOT NULL,
  `dateModif` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nom` varchar(70) NOT NULL,
  `description` longtext NOT NULL,
  `prixUnitaireHT` decimal(3,2) NOT NULL,
  PRIMARY KEY (`id`,`Categorie_id`),
  KEY `fk_Produit_Categorie1_idx` (`Categorie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `Categorie_id`, `dateCreation`, `dateModif`, `nom`, `description`, `prixUnitaireHT`) VALUES
(1, 2, '2018-05-24', '2018-05-28 10:11:04', 'Salade de fruits frais', 'Salade avec fruit frais de saison : pomme, poire, fraise et pamplemousse', '3.10'),
(2, 2, '2018-05-24', '2018-05-28 10:12:20', 'Dessert marbré', 'Dessert marbré, citron et framboise', '3.10'),
(3, 1, '2018-05-24', '2018-05-28 10:12:20', 'Salade du soleil', 'Salade de pâtes composées de pâtes, poulet, courguettes, tomates cerises et confites basilic', '6.70'),
(4, 1, '2018-05-24', '2018-05-28 10:12:20', 'Salade poulet verde', 'Salade de poulet dont tous les accompagnements sont vert : fèves, petit-pois, avocat, crème de roquette', '6.70'),
(5, 2, '2018-05-25', '2018-05-28 10:15:07', 'Fromage blanc', 'Fromage blanc du producteur du coin avec coulis au choix : crème de marron ou fruit rouge', '3.10'),
(6, 2, '2018-05-25', '2018-05-28 10:15:07', 'Verrine grecque', 'Verrine aux abricots, muesli, yahourt grec', '3.10'),
(7, 1, '2018-05-25', '2018-05-28 10:15:07', 'Salade Thaï', 'Salade thaï avec crevettes, carottes, courgette, nouilles, coriande et sésame', '6.70'),
(8, 1, '2018-05-25', '2018-05-28 10:15:07', 'Wrap mexicain', 'Wrap, poulet, guacamole, salade iceberg, oignon rouge et tomate', '6.70'),
(9, 2, '2018-05-26', '2018-05-28 10:15:07', 'Tarte coco', 'Tarte à la noix de coco  avec son coulis de chocolat intense', '3.10'),
(10, 2, '2018-05-26', '2018-05-28 10:15:07', 'Tarte chocolat', 'Délicieuse tarte au chocolat, surmontée d\'un crumble croquant', '3.10'),
(11, 1, '2018-05-26', '2018-05-28 10:15:07', 'Sandwich méditerranéen', 'Jambon cru, tapenade, tomates, fêta dans pain de tradition', '6.70'),
(12, 1, '2018-05-26', '2018-05-28 10:15:07', 'La Pesto', 'Salade de ravioli au fromage, sauce pesto, tomate séchée, pignons et parmesan', '6.70');

-- --------------------------------------------------------

--
-- Structure de la table `produitsdujour`
--

DROP TABLE IF EXISTS `produitsdujour`;
CREATE TABLE IF NOT EXISTS `produitsdujour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Produit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`Produit_id`),
  KEY `fk_platsDuJour_Produit1_idx` (`Produit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produitsdujour`
--

INSERT INTO `produitsdujour` (`id`, `date`, `Produit_id`) VALUES
(1, '2018-05-27 22:00:00', 1),
(2, '2018-05-27 22:00:00', 2),
(3, '2018-05-27 22:00:00', 3),
(4, '2018-05-27 22:00:00', 4),
(5, '2018-05-28 22:00:00', 5),
(6, '2018-05-28 22:00:00', 6),
(7, '2018-05-28 22:00:00', 7),
(8, '2018-05-28 22:00:00', 8),
(9, '2018-05-29 22:00:00', 9),
(10, '2018-05-29 22:00:00', 10),
(11, '2018-05-29 22:00:00', 11),
(12, '2018-05-29 22:00:00', 12),
(13, '2018-05-30 22:00:00', 9),
(14, '2018-05-30 22:00:00', 1),
(15, '2018-05-30 22:00:00', 7),
(16, '2018-05-30 22:00:00', 4);

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
  `telephone` varchar(10) DEFAULT NULL,
  `numVoie` int(11) DEFAULT NULL,
  `voie` varchar(255) DEFAULT NULL,
  `complementAdresse` varchar(255) DEFAULT NULL,
  `codePostal` varchar(5) DEFAULT NULL,
  `ville` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `prenom`, `nom`, `mail`, `login`, `mdp`, `longitude`, `latitude`, `isAdmin`, `isLivreur`, `statutLivreur`, `isClient`, `telephone`, `numVoie`, `voie`, `complementAdresse`, `codePostal`, `ville`) VALUES
(1, 'Antoine', 'Lagale', 'antoine-lagale@monmail.fr', 'Lagale', '125gtrz!#é157', '72.123456', '2.123456', 0, 0, 0, 1, '0608123789', 12, 'Chemin de chez moi', NULL, '13013', 'Marseille'),
(2, 'Marie-jo', 'Dorin', 'mariejd@mail.fr', 'Marie-Admin', '123fred321', '32.123456', '26.123456', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'John', 'Doe', 'johndoe@gmail.com', 'Livreur-John', '147ferg741', '31.123456', '22.745612', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Jane', 'Doe', 'janninedoe@gmail.com', 'Livreur-cacahuete72', '72petitchat568', '35.123456', '62.745612', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Regine', 'Mariani', 'reginemariani@monmail.fr', 'Reginette', '1524ghjdbnze!7', '72.123457', '2.123457', 0, 0, 0, 1, '060154697', 56, 'Chemin de chez elle', 'appartement B12', '13013', 'Marseille'),
(6, 'Molly', 'Diego', 'molinette25@monmail.fr', 'Molinette', '125gtrz!#é157', '72.123457', '2.123457', 0, 0, 0, 1, '0608123789', 12, 'Chemin de chez moi', NULL, '13013', 'Marseille'),
(7, 'Sancho', 'Decuba', 'sancho@monmail.fr', 'CmoiSancho', '123aze654', '72.123457', '2.123457', 0, 0, 0, 1, '0721568984', 612, 'route du chateau de ma mère', 'au fin fond de la garigue', '13013', 'Marseille');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Utilisateur1` FOREIGN KEY (`Utilisateur_id`) REFERENCES `utilisateur` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `détail_commande`
--
ALTER TABLE `détail_commande`
  ADD CONSTRAINT `fk_Détail_Commande_Commande1` FOREIGN KEY (`Commande_id`) REFERENCES `commande` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Détail_Commande_platsDuJour1` FOREIGN KEY (`produitsDuJour_id`) REFERENCES `produitsdujour` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `fk_Produit_Categorie1` FOREIGN KEY (`Categorie_id`) REFERENCES `categorie` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `produitsdujour`
--
ALTER TABLE `produitsdujour`
  ADD CONSTRAINT `fk_platsDuJour_Produit1` FOREIGN KEY (`Produit_id`) REFERENCES `produit` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
