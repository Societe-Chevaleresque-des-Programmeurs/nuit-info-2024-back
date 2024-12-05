-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 05 déc. 2024 à 21:10
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `dbn24`
--

DELIMITER $$
--
-- Fonctions
--
DROP FUNCTION IF EXISTS `getRightAnswers`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getRightAnswers` (`login` VARCHAR(255)) RETURNS INT(11) BEGIN
	DECLARE sumR INT ; 
    SELECT COUNT(*) from Users u 
    inner join users_answers ua on u.login = ua.login
    inner join answers on a.idAnswer = u.idAnswer
    where a.rightAnswer = true
    into sumR;
    return sumR;
END$$

DROP FUNCTION IF EXISTS `getWrongAnswers`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getWrongAnswers` (`login` VARCHAR(255)) RETURNS INT(11) BEGIN
	DECLARE sumR INT ; 
    SELECT COUNT(*) from Users u 
    inner join users_answers ua on u.login = ua.login
    inner join answers on a.idAnswer = u.idAnswer
    where a.rightAnswer = false
    into sumR;
    return sumR;
END$$

DROP FUNCTION IF EXISTS `HelloWorld`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `HelloWorld` () RETURNS VARCHAR(20) CHARSET latin1 BEGIN
    RETURN 'Hello World!';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `answers`
--

DROP TABLE IF EXISTS `answers`;
CREATE TABLE IF NOT EXISTS `answers` (
  `idAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) NOT NULL,
  `isCorrect` tinyint(1) NOT NULL,
  `idQuestion` int(11) NOT NULL,
  PRIMARY KEY (`idAnswer`),
  KEY `Answers_Questions_FK` (`idQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `idQuestion` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) NOT NULL,
  PRIMARY KEY (`idQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `login` varchar(50) NOT NULL,
  `password` char(50) NOT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users_answers`
--

DROP TABLE IF EXISTS `users_answers`;
CREATE TABLE IF NOT EXISTS `users_answers` (
  `idAnswer` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  PRIMARY KEY (`idAnswer`,`login`),
  KEY `users_answers_Users0_FK` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `Answers_Questions_FK` FOREIGN KEY (`idQuestion`) REFERENCES `questions` (`idQuestion`);

--
-- Contraintes pour la table `users_answers`
--
ALTER TABLE `users_answers`
  ADD CONSTRAINT `users_answers_Answers_FK` FOREIGN KEY (`idAnswer`) REFERENCES `answers` (`idAnswer`),
  ADD CONSTRAINT `users_answers_Users0_FK` FOREIGN KEY (`login`) REFERENCES `users` (`login`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
