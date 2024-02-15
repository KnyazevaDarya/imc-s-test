CREATE SCHEMA medcare;
CREATE TABLE medcare.SCHET
(
	CODE_MO varchar(6) PRIMARY KEY NOT NULL,
	SCHET_YEAR smallint NOT NULL,-- т.к. маленькое число хранит
	SCHET_MONTH numeric(2) NOT NULL,--тк меньше 99
	NSCHET varchar(20),
	DSCHET date,
	PLAT varchar(5),
	COMENTS varchar(250)
	
);

CREATE TABLE medcare.SLUCH
(
	ID_SLUCH varchar(36) PRIMARY KEY NOT NULL,
	PR_NOV bool NOT NULL,
	VIDPOM numeric(2) NOT NULL,
	MODDATE timestamp without time zone,
	BEGDATE timestamp without time zone NOT NULL,
	ENDDATE timestamp without time zone NOT NULL,
	MO_CUSTOM varchar(6) NOT NULL DEFAULT 63,--дефолт взят из ворд документа
	LPUBASE smallint DEFAULT 7001,--дефолт взят из ворд документа
	ID_STAT numeric(1) NOT NULL,
	SMO varchar(5),
	SMO_OK varchar(5),
	NOVOR varchar(9),
	CODE_MO varchar(6),
	FOREIGN KEY (CODE_MO) REFERENCES MEDCARE.SCHET (CODE_MO) ON DELETE CASCADE,
	CHECK (PR_NOV='0' OR PR_NOV='1'),
	CHECK (ID_STAT >-1 AND ID_STAT<6)
);

CREATE TABLE medcare.USL
(
	ID_USL varchar(36) PRIMARY KEY NOT NULL,
	CODE_USL varchar(16) NOT NULL,
	PRVS varchar(9) NOT NULL,--посмотрела справочник-хранятся коды и название, не вижу мыссла хранить int
	DATEUSL date NOT NULL,
	CODE_MD varchar(8) NOT NULL,
	SKIND varchar(2) NOT NULL,--для наименьшего хранения
	TYPEOPER varchar(3),
	INTOX varchar(15) [],
	DS_DENT varchar(10) [] CHECK (SKIND='5'),
	PODR varchar(8) NOT NULL,
	PROFIL varchar(11) NOT NULL,
	DET bool NOT NULL, --не понятно о каком поле AGE говорится в документе, такого не существует
	BEDPROF  varchar(3),
	KOL_USL numeric(6,2) NOT NULL,
	VID_VME varchar(15),
	NPL numeric(1),
	ID_SLUCH varchar(36),
	FOREIGN KEY (ID_SLUCH) REFERENCES MEDCARE.SLUCH (ID_SLUCH) ON DELETE CASCADE,
	--CHECK (USL.DATEUSL>SLUCH.BEGDATE AND USL.DATEUSL<SLUCH.ENDDATE),
	CHECK (DET='0' OR DET='1'),
	CHECK (NPL>0 AND NPL<5)
);

create table medcare.buf
(	xmlfile text);

copy medcare.buf
(	"xmlfile")
from 'D:\sql_middle-main\sql_middle-main\C8BAFCEC-B253-4784-A4FA-AE8632F05501.xml'
with encoding 'WIN1251';--получение данных из файла в буферную таблицу, распределить по таблицам, к сожалению, не удалось