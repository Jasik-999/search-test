-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 27 2024 г., 12:47
-- Версия сервера: 5.7.39
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test_task_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `vb_post`
--

CREATE TABLE `vb_post` (
  `id` int(10) NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `forum_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `vb_post`
--

INSERT INTO `vb_post` (`id`, `text`, `forum_id`) VALUES
(1, 'text 1 example ', 1),
(2, 'text 2 lorem', 1),
(3, '3 content ', 5),
(4, 'content 4', 2),
(5, 'ipsum dolor sit amet 5', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `vb_searchresult`
--

CREATE TABLE `vb_searchresult` (
  `searchid` int(10) NOT NULL,
  `query` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `result` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `vb_searchresult`
--

INSERT INTO `vb_searchresult` (`searchid`, `query`, `result`) VALUES
(3, 'text', '[{\"id\":1,\"0\":1,\"text\":\"text 1 example \",\"1\":\"text 1 example \",\"forum_id\":1,\"2\":1},{\"id\":2,\"0\":2,\"text\":\"text 2 lorem\",\"1\":\"text 2 lorem\",\"forum_id\":1,\"2\":1}]'),
(4, 'content', '[{\"id\":3,\"0\":3,\"text\":\"3 content \",\"1\":\"3 content \",\"forum_id\":5,\"2\":5},{\"id\":4,\"0\":4,\"text\":\"content 4\",\"1\":\"content 4\",\"forum_id\":2,\"2\":2}]');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `vb_post`
--
ALTER TABLE `vb_post`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `vb_searchresult`
--
ALTER TABLE `vb_searchresult`
  ADD PRIMARY KEY (`searchid`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `vb_post`
--
ALTER TABLE `vb_post`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `vb_searchresult`
--
ALTER TABLE `vb_searchresult`
  MODIFY `searchid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
