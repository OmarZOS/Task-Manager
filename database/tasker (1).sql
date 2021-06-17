-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mer. 16 juin 2021 à 13:42
-- Version du serveur :  8.0.25-0ubuntu0.20.04.1
-- Version de PHP : 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tasker`
--

-- --------------------------------------------------------

--
-- Structure de la table `chef`
--

CREATE TABLE `chef` (
  `ID_USER` varchar(80) NOT NULL,
  `USE_ID_USER` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `chef`
--

INSERT INTO `chef` (`ID_USER`, `USE_ID_USER`) VALUES
('aliali@gmail.com', 'hind@gmail.com'),
('aliali@gmail.com', 'omaromar@gmail.com'),
('aliali@gmail.com', 'salimsalim@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `commission`
--

CREATE TABLE `commission` (
  `ID_COMMISSION` int NOT NULL,
  `ID_UNITE` int NOT NULL,
  `ID_USER` varchar(80) NOT NULL,
  `LABEL_COMMISSION` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `commission`
--

INSERT INTO `commission` (`ID_COMMISSION`, `ID_UNITE`, `ID_USER`, `LABEL_COMMISSION`) VALUES
(20, 10, 'aliali@gmail.com', 'Sorti_Promo');

-- --------------------------------------------------------

--
-- Structure de la table `direction`
--

CREATE TABLE `direction` (
  `ID_DIRECTON` int NOT NULL,
  `ID_UNITE` int NOT NULL,
  `ID_USER` varchar(80) NOT NULL,
  `LABEL_DIRECTION` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `en_cours`
--

CREATE TABLE `en_cours` (
  `ID_ENCOURS` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `executecom`
--

CREATE TABLE `executecom` (
  `ID_TACHE` int NOT NULL,
  `ID_COMMISSION` int NOT NULL,
  `DEB_EXECUTION` date NOT NULL,
  `FIN_EXECUTION` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `executecom`
--

INSERT INTO `executecom` (`ID_TACHE`, `ID_COMMISSION`, `DEB_EXECUTION`, `FIN_EXECUTION`) VALUES
(30, 20, '2021-05-29', '2021-05-29');

-- --------------------------------------------------------

--
-- Structure de la table `executedir`
--

CREATE TABLE `executedir` (
  `ID_TACHE` int NOT NULL,
  `ID_DIRECTON` int NOT NULL,
  `DEB_EXECUTION` date NOT NULL,
  `FIN_EXECUTION` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `fin`
--

CREATE TABLE `fin` (
  `ID_FIN` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `machine`
--

CREATE TABLE `machine` (
  `ID_MACHINE` int NOT NULL,
  `ID_UNITE` int NOT NULL,
  `LABEL_MACHINE` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `necissitecomm`
--

CREATE TABLE `necissitecomm` (
  `ID_TACHE` int NOT NULL,
  `ID_MACHINE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `necissitecoms`
--

