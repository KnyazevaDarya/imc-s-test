CREATE TABLE medcare.medusl
(
	CKEY int  UNIQUE,
	CREF int,
	CNUM smallint,
	CEND bool,
	TEXTCODE varchar(16) NOT NULL,
	NAME varchar(128) NOT NULL
);
--Далее удалось доп средствами перевести dbf файл в csv, но из-за проблем с кодировками не удалось распарсить, не нашла решения