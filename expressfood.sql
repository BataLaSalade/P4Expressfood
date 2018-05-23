-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 23 mai 2018 à 13:46
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
  `Utilisateur_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `statutPaiement` tinyint(4) NOT NULL, -- boolean : si faux (0) retourne notification ex. "paiement refusé", si vrai (1) retourne notification ex. "paiement accepté"
  `statutLivraison` tinyint(4) NOT NULL, -- 3 états : (0) = enregistrée, (1) = en cours de livraison, (2) = livrée
  `timerLivraison` int(11) NOT NULL DEFAULT '20', -- estimation du temps de livraison, compteur de 20min à 0
  `adresseDefaut` tinyint(4) NOT NULL DEFAULT '1', -- boolean : si faux (0) remplir les attributs suivants, si vrai (1) = valeur par défaut = utiliser les informations du compte utilisateur correspondant
  `numVoie` int(11) DEFAULT NULL,
  `voie` varchar(255) DEFAULT NULL,
  `complementAdresse` varchar(255) DEFAULT NULL,
  `codePostal` varchar(5) DEFAULT NULL,
  `ville` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`,`Utilisateur_id`),
  KEY `fk_Commande_Utilisateur1_idx` (`Utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `Utilisateur_id`, `date`, `statutPaiement`, `statutLivraison`, `timerLivraison`, `adresseDefaut`, `numVoie`, `voie`, `complementAdresse`, `codePostal`, `ville`) VALUES
(1, 21, '2018-05-23 14:24:12', 0, 0, 20, 0, NULL, NULL, NULL, NULL, NULL),
(2, 17, '2018-05-23 14:25:12', 0, 0, 20, 1, NULL, NULL, NULL, NULL, NULL),
(3, 22, '2018-05-23 14:26:12', 1, 0, 20, 0, 3, 'rue de ma ville', NULL, '13013', 'Marseille'),
(4, 23, '2018-05-23 14:28:12', 1, 0, 20, 1, NULL, NULL, NULL, NULL, NULL),
(5, 21, '2018-05-23 14:28:12', 1, 1, 20, 1, NULL, NULL, NULL, NULL, NULL),
(6, 17, '2018-05-23 14:25:12', 1, 2, 20, 0, 113, 'chemin de la pinède bleue', 'en bas à droite', '13013', 'Marseille');

-- --------------------------------------------------------

--
-- Structure de la table `commande_dessert`
--
-- Table de liaison "commandes contient desserts"
--

DROP TABLE IF EXISTS `commande_dessert`;
CREATE TABLE IF NOT EXISTS `commande_dessert` (
  `Commande_id` int(11) NOT NULL,
  `Dessert_id` int(11) NOT NULL,
  PRIMARY KEY (`Commande_id`,`Dessert_id`),
  KEY `fk_Commande_has_Dessert_Dessert1_idx` (`Dessert_id`),
  KEY `fk_Commande_has_Dessert_Commande1_idx` (`Commande_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande_dessert`
--

INSERT INTO `commande_dessert` (`Commande_id`, `Dessert_id`) VALUES
(1, 1),
(2, 1),
(4, 1),
(5, 1),
(1, 2),
(3, 2),
(4, 2),
(6, 2);

-- --------------------------------------------------------

--
-- Structure de la table `commande_plat`
--
-- Table de liaison "commandes contient plats"
--

DROP TABLE IF EXISTS `commande_plat`;
CREATE TABLE IF NOT EXISTS `commande_plat` (
  `Commande_id` int(11) NOT NULL,
  `Plat_id` int(11) NOT NULL,
  PRIMARY KEY (`Commande_id`,`Plat_id`),
  KEY `fk_Commande_has_Plat_Plat1_idx` (`Plat_id`),
  KEY `fk_Commande_has_Plat_Commande_idx` (`Commande_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande_plat`
--

INSERT INTO `commande_plat` (`Commande_id`, `Plat_id`) VALUES
(1, 1),
(3, 1),
(4, 1),
(6, 1),
(1, 2),
(2, 2),
(4, 2),
(5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `dessert`
--

DROP TABLE IF EXISTS `dessert`;
CREATE TABLE IF NOT EXISTS `dessert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dailyMenu` date NOT NULL, -- correspond à la date à laquelle le menu doit être publié
  `onLine` tinyint(4) NOT NULL, -- boolean : faux (0) = non publié, vrai (1) = publié quand on est a la date "dailyMenu"
  `nom` varchar(70) NOT NULL,
  `description` longtext NOT NULL,
  `quantite` int(11) NOT NULL DEFAULT '1',
  `prixUnitaireHT` decimal(3,2) NOT NULL,
  `tauxTVA100` decimal(3,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `dessert`
--

INSERT INTO `dessert` (`id`, `dailyMenu`, `onLine`, `nom`, `description`, `quantite`, `prixUnitaireHT`, `tauxTVA100`) VALUES
(1, '2018-05-24', 1, 'Salade de fruits frais', 'Salade avec fruit frais de saison : pomme, poire, fraise et pamplemousse', 1, '3.10', '10.0'),
(2, '2018-05-24', 1, 'Dessert marbré', 'Dessert marbré, citron et framboise', 1, '3.10', '10.0'),
(3, '2018-05-25', 0, 'Fromage blanc', 'Fromage blanc du producteur du coin avec coulis au choix : crème de marron ou fruit rouge', 1, '3.10', '10.0'),
(4, '2018-05-25', 0, 'Verrine grecque', 'Verrine aux abricots, muesli, yahourt grec', 1, '3.10', '10.0'),
(5, '2018-05-26', 0, 'Tarte coco', 'Tarte à la noix de coco  avec son coulis de chocolat intense', 1, '3.10', '10.0'),
(6, '2018-05-26', 0, 'Tarte chocolat', "Délicieuse tarte au chocolat, surmontée d'un crumble croquant", 1, '3.10', '10.0');

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
  `quantite` int(11) NOT NULL DEFAULT '1',
  `prixUnitaireHT` decimal(3,2) NOT NULL,
  `tauxTVA100` decimal(3,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`id`, `dailyMenu`, `onLine`, `nom`, `description`, `quantite`, `prixUnitaireHT`, `tauxTVA100`) VALUES
(1, '2018-05-24', 1, 'Salade du soleil', 'Salade de pâtes composées de pâtes, poulet, courguettes, tomates cerises et confites basilic', 1, '6.70', '10.0'),
(2, '2018-05-24', 1, 'Salade poulet verde', 'Salade de poulet dont tous les accompagnements sont vert : fèves, petit-pois, avocat, crème de roquette', 1, '6.70', '10.0'),
(3, '2018-05-25', 0, 'Salade Thaï', 'Salade thaï avec crevettes, carottes, courgette, nouilles, coriande et sésame', 1, '6.70', '10.0'),
(4, '2018-05-25', 0, 'Wrap mexicain', 'Wrap, poulet, guacamole, salade iceberg, oignon rouge et tomate', 1, '6.70', '10.0'),
(5, '2018-05-26', 0, 'Sandwich méditerranéen', 'Jambon cru, tapenade, tomates, fêta dans pain de tradition', 1, '6.70', '10.0'),
(6, '2018-05-26', 0, 'La Pesto', 'Salade de ravioli au fromage, sauce pesto, tomate séchée, pignons et parmesan', 1, '6.70', '10.0');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `prenom`, `nom`, `mail`, `login`, `mdp`, `longitude`, `latitude`, `isAdmin`, `isLivreur`, `statutLivreur`, `isClient`, `telephone`, `numVoie`, `voie`, `complementAdresse`, `codePostal`, `ville`) VALUES
(17, 'Antoine', 'Lagale', 'antoine-lagale@monmail.fr', 'Lagale', '125gtrz!#é157', '72.123456', '2.123456', 0, 0, 0, 1, '0608123789', 12, 'Chemin de chez moi', NULL, '13013', 'Marseille'),
(18, 'Marie-jo', 'Dorin', 'mariejd@mail.fr', 'Marie-Admin', '123fred321', '32.123456', '26.123456', 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'John', 'Doe', 'johndoe@gmail.com', 'Livreur-John', '147ferg741', '31.123456', '22.745612', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Jane', 'Doe', 'janninedoe@gmail.com', 'Livreur-cacahuete72', '72petitchat568', '35.123456', '62.745612', 0, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'Regine', 'Mariani', 'reginemariani@monmail.fr', 'Reginette', '1524ghjdbnze!7', '72.123457', '2.123457', 0, 0, 0, 1, '060154697', 56, 'Chemin de chez elle', 'appartement B12', '13013', 'Marseille'),
(22, 'Molly', 'Diego', 'molinette25@monmail.fr', 'Molinette', '125gtrz!#é157', '72.123457', '2.123457', 0, 0, 0, 1, '0608123789', 12, 'Chemin de chez moi', NULL, '13013', 'Marseille'),
(23, 'Sancho', 'Decuba', 'sancho@monmail.fr', 'CmoiSancho', '123aze654', '72.123457', '2.123457', 0, 0, 0, 1, '0721568984', 612, 'route du chateau de ma mère', 'au fin fond de la garigue', '13013', 'Marseille');

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