CREATE TABLE `necissitecoms` (
  `ID_TACHE` int NOT NULL,
  `ID_SALLE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `necissitecomu`
--

CREATE TABLE `necissitecomu` (
  `ID_TACHE` int NOT NULL,
  `ID_USER` varchar(80) NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `necissitecomu`
--

INSERT INTO `necissitecomu` (`ID_TACHE`, `ID_USER`, `DATE_DEB`, `PERIODE`) VALUES
(30, 'aliali@gmail.com', '2021-05-30 00:00:00', '30'),
(30, 'omaromar@gmail.com', '2021-05-30 00:00:00', '30'),
(30, 'salimsalim@gmail.com', '2021-05-30 00:00:00', '30');

-- --------------------------------------------------------

--
-- Structure de la table `necissitecomv`
--

CREATE TABLE `necissitecomv` (
  `ID_TACHE` int NOT NULL,
  `ID_VEHICULE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `necissitecomv`
--

INSERT INTO `necissitecomv` (`ID_TACHE`, `ID_VEHICULE`, `DATE_DEB`, `PERIODE`) VALUES
(5, 3, '2010-02-02 00:00:00', '52');

-- --------------------------------------------------------

--
-- Structure de la table `necissitedirm`
--

CREATE TABLE `necissitedirm` (
  `ID_TACHE` int NOT NULL,
  `ID_MACHINE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `necissitedirs`
--

CREATE TABLE `necissitedirs` (
  `ID_TACHE` int NOT NULL,
  `ID_SALLE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `necissitediru`
--

CREATE TABLE `necissitediru` (
  `ID_TACHE` int NOT NULL,
  `ID_USER` varchar(80) NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `necissitediru`
--

INSERT INTO `necissitediru` (`ID_TACHE`, `ID_USER`, `DATE_DEB`, `PERIODE`) VALUES
(6, 'omaromar@gmail.com', '2021-06-15 00:00:00', '2'),
(7, 'hind@gmail.com', '2021-06-15 00:00:00', '2'),
(7, 'omaromar@gmail.com', '2021-06-15 00:00:00', '2'),
(8, 'omaromar@gmail.com', '2021-06-15 00:00:00', '2'),
(9, 'omaromar@gmail.com', '2021-06-15 00:00:00', '2'),
(10, 'omaromar@gmail.com', '2021-06-16 00:00:00', '9');

-- --------------------------------------------------------

--
-- Structure de la table `necissitedirv`
--

CREATE TABLE `necissitedirv` (
  `ID_TACHE` int NOT NULL,
  `ID_VEHICULE` int NOT NULL,
  `DATE_DEB` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `pause`
--

CREATE TABLE `pause` (
  `ID_PAUSE` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

CREATE TABLE `salle` (
  `ID_SALLE` int NOT NULL,
  `ID_UNITE` int NOT NULL,
  `LABEL_SALLE` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tachescom`
--

CREATE TABLE `tachescom` (
  `ID_TACHE` int NOT NULL,
  `ID_ETAT` varchar(20) NOT NULL,
  `LABEL_TACHE` varchar(80) NOT NULL,
  `DESCRIPTION_TACHE` varchar(150) NOT NULL,
  `DATE_DEBETACHE` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tachescom`
--

INSERT INTO `tachescom` (`ID_TACHE`, `ID_ETAT`, `LABEL_TACHE`, `DESCRIPTION_TACHE`, `DATE_DEBETACHE`, `PERIODE`) VALUES
(30, 'encours', 'Entrainer-eleve', 'guider et suivre des eleves', '2021-05-29 00:00:00', '30'),
(31, 'encours', 'gestion_DOCTORAT', 'LESE XAMEN DE DOCTORAT', '2020-05-09 00:00:00', '8');

-- --------------------------------------------------------

--
-- Structure de la table `tachesdir`
--

CREATE TABLE `tachesdir` (
  `ID_TACHE` int NOT NULL,
  `ID_ETAT` varchar(20) NOT NULL,
  `LABEL_TACHE` varchar(80) NOT NULL,
  `DESCRIPTION_TACHE` varchar(150) NOT NULL,
  `DATE_DEBETACHE` datetime DEFAULT NULL,
  `PERIODE` decimal(8,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `tachesdir`
--

INSERT INTO `tachesdir` (`ID_TACHE`, `ID_ETAT`, `LABEL_TACHE`, `DESCRIPTION_TACHE`, `DATE_DEBETACHE`, `PERIODE`) VALUES
(1, 'en_cours', 'aez', '', '2021-06-15 23:17:23', '2'),
(2, 'en_cours', 'cleaning', 'clean desks', '2021-06-15 23:38:07', '2'),
(3, 'en_cours', 'cleaning', 'clean desks', '2021-06-15 23:38:22', '2'),
(4, 'en_cours', 'cleaning', 'clean desks', '2021-06-15 23:39:26', '2'),
(5, 'en_cours', 'e', 'du', '2021-06-15 23:42:27', '2'),
(6, 'en_cours', 'zy', 'gj', '2021-06-15 23:43:01', '2'),
(7, 'en_cours', 'eu', 'ei', '2021-06-15 23:43:20', '2'),
(8, 'en_cours', 'ej', 'vk', '2021-06-15 23:45:02', '2'),
(9, 'en_cours', 'dt', 'ih', '2021-06-15 23:45:50', '2'),
(10, 'en_cours', 'Break the habits', 'do something new', '2021-06-16 11:39:27', '9');

-- --------------------------------------------------------

--
-- Structure de la table `unite`
--

CREATE TABLE `unite` (
  `ID_UNITE` int NOT NULL,
  `LABEL_UNITE` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `unite`
--

INSERT INTO `unite` (`ID_UNITE`, `LABEL_UNITE`) VALUES
(10, 'EMP');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `email` varchar(80) NOT NULL,
  `password` varchar(80) NOT NULL,
  `ID_UNITE` int NOT NULL,
  `NOM` varchar(80) NOT NULL,
  `PRENOM` varchar(80) NOT NULL,
  `DISPONIBILITY` tinyint(1) NOT NULL,
  `SEX` tinyint(1) NOT NULL,
  `DATE_NAISSANCE` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`email`, `password`, `ID_UNITE`, `NOM`, `PRENOM`, `DISPONIBILITY`, `SEX`, `DATE_NAISSANCE`) VALUES
('aliali@gmail.com', 'ali98', 10, 'lamri', 'ali', 0, 0, '1998-02-17'),
('omaromar@gmail.com', 'omar98', 10, 'zaidi', 'omar', 0, 0, '1998-08-08'),
('salimsalim@gmail.com', 'salim98', 10, 'salim', 'salim', 0, 0, '0188-06-17'),
('hind@gmail.com', 'hind98', 10, 'Mircle', 'hind', 0, 1, '1989-08-17'),
('moussamoussa@gmail.com', 'moussa98', 10, 'bousbaa', 'moussa', 0, 0, '1995-03-08');

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

CREATE TABLE `vehicule` (
  `ID_VEHICULE` int NOT NULL,
  `ID_UNITE` int NOT NULL,
  `LABEL_VEHICULE` varchar(50) NOT NULL,
  `Disponib_Vehicule` tinyint(1) NOT NULL DEFAULT '0',
  `id_fk` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `vehicule`
--

INSERT INTO `vehicule` (`ID_VEHICULE`, `ID_UNITE`, `LABEL_VEHICULE`, `Disponib_Vehicule`, `id_fk`) VALUES
(35, 10, 'CADDY', 0, 'aliali@gmail.com'),
(65, 10, 'caddy', 1, 'aliali@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`ID_USER`,`USE_ID_USER`),
  ADD KEY `FK_CHEF` (`USE_ID_USER`);

--
-- Index pour la table `commission`
--
ALTER TABLE `commission`
  ADD PRIMARY KEY (`ID_COMMISSION`),
  ADD KEY `FK_COMPOSE` (`ID_UNITE`),
  ADD KEY `FK_EST_CHEF` (`ID_USER`);

--
-- Index pour la table `direction`
--
ALTER TABLE `direction`
  ADD PRIMARY KEY (`ID_DIRECTON`),
  ADD KEY `FK_COMPOSE2` (`ID_UNITE`),
  ADD KEY `FK_EST_CHEF2` (`ID_USER`);

--
-- Index pour la table `en_cours`
--
ALTER TABLE `en_cours`
  ADD PRIMARY KEY (`ID_ENCOURS`);

--
-- Index pour la table `executecom`
--
ALTER TABLE `executecom`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_COMMISSION`),
  ADD KEY `FK_CHEF` (`ID_COMMISSION`);

--
-- Index pour la table `executedir`
--
ALTER TABLE `executedir`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_DIRECTON`),
  ADD KEY `FK_CHEF` (`ID_DIRECTON`);

--
-- Index pour la table `fin`
--
ALTER TABLE `fin`
  ADD PRIMARY KEY (`ID_FIN`);

--
-- Index pour la table `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`ID_MACHINE`),
  ADD KEY `FK_CONTIENT2` (`ID_UNITE`);

--
-- Index pour la table `necissitecomm`
--
ALTER TABLE `necissitecomm`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_MACHINE`),
  ADD KEY `FK_NECISSITE2` (`ID_MACHINE`);

--
-- Index pour la table `necissitecoms`
--
ALTER TABLE `necissitecoms`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_SALLE`),
  ADD KEY `FK_NECISSITE2` (`ID_SALLE`);

--
-- Index pour la table `necissitecomu`
--
ALTER TABLE `necissitecomu`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_USER`),
  ADD KEY `FK_NECISSITE2` (`ID_USER`);

--
-- Index pour la table `necissitecomv`
--
ALTER TABLE `necissitecomv`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_VEHICULE`),
  ADD KEY `FK_NECISSITE2` (`ID_VEHICULE`);

--
-- Index pour la table `necissitedirm`
--
ALTER TABLE `necissitedirm`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_MACHINE`),
  ADD KEY `FK_NECISSITE2` (`ID_MACHINE`);

--
-- Index pour la table `necissitedirs`
--
ALTER TABLE `necissitedirs`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_SALLE`),
  ADD KEY `FK_NECISSITE2` (`ID_SALLE`);

--
-- Index pour la table `necissitediru`
--
ALTER TABLE `necissitediru`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_USER`),
  ADD KEY `FK_NECISSITE2` (`ID_USER`);

--
-- Index pour la table `necissitedirv`
--
ALTER TABLE `necissitedirv`
  ADD PRIMARY KEY (`ID_TACHE`,`ID_VEHICULE`),
  ADD KEY `FK_NECISSITE2` (`ID_VEHICULE`);

--
-- Index pour la table `pause`
--
ALTER TABLE `pause`
  ADD PRIMARY KEY (`ID_PAUSE`);

--
-- Index pour la table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`ID_SALLE`);

--
-- Index pour la table `tachescom`
--
ALTER TABLE `tachescom`
  ADD PRIMARY KEY (`ID_TACHE`);

--
-- Index pour la table `tachesdir`
--
ALTER TABLE `tachesdir`
  ADD PRIMARY KEY (`ID_TACHE`);

--
-- Index pour la table `unite`
--
ALTER TABLE `unite`
  ADD PRIMARY KEY (`ID_UNITE`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`email`),
  ADD KEY `FK_CONTIENT` (`ID_UNITE`);

--
-- Index pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD PRIMARY KEY (`ID_VEHICULE`),
  ADD KEY `FK_CONTIENT3` (`ID_UNITE`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commission`
--
ALTER TABLE `commission`
  MODIFY `ID_COMMISSION` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `direction`
--
ALTER TABLE `direction`
  MODIFY `ID_DIRECTON` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `en_cours`
--
ALTER TABLE `en_cours`
  MODIFY `ID_ENCOURS` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fin`
--
ALTER TABLE `fin`
  MODIFY `ID_FIN` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `machine`
--
ALTER TABLE `machine`
  MODIFY `ID_MACHINE` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pause`
--
ALTER TABLE `pause`
  MODIFY `ID_PAUSE` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `salle`
--
ALTER TABLE `salle`
  MODIFY `ID_SALLE` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tachescom`
--
ALTER TABLE `tachescom`
  MODIFY `ID_TACHE` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `tachesdir`
--
ALTER TABLE `tachesdir`
  MODIFY `ID_TACHE` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `unite`
--
ALTER TABLE `unite`
  MODIFY `ID_UNITE` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `vehicule`
--
ALTER TABLE `vehicule`
  MODIFY `ID_VEHICULE` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
