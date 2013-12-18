-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Дек 18 2013 г., 19:45
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `metro2033`
--

-- --------------------------------------------------------

--
-- Структура таблицы `m_invite`
--

CREATE TABLE IF NOT EXISTS `m_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `m_invite`
--

INSERT INTO `m_invite` (`id`, `code`, `user_id`) VALUES
(1, 'ieHoh9oh', 3),
(2, 'wopi2Gi1', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `m_user`
--

CREATE TABLE IF NOT EXISTS `m_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password_crc` varchar(40) NOT NULL,
  `username_crc` varchar(250) NOT NULL,
  `reg_time` datetime NOT NULL,
  `last_visit_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_crc` (`username_crc`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `m_user`
--

INSERT INTO `m_user` (`id`, `username`, `email`, `password_crc`, `username_crc`, `reg_time`, `last_visit_time`) VALUES
(1, 'admin', 'admin@admin.ru', '', 'admin', '2013-12-16 00:00:00', '2013-12-17 03:12:42'),
(3, '', 'admin2@admin.ru', '9131DA6A52C71E8029886AF9C706F94C', '', '2013-12-17 02:59:20', '2013-12-18 15:33:38');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `m_invite`
--
ALTER TABLE `m_invite`
  ADD CONSTRAINT `m_invite_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `m_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
