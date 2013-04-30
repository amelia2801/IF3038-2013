-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2013 at 09:33 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `progin_405_13511601`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignee`
--

CREATE TABLE IF NOT EXISTS `assignee` (
  `username` varchar(50) NOT NULL,
  `taskid` int(11) NOT NULL,
  KEY `assignee_ibfk_1` (`taskid`),
  KEY `assignee_ibfk_2` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assignee`
--

INSERT INTO `assignee` (`username`, `taskid`) VALUES
('wchaq2', 1),
('wchaq', 1),
('wchaq', 3),
('wchaq2', 3),
('ismail', 3);

-- --------------------------------------------------------

--
-- Table structure for table `attachment`
--

CREATE TABLE IF NOT EXISTS `attachment` (
  `filename` varchar(50) NOT NULL,
  `taskid` int(11) NOT NULL,
  KEY `FK_attachment_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attachment`
--

INSERT INTO `attachment` (`filename`, `taskid`) VALUES
('3-Capture.JPG', 3),
('3-fishbone.JPG', 3),
('3-KAP-nametag.JPG', 3),
('3-UjiCoba.txt', 3),
('3-intro.mp4', 3);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `createddate` datetime NOT NULL,
  PRIMARY KEY (`categoryid`),
  KEY `FK_category_user` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryid`, `categoryname`, `username`, `createddate`) VALUES
(1, 'pekerjaan Rumah', 'wchaq2', '2013-03-16 05:09:35'),
(2, 'Belajar', 'wchaq', '2013-03-19 07:07:19'),
(3, 'Iseng', 'robert', '2013-04-04 06:19:41');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `commentid` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `message` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `taskid` int(11) NOT NULL,
  PRIMARY KEY (`commentid`),
  KEY `comment_ibfk_1` (`username`),
  KEY `comment_ibfk_2` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`commentid`, `createdate`, `message`, `username`, `taskid`) VALUES
(1, '2013-03-16 05:28:38', 'gaul', 'ismail', 1),
(2, '2013-03-16 05:28:53', 'gaul Banget Kakakaaaaa', 'ismail', 1),
(3, '2013-03-16 05:29:11', 'gaul banget kakakakakakakak ampun dewaaaa,..,.,.,', 'ismail', 1),
(4, '2013-03-16 05:30:01', 'ah situ bisa aja....', 'wchaq', 1),
(9, '2013-03-23 11:09:12', 'lemah semua', 'wchaq', 1),
(11, '2013-03-23 13:36:28', 'wasuuuuu', 'wchaq2', 1),
(12, '2013-04-10 00:00:00', 'awd', 'wchaq', 1),
(13, '2013-04-10 00:00:00', 'awdawdawd', 'wchaq', 1),
(14, '2013-04-10 00:00:00', 'awdawdawdawd', 'wchaq', 1),
(15, '2013-04-11 00:00:00', 'awdawd', 'wchaq', 3);

-- --------------------------------------------------------

--
-- Table structure for table `responsibility`
--

CREATE TABLE IF NOT EXISTS `responsibility` (
  `username` varchar(50) NOT NULL,
  `categoryid` int(11) NOT NULL,
  KEY `responsibility_ibfk_1` (`categoryid`),
  KEY `responsibility_ibfk_2` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `responsibility`
--

INSERT INTO `responsibility` (`username`, `categoryid`) VALUES
('wchaq2', 1),
('wchaq', 1),
('wchaq', 2),
('wchaq2', 2),
('robert', 3),
('wchaq', 3),
('ismail', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `tagid` int(11) NOT NULL AUTO_INCREMENT,
  `tagname` varchar(50) NOT NULL,
  PRIMARY KEY (`tagid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`tagid`, `tagname`) VALUES
(13, 'gampang'),
(14, 'Males'),
(15, 'Banyak'),
(16, 'Serius'),
(17, 'Keringat'),
(18, 'tenaga'),
(19, 'Kerjakan'),
(20, 'selesaikan'),
(21, 'gawat'),
(22, 'gaul'),
(23, 'ini'),
(24, 'barusan'),
(25, 'bikin'),
(26, 'banget'),
(27, 'baru'),
(28, 'lama'),
(29, 'aw'),
(30, 'iw'),
(31, 'ow');

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `taskid` int(11) NOT NULL,
  `taskname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `createddate` datetime NOT NULL,
  `deadline` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `categoryid` int(11) NOT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_ibfk_1` (`categoryid`),
  KEY `FK_task_user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`taskid`, `taskname`, `username`, `createddate`, `deadline`, `status`, `categoryid`) VALUES
(1, 'Menyapu halaman', 'wchaq2', '2013-03-16 05:10:20', '2013-03-30 03:30:00', 'COMPLETE', 1),
(3, 'Koreksi tugas Basis Data', 'wchaq', '2013-03-16 06:10:06', '2013-10-02 22:22:00', 'COMPLETE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `task_tag`
--

CREATE TABLE IF NOT EXISTS `task_tag` (
  `taskid` int(11) NOT NULL,
  `tagid` int(11) NOT NULL,
  KEY `task_tag_ibfk_1` (`taskid`),
  KEY `task_tag_ibfk_2` (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task_tag`
--

INSERT INTO `task_tag` (`taskid`, `tagid`) VALUES
(1, 13),
(1, 14),
(1, 15),
(3, 29),
(3, 30),
(3, 31);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `join` date NOT NULL,
  `aboutme` varchar(200) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `fullname`, `birthday`, `email`, `join`, `aboutme`, `avatar`) VALUES
('awdawd', 'awdawdawd', 'awd awd', '2013-03-31', 'awd@awd.awd', '2013-04-06', 'telling yourself in here', 'avatar'),
('awdawdawd', 'awdawdawdawd', 'awd awd', '2013-03-31', 'awd@awd.awda', '2013-04-06', 'telling yourself in here', 'avatar'),
('ismail', 'ismailalay', 'ismail abdul keren', '2013-03-24', 'ismail@keren.com', '2013-03-16', 'telling yourself in here', 'ismail.jpg'),
('robert', 'barupass', 'robert gaul baik hati', '2013-04-22', 'rb.th@gmail.com', '2013-04-04', 'kljasdbfliasrbolairbhogliarbgolairbhgoairhbgolairbggrbar arfhaigrhoarhgo', 'robert.jpg'),
('wchaq', 'awdawdawdawd', 'Whilda Chaq Baru', '2013-03-13', 'whilda@rocketmial.com', '2013-03-16', 'whilda@rocketmial.comisaridpertahanan', 'wchaq.jpg'),
('wchaq2', 'whildaganteng', 'Whilda Chaq', '2013-03-19', 'whilda2@rocketmial.com', '2013-03-16', 'Saya orang pandai yang tidak sombong seperti martin', 'wchaq2.jpg');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignee`
--
ALTER TABLE `assignee`
  ADD CONSTRAINT `assignee_ibfk_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assignee_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attachment`
--
ALTER TABLE `attachment`
  ADD CONSTRAINT `FK_attachment_task` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `FK_category_user` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `responsibility`
--
ALTER TABLE `responsibility`
  ADD CONSTRAINT `responsibility_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `responsibility_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `FK_task_user` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_tag`
--
ALTER TABLE `task_tag`
  ADD CONSTRAINT `task_tag_ibfk_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_tag_ibfk_2` FOREIGN KEY (`tagid`) REFERENCES `tag` (`tagid`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
