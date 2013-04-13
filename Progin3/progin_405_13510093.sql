-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 13, 2013 at 10:54 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `progin_405_13510093`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE IF NOT EXISTS `anggota` (
  `id_user` int(5) NOT NULL,
  `id_kategori` int(5) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id_user`,`id_kategori`),
  KEY `id_kategori` (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`id_user`, `id_kategori`, `status`) VALUES
(1, 1, 'ongoing'),
(1, 2, 'ongoing'),
(1, 3, 'ongoing'),
(2, 1, 'ongoing'),
(3, 1, 'ongoing'),
(3, 2, 'ongoing'),
(3, 3, 'ongoing');

-- --------------------------------------------------------

--
-- Table structure for table `attachment`
--

CREATE TABLE IF NOT EXISTS `attachment` (
  `id_tugas` int(5) NOT NULL,
  `nama_file` varchar(250) NOT NULL,
  PRIMARY KEY (`id_tugas`,`nama_file`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attachment`
--

INSERT INTO `attachment` (`id_tugas`, `nama_file`) VALUES
(2, 'penguins.jpg'),
(2, 'TubesII.pdf'),
(2, 'Wildlife.wmv'),
(41, ''),
(42, '');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE IF NOT EXISTS `kategori` (
  `id_kategori` int(5) NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(25) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Tubes Progin'),
(2, 'Imagine Cup'),
(3, 'Tubes Sister');

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE IF NOT EXISTS `komentar` (
  `id_komentar` int(5) NOT NULL AUTO_INCREMENT,
  `id_user` int(5) NOT NULL,
  `id_tugas` int(5) NOT NULL,
  `isi_komentar` text NOT NULL,
  `tanggal_komentar` datetime NOT NULL,
  PRIMARY KEY (`id_komentar`,`id_user`,`id_tugas`),
  KEY `id_user` (`id_user`),
  KEY `id_tugas` (`id_tugas`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`id_komentar`, `id_user`, `id_tugas`, `isi_komentar`, `tanggal_komentar`) VALUES
(1, 1, 1, 'semangat!', '2013-03-05 00:00:00'),
(3, 1, 2, 'bklablabla', '2013-03-23 08:13:34'),
(4, 3, 2, 'hayoo', '2013-03-21 10:18:32'),
(5, 2, 2, 'hahaha', '2013-03-17 16:16:40'),
(9, 3, 2, 'tes', '2013-03-23 14:12:04'),
(10, 3, 2, 'tes', '2013-03-23 14:55:47'),
(11, 3, 2, 'ha', '2013-03-23 14:55:52'),
(12, 3, 2, 'we', '2013-03-23 14:55:56'),
(13, 3, 2, 'rwer', '2013-03-23 14:56:00'),
(14, 3, 2, 'asdfasdfasdf', '2013-03-23 14:56:05'),
(15, 3, 2, 'asdfasdfasdf', '2013-03-23 14:56:09'),
(16, 2, 2, 'qwerty', '2013-04-12 06:57:40'),
(17, 2, 2, 'bleketek', '2013-04-12 06:57:56'),
(18, 2, 2, 'zzz', '2013-04-12 07:00:10'),
(19, 3, 3, 'jujuj', '2013-04-13 11:57:02');

-- --------------------------------------------------------

--
-- Table structure for table `mengerjakan`
--

CREATE TABLE IF NOT EXISTS `mengerjakan` (
  `id_user` int(5) NOT NULL AUTO_INCREMENT,
  `id_tugas` int(5) NOT NULL,
  PRIMARY KEY (`id_user`,`id_tugas`),
  KEY `id_tugas` (`id_tugas`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `mengerjakan`
--

INSERT INTO `mengerjakan` (`id_user`, `id_tugas`) VALUES
(1, 1),
(2, 1),
(1, 3),
(3, 3),
(1, 41),
(2, 41),
(1, 42),
(3, 42);

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id_tugas` int(5) NOT NULL AUTO_INCREMENT,
  `label` varchar(25) NOT NULL,
  PRIMARY KEY (`id_tugas`,`label`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`id_tugas`, `label`) VALUES
(1, 'ajax'),
(1, 'php'),
(3, 'kompetisi'),
(3, 'lomba'),
(4, 'kompetisi'),
(4, 'lomba'),
(41, ''),
(42, 'game'),
(42, 'sister');

-- --------------------------------------------------------

--
-- Table structure for table `tugas`
--

CREATE TABLE IF NOT EXISTS `tugas` (
  `id_tugas` int(5) NOT NULL AUTO_INCREMENT,
  `id_user_pembuat` int(11) NOT NULL,
  `nama_tugas` varchar(25) NOT NULL,
  `deadline` date NOT NULL,
  `id_kategori` int(5) NOT NULL,
  `status_tugas` varchar(12) NOT NULL,
  PRIMARY KEY (`id_tugas`),
  KEY `id_kategori` (`id_kategori`),
  KEY `id_user_pembuat` (`id_user_pembuat`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `id_user_pembuat`, `nama_tugas`, `deadline`, `id_kategori`, `status_tugas`) VALUES
(1, 1, 'membuat database', '2013-03-09', 1, 'done'),
(2, 2, 'nih', '2013-04-12', 1, 'done'),
(3, 3, 'merancang GUI', '2013-03-05', 2, 'done'),
(4, 1, 'membuat flow', '2013-03-01', 2, 'in progress'),
(41, 2, 'blablalba', '1955-01-01', 1, 'done'),
(42, 3, 'membuat gameplay', '2013-04-16', 3, 'in progress');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(5) NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(12) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `avatar` varchar(200) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama_lengkap`, `email`, `username`, `password`, `tanggal_lahir`, `avatar`) VALUES
(1, 'Anasthasia Amelia', 'amelia@gmail.com', 'amelia2801', 'bluedemon', '1955-01-01', 'upload/foto.jpg'),
(2, 'Patrick Lumban Tobing', 'patrick@hotmail.com', 'patricktobing', 'spongebob', '1992-03-17', 'upload/dog.jpg'),
(3, 'Benedikus Holyson', 'benny.h@gmail.com', 'benny92', 'benbenben', '1992-04-20', './upload/nature-scotty-bobby-uploads-content-dizorb-428992.jpg');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anggota`
--
ALTER TABLE `anggota`
  ADD CONSTRAINT `anggota_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `anggota_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attachment`
--
ALTER TABLE `attachment`
  ADD CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `komentar_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `komentar_ibfk_4` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mengerjakan`
--
ALTER TABLE `mengerjakan`
  ADD CONSTRAINT `mengerjakan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mengerjakan_ibfk_2` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tag`
--
ALTER TABLE `tag`
  ADD CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`id_tugas`) REFERENCES `tugas` (`id_tugas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tugas`
--
ALTER TABLE `tugas`
  ADD CONSTRAINT `tugas_ibfk_2` FOREIGN KEY (`id_user_pembuat`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tugas_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
