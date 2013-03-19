-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 19, 2013 at 11:19 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tubesprogin`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE IF NOT EXISTS `anggota` (
  `id_user` varchar(5) NOT NULL,
  `id_kategori` varchar(5) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id_user`,`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`id_user`, `id_kategori`, `status`) VALUES
('001', 'C02', 'ongoing'),
('002', 'C01', 'ongoing');

-- --------------------------------------------------------

--
-- Table structure for table `attachment`
--

CREATE TABLE IF NOT EXISTS `attachment` (
  `id_tugas` varchar(5) NOT NULL,
  `nama_file` varchar(25) NOT NULL,
  PRIMARY KEY (`id_tugas`,`nama_file`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attachment`
--


-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE IF NOT EXISTS `kategori` (
  `id_kategori` varchar(5) NOT NULL,
  `nama_kategori` varchar(25) NOT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
('C01', 'Tubes Progin'),
('C02', 'Imagine Cup'),
('C03', 'Tubes Sister');

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE IF NOT EXISTS `komentar` (
  `id_komentar` char(5) NOT NULL,
  `id_user` varchar(5) NOT NULL,
  `id_tugas` varchar(5) NOT NULL,
  `isi_komentar` text NOT NULL,
  `tanggal_komentar` date NOT NULL,
  PRIMARY KEY (`id_komentar`,`id_user`,`id_tugas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`id_komentar`, `id_user`, `id_tugas`, `isi_komentar`, `tanggal_komentar`) VALUES
('K001', '001', 'T001', 'semangat!', '2013-03-05'),
('K002', '002', 'T003', 'keren banget', '2013-03-06');

-- --------------------------------------------------------

--
-- Table structure for table `mengerjakan`
--

CREATE TABLE IF NOT EXISTS `mengerjakan` (
  `id_user` varchar(5) NOT NULL,
  `id_tugas` varchar(5) NOT NULL,
  PRIMARY KEY (`id_user`,`id_tugas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mengerjakan`
--

INSERT INTO `mengerjakan` (`id_user`, `id_tugas`) VALUES
('001', 'T001'),
('001', 'T003'),
('002', 'T001'),
('002', 'T004'),
('003', 'T002'),
('003', 'T003');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id_tugas` varchar(5) NOT NULL,
  `label` varchar(25) NOT NULL,
  PRIMARY KEY (`id_tugas`,`label`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`id_tugas`, `label`) VALUES
('T001', 'ajax'),
('T001', 'internet'),
('T001', 'php'),
('T002', 'ajax'),
('T002', 'internet'),
('T002', 'php'),
('T003', 'kompetisi'),
('T003', 'lomba'),
('T004', 'kompetisi'),
('T004', 'lomba');

-- --------------------------------------------------------

--
-- Table structure for table `tugas`
--

CREATE TABLE IF NOT EXISTS `tugas` (
  `id_tugas` varchar(5) NOT NULL,
  `nama_tugas` varchar(25) NOT NULL,
  `deadline` date NOT NULL,
  `id_kategori` varchar(5) NOT NULL,
  `status_tugas` varchar(12) NOT NULL,
  PRIMARY KEY (`id_tugas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `nama_tugas`, `deadline`, `id_kategori`, `status_tugas`) VALUES
('T001', 'membuat database', '2013-03-09', 'C01', 'done'),
('T002', 'halaman utama', '2013-03-11', 'C01', 'in progress'),
('T003', 'merancang GUI', '2013-03-05', 'C02', 'in progress'),
('T004', 'membuat flow', '2013-03-01', 'C02', 'in progress'),
('T005', 'membuat rancangan', '2013-03-13', 'C03', 'in progress');

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
(1, 'Anasthasia Amelia', 'amelia@gmail.com', 'amelia2801', 'bluedemon', '1992-01-28', 'avatar/foto.jpg'),
(2, 'Patrick Lumban Tobing', 'patrick@hotmail.com', 'patricktobing', 'spongebob', '1992-03-17', ''),
(3, 'Benedikus Holyson', 'benny.h@gmail.com', 'benny92', 'benbenben', '1992-05-28', '');
