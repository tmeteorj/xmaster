-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.5.20 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 xuzhou 的数据库结构
DROP DATABASE IF EXISTS `xuzhou`;
CREATE DATABASE IF NOT EXISTS `xuzhou` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `xuzhou`;


-- 导出  表 xuzhou.rk 结构
DROP TABLE IF EXISTS `rk`;
CREATE TABLE IF NOT EXISTS `rk` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `GMSFHM` varchar(255) DEFAULT NULL COMMENT '公民身份号码',
  `XM` varchar(255) DEFAULT NULL COMMENT '姓名',
  `CYM` varchar(255) DEFAULT NULL COMMENT '曾用名',
  `XB` varchar(255) DEFAULT NULL COMMENT '性别',
  `MZ` varchar(255) DEFAULT NULL COMMENT '民族',
  `CSRQ` date DEFAULT NULL COMMENT '出生日期',
  `JGGJDQ` varchar(255) DEFAULT NULL COMMENT '籍贯国家（地区）',
  `JGSSXQ` varchar(255) DEFAULT NULL COMMENT '籍贯省市县（区）',
  `ZZMM` varchar(255) DEFAULT NULL COMMENT '政治面貌',
  `ZJXY` varchar(255) DEFAULT NULL COMMENT '宗教信仰',
  `WHCD` varchar(255) DEFAULT NULL COMMENT '文化程度',
  `HYZK` varchar(255) DEFAULT NULL COMMENT '婚姻状况',
  `BYZK` varchar(255) DEFAULT NULL COMMENT '兵役状况',
  `SG` varchar(255) DEFAULT NULL COMMENT '身高',
  `XX` varchar(255) DEFAULT NULL COMMENT '血型',
  `ZY` varchar(255) DEFAULT NULL COMMENT '职业',
  `ZYLB` varchar(255) DEFAULT NULL COMMENT '职业类别',
  `FWCS` varchar(255) DEFAULT NULL COMMENT '服务处所',
  `MLPBS` varchar(255) DEFAULT NULL COMMENT '门（楼）牌标识',
  `JMSFZJYXQQSRQ` date DEFAULT NULL COMMENT '居民身份证件有效期起始日期',
  `JMSFZJYXQJZRQ` date DEFAULT NULL COMMENT '居民身份证件有效期截止日期',
  `JMSFZJCQYXBZ` varchar(255) DEFAULT NULL COMMENT '居民身份证件长期有效标志',
  `JZXZ` varchar(255) DEFAULT NULL COMMENT '居住详址',
  `RKDZBM` varchar(255) DEFAULT NULL COMMENT '人口地址编码',
  `SSXY` varchar(255) DEFAULT NULL COMMENT '所属行业',
  `HBM` varchar(255) DEFAULT NULL COMMENT '户编码',
  `HJSZD` varchar(255) DEFAULT NULL COMMENT '户籍所在地',
  `HKXZ` varchar(255) DEFAULT NULL COMMENT '户口性质',
  `RHZT` varchar(255) DEFAULT NULL COMMENT '入户状态',
  `ZXZT` varchar(255) DEFAULT NULL COMMENT '注销状态',
  `JYZT` varchar(255) DEFAULT NULL COMMENT '就业状态',
  `PYM` varchar(255) DEFAULT NULL COMMENT '拼音码',
  `DWDZBM` varchar(255) DEFAULT NULL COMMENT '单位地址编码',
  `CYZK` varchar(255) DEFAULT NULL COMMENT '从业状况',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口';

-- 正在导出表  xuzhou.rk 的数据：~0 rows (大约)
DELETE FROM `rk`;
/*!40000 ALTER TABLE `rk` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_csdj 结构
DROP TABLE IF EXISTS `rk_csdj`;
CREATE TABLE IF NOT EXISTS `rk_csdj` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `HH` varchar(255) DEFAULT NULL COMMENT '户号',
  `CSDJLB` varchar(255) DEFAULT NULL COMMENT '出生登记类别',
  `CSSJ` timestamp NULL DEFAULT NULL COMMENT '出生时间',
  `CSDJBH` varchar(255) DEFAULT NULL COMMENT '出生登记编号',
  `CSDGJDQ` varchar(255) DEFAULT NULL COMMENT '出生地国家（地区）',
  `CSDSSXQ` varchar(255) DEFAULT NULL COMMENT '出生地省市县（区）',
  `CSDXZ` varchar(255) DEFAULT NULL COMMENT '出生地详址',
  `SBRGMSFHM` varchar(255) DEFAULT NULL COMMENT '申报人公民身份号码',
  `SBRXM` varchar(255) DEFAULT NULL COMMENT '申报人姓名',
  `SLDW` varchar(255) DEFAULT NULL COMMENT '受理单位',
  `SLRXM` varchar(255) DEFAULT NULL COMMENT '受理人姓名',
  `SLSJ` timestamp NULL DEFAULT NULL COMMENT '受理时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_出生登记';

-- 正在导出表  xuzhou.rk_csdj 的数据：~0 rows (大约)
DELETE FROM `rk_csdj`;
/*!40000 ALTER TABLE `rk_csdj` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_csdj` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_jdzp 结构
DROP TABLE IF EXISTS `rk_jdzp`;
CREATE TABLE IF NOT EXISTS `rk_jdzp` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `JDZP` varchar(255) DEFAULT NULL COMMENT '机读照片',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_机读照片';

-- 正在导出表  xuzhou.rk_jdzp 的数据：~0 rows (大约)
DELETE FROM `rk_jdzp`;
/*!40000 ALTER TABLE `rk_jdzp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_jdzp` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_jhr 结构
DROP TABLE IF EXISTS `rk_jhr`;
CREATE TABLE IF NOT EXISTS `rk_jhr` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `XH` varchar(255) NOT NULL COMMENT '序号',
  `JHRRKBS` varchar(255) DEFAULT NULL COMMENT '监护人人口标识',
  `JHRGMSFHM` varchar(255) DEFAULT NULL COMMENT '监护人公民身份号码',
  `XM` varchar(255) DEFAULT NULL COMMENT '姓名',
  `JHGX` varchar(255) DEFAULT NULL COMMENT '监护关系',
  `LXDH` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`,`XH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_监护人';

-- 正在导出表  xuzhou.rk_jhr 的数据：~0 rows (大约)
DELETE FROM `rk_jhr`;
/*!40000 ALTER TABLE `rk_jhr` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_jhr` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_jt 结构
DROP TABLE IF EXISTS `rk_jt`;
CREATE TABLE IF NOT EXISTS `rk_jt` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `XH` varchar(255) NOT NULL COMMENT '序号',
  `GXRRKBS` varchar(255) DEFAULT NULL COMMENT '关系人人口标识',
  `GXRRKSFHM` varchar(255) DEFAULT NULL COMMENT '关系人人口身份号码',
  `JTGX` varchar(255) DEFAULT NULL COMMENT '家庭关系',
  `XM` varchar(255) DEFAULT NULL COMMENT '姓名',
  `LXDH` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`,`XH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_家庭关系';

-- 正在导出表  xuzhou.rk_jt 的数据：~0 rows (大约)
DELETE FROM `rk_jt`;
/*!40000 ALTER TABLE `rk_jt` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_jt` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_mp 结构
DROP TABLE IF EXISTS `rk_mp`;
CREATE TABLE IF NOT EXISTS `rk_mp` (
  `MLPBS` varchar(255) NOT NULL COMMENT '门（楼）牌标识',
  `SSXQ` varchar(255) DEFAULT NULL COMMENT '省市县（区）',
  `JLX` varchar(255) DEFAULT NULL COMMENT '街路巷',
  `MLPH` varchar(255) DEFAULT NULL COMMENT '门（楼）牌号',
  `MLXZ` varchar(255) DEFAULT NULL COMMENT '门（楼）详址',
  `PCS` varchar(255) DEFAULT NULL COMMENT '派出所',
  `ZRQ` varchar(255) DEFAULT NULL COMMENT '责任区',
  `XZJD` varchar(255) DEFAULT NULL COMMENT '乡镇（街道）',
  `JCWH` varchar(255) DEFAULT NULL COMMENT '居（村）委会',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`MLPBS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_门（楼）牌';

-- 正在导出表  xuzhou.rk_mp 的数据：~0 rows (大约)
DELETE FROM `rk_mp`;
/*!40000 ALTER TABLE `rk_mp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_mp` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_qczx 结构
DROP TABLE IF EXISTS `rk_qczx`;
CREATE TABLE IF NOT EXISTS `rk_qczx` (
  `RKBS` varchar(255) DEFAULT NULL COMMENT '人口标识',
  `QCRQ` varchar(255) DEFAULT NULL COMMENT '迁出日期',
  `QCZXLB` varchar(255) DEFAULT NULL COMMENT '迁出注销类别',
  `QWGJDQ` varchar(255) DEFAULT NULL COMMENT '迁往国家（地区）',
  `QWSSXQ` varchar(255) DEFAULT NULL COMMENT '迁往省市县（区）',
  `QWXZ` varchar(255) DEFAULT NULL COMMENT '迁往详址',
  `QYZBH` varchar(255) DEFAULT NULL COMMENT '迁移证编号',
  `ZQZBH` varchar(255) DEFAULT NULL COMMENT '准迁证编号',
  `SBRGMSFHM` varchar(255) DEFAULT NULL COMMENT '申报人公民身份号码',
  `SBRXM` varchar(255) DEFAULT NULL COMMENT '申报人姓名',
  `SLDW` varchar(255) DEFAULT NULL COMMENT '受理单位',
  `SLRXM` varchar(255) DEFAULT NULL COMMENT '受理人姓名',
  `SLSJ` varchar(255) DEFAULT NULL COMMENT '受理时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_迁出注销';

-- 正在导出表  xuzhou.rk_qczx 的数据：~0 rows (大约)
DELETE FROM `rk_qczx`;
/*!40000 ALTER TABLE `rk_qczx` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_qczx` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_ql 结构
DROP TABLE IF EXISTS `rk_ql`;
CREATE TABLE IF NOT EXISTS `rk_ql` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `QRRQ` date NOT NULL COMMENT '迁入日期',
  `HH` varchar(255) DEFAULT NULL COMMENT '户号',
  `QRLB` varchar(255) DEFAULT NULL COMMENT '迁入类别',
  `QLYY` varchar(255) DEFAULT NULL COMMENT '迁来原因',
  `QCSSXQ` varchar(255) DEFAULT NULL COMMENT '迁出省市县（区）',
  `QCXZ` varchar(255) DEFAULT NULL COMMENT '迁出详址',
  `QYZBH` varchar(255) DEFAULT NULL COMMENT '迁移证编号',
  `ZQZBH` varchar(255) DEFAULT NULL COMMENT '准迁证编号',
  `YJMSFZJQFJG` varchar(255) DEFAULT NULL COMMENT '原居民身份证件签发机关',
  `YJMSFZJYXQQS` date DEFAULT NULL COMMENT '原居民身份证件有效期起始',
  `YJMSFZJYXQJZ` date DEFAULT NULL COMMENT '原居民身份证件有效期截止',
  `SBRGMSFHM` varchar(255) DEFAULT NULL COMMENT '申报人公民身份号码',
  `SBRXM` varchar(255) DEFAULT NULL COMMENT '申报人姓名',
  `SLDW` varchar(255) DEFAULT NULL COMMENT '受理单位',
  `SLRXM` varchar(255) DEFAULT NULL COMMENT '受理人姓名',
  `SLSJ` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '受理时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`,`QRRQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_迁入登记';

-- 正在导出表  xuzhou.rk_ql 的数据：~0 rows (大约)
DELETE FROM `rk_ql`;
/*!40000 ALTER TABLE `rk_ql` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_ql` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_qtlx 结构
DROP TABLE IF EXISTS `rk_qtlx`;
CREATE TABLE IF NOT EXISTS `rk_qtlx` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `LXLX` varchar(255) NOT NULL COMMENT '联系类型',
  `LXMS` varchar(255) DEFAULT NULL COMMENT '联系描述',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`,`LXLX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_其他联系';

-- 正在导出表  xuzhou.rk_qtlx 的数据：~0 rows (大约)
DELETE FROM `rk_qtlx`;
/*!40000 ALTER TABLE `rk_qtlx` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_qtlx` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_qtzj 结构
DROP TABLE IF EXISTS `rk_qtzj`;
CREATE TABLE IF NOT EXISTS `rk_qtzj` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `SFZJLX` varchar(255) NOT NULL COMMENT '身份证件类型',
  `SFZJH` varchar(255) DEFAULT NULL COMMENT '身份证件号',
  `QFJG` varchar(255) DEFAULT NULL COMMENT '签发机关',
  `YXQZ` date DEFAULT NULL COMMENT '有效期至',
  `QFRQ` date DEFAULT NULL COMMENT '签发日期',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`,`SFZJLX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_其他证件';

-- 正在导出表  xuzhou.rk_qtzj 的数据：~0 rows (大约)
DELETE FROM `rk_qtzj`;
/*!40000 ALTER TABLE `rk_qtzj` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_qtzj` ENABLE KEYS */;


-- 导出  表 xuzhou.rk_swzx 结构
DROP TABLE IF EXISTS `rk_swzx`;
CREATE TABLE IF NOT EXISTS `rk_swzx` (
  `RKBS` varchar(255) NOT NULL COMMENT '人口标识',
  `SWRQ` date DEFAULT NULL COMMENT '死亡日期',
  `SWZXLB` varchar(255) DEFAULT NULL COMMENT '死亡注销类别',
  `SWZMBH` varchar(255) DEFAULT NULL COMMENT '死亡证明编号',
  `SBRGMSFHM` varchar(255) DEFAULT NULL COMMENT '申报人公民身份号码',
  `SBRXM` varchar(255) DEFAULT NULL COMMENT '申报人姓名',
  `SLDW` varchar(255) DEFAULT NULL COMMENT '受理单位',
  `SLRXM` varchar(255) DEFAULT NULL COMMENT '受理人姓名',
  `SLSJ` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '受理时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RKBS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人口_死亡注销';

-- 正在导出表  xuzhou.rk_swzx 的数据：~0 rows (大约)
DELETE FROM `rk_swzx`;
/*!40000 ALTER TABLE `rk_swzx` DISABLE KEYS */;
/*!40000 ALTER TABLE `rk_swzx` ENABLE KEYS */;


-- 导出  表 xuzhou.发改委_重大项目 结构
DROP TABLE IF EXISTS `发改委_重大项目`;
CREATE TABLE IF NOT EXISTS `发改委_重大项目` (
  `序号` varchar(255) DEFAULT NULL,
  `项目名称` varchar(255) DEFAULT NULL,
  `项目类型` varchar(255) DEFAULT NULL,
  `批复文号（m2）` varchar(255) DEFAULT NULL,
  `项目单位` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.发改委_重大项目 的数据：~0 rows (大约)
DELETE FROM `发改委_重大项目`;
/*!40000 ALTER TABLE `发改委_重大项目` DISABLE KEYS */;
/*!40000 ALTER TABLE `发改委_重大项目` ENABLE KEYS */;


-- 导出  表 xuzhou.城管局_市城管许可 结构
DROP TABLE IF EXISTS `城管局_市城管许可`;
CREATE TABLE IF NOT EXISTS `城管局_市城管许可` (
  `行政许可决定书文号` varchar(255) DEFAULT NULL,
  `项目名称` varchar(255) DEFAULT NULL,
  `审批类别` varchar(255) DEFAULT NULL,
  `许可内容` varchar(255) DEFAULT NULL,
  `行政相对人名称` varchar(255) DEFAULT NULL,
  `行政相对人代码_1 (统一社会信用代码)` varchar(255) DEFAULT NULL,
  `行政相对人代码_2 (组织机构代码)` varchar(255) DEFAULT NULL,
  `行政相对人代码_3 (工商登记码)` varchar(255) DEFAULT NULL,
  `行政相对人代码_4 (税务登记号)` varchar(255) DEFAULT NULL,
  `法定代表人姓名` varchar(255) DEFAULT NULL,
  `许可决定日期` varchar(255) DEFAULT NULL,
  `许可截止期` varchar(255) DEFAULT NULL,
  `许可机关` varchar(255) DEFAULT NULL,
  `当前状态` varchar(255) DEFAULT NULL,
  `行政许可编码` varchar(255) DEFAULT NULL,
  `信息使用范围` varchar(255) DEFAULT NULL,
  `地方编码` varchar(255) DEFAULT NULL,
  `数据更新时间戳` varchar(255) DEFAULT NULL,
  `备注` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.城管局_市城管许可 的数据：~0 rows (大约)
DELETE FROM `城管局_市城管许可`;
/*!40000 ALTER TABLE `城管局_市城管许可` DISABLE KEYS */;
/*!40000 ALTER TABLE `城管局_市城管许可` ENABLE KEYS */;


-- 导出  表 xuzhou.城管局_广告公司联系表 结构
DROP TABLE IF EXISTS `城管局_广告公司联系表`;
CREATE TABLE IF NOT EXISTS `城管局_广告公司联系表` (
  `姓名` varchar(255) DEFAULT NULL,
  `职务` varchar(255) DEFAULT NULL,
  `公司名称` varchar(255) DEFAULT NULL,
  `公司地址` varchar(255) DEFAULT NULL,
  `电话` varchar(255) DEFAULT NULL,
  `手机` varchar(255) DEFAULT NULL,
  `传真` varchar(255) DEFAULT NULL,
  `电邮` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.城管局_广告公司联系表 的数据：~0 rows (大约)
DELETE FROM `城管局_广告公司联系表`;
/*!40000 ALTER TABLE `城管局_广告公司联系表` DISABLE KEYS */;
/*!40000 ALTER TABLE `城管局_广告公司联系表` ENABLE KEYS */;


-- 导出  表 xuzhou.城管局_智慧城市广告信息 结构
DROP TABLE IF EXISTS `城管局_智慧城市广告信息`;
CREATE TABLE IF NOT EXISTS `城管局_智慧城市广告信息` (
  `1` varchar(255) DEFAULT NULL,
  `淮海路及三个广场区域` varchar(255) DEFAULT NULL,
  `序号` varchar(255) DEFAULT NULL,
  `姓名` varchar(255) DEFAULT NULL,
  `职务` varchar(255) DEFAULT NULL,
  `公司名称` varchar(255) DEFAULT NULL,
  `电话` varchar(255) DEFAULT NULL,
  `手机` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.城管局_智慧城市广告信息 的数据：~0 rows (大约)
DELETE FROM `城管局_智慧城市广告信息`;
/*!40000 ALTER TABLE `城管局_智慧城市广告信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `城管局_智慧城市广告信息` ENABLE KEYS */;


-- 导出  表 xuzhou.安监局_危化品生产、经营、使用、储存 结构
DROP TABLE IF EXISTS `安监局_危化品生产、经营、使用、储存`;
CREATE TABLE IF NOT EXISTS `安监局_危化品生产、经营、使用、储存` (
  `企业全称（中文)` varchar(255) DEFAULT NULL,
  `主要负责人姓名` varchar(255) DEFAULT NULL,
  `企业注册地址` varchar(255) DEFAULT NULL,
  `联系电话` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.安监局_危化品生产、经营、使用、储存 的数据：~0 rows (大约)
DELETE FROM `安监局_危化品生产、经营、使用、储存`;
/*!40000 ALTER TABLE `安监局_危化品生产、经营、使用、储存` DISABLE KEYS */;
/*!40000 ALTER TABLE `安监局_危化品生产、经营、使用、储存` ENABLE KEYS */;


-- 导出  表 xuzhou.安监局_安全培训机构 结构
DROP TABLE IF EXISTS `安监局_安全培训机构`;
CREATE TABLE IF NOT EXISTS `安监局_安全培训机构` (
  `机构名称` varchar(255) DEFAULT NULL,
  `联系电话` varchar(255) DEFAULT NULL,
  `单位地址` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.安监局_安全培训机构 的数据：~0 rows (大约)
DELETE FROM `安监局_安全培训机构`;
/*!40000 ALTER TABLE `安监局_安全培训机构` DISABLE KEYS */;
/*!40000 ALTER TABLE `安监局_安全培训机构` ENABLE KEYS */;


-- 导出  表 xuzhou.安监局_安全评价机构 结构
DROP TABLE IF EXISTS `安监局_安全评价机构`;
CREATE TABLE IF NOT EXISTS `安监局_安全评价机构` (
  `机构名称` varchar(255) DEFAULT NULL,
  `法定代表人` varchar(255) DEFAULT NULL,
  `资质证书编号` varchar(255) DEFAULT NULL,
  `资质级别` varchar(255) DEFAULT NULL,
  `证书有效截止日期` varchar(255) DEFAULT NULL,
  `机构资格从业人员数` varchar(255) DEFAULT NULL,
  `联系人` varchar(255) DEFAULT NULL,
  `联系电话` varchar(255) DEFAULT NULL,
  `传真` varchar(255) DEFAULT NULL,
  `注册地址` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.安监局_安全评价机构 的数据：~0 rows (大约)
DELETE FROM `安监局_安全评价机构`;
/*!40000 ALTER TABLE `安监局_安全评价机构` DISABLE KEYS */;
/*!40000 ALTER TABLE `安监局_安全评价机构` ENABLE KEYS */;


-- 导出  表 xuzhou.安监局_生产许可 结构
DROP TABLE IF EXISTS `安监局_生产许可`;
CREATE TABLE IF NOT EXISTS `安监局_生产许可` (
  `企业全称（中文)` varchar(255) DEFAULT NULL,
  `许可证编号` varchar(255) DEFAULT NULL,
  `主要负责人姓名` varchar(255) DEFAULT NULL,
  `企业注册地址` varchar(255) DEFAULT NULL,
  `经济类型` varchar(255) DEFAULT NULL,
  `许可范围` varchar(255) DEFAULT NULL,
  `证书有效起始日期` varchar(255) DEFAULT NULL,
  `证书有效截止日期` varchar(255) DEFAULT NULL,
  `发证机关名称` varchar(255) DEFAULT NULL,
  `发证日期` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.安监局_生产许可 的数据：~0 rows (大约)
DELETE FROM `安监局_生产许可`;
/*!40000 ALTER TABLE `安监局_生产许可` DISABLE KEYS */;
/*!40000 ALTER TABLE `安监局_生产许可` ENABLE KEYS */;


-- 导出  表 xuzhou.安监局_职业健康服务机构 结构
DROP TABLE IF EXISTS `安监局_职业健康服务机构`;
CREATE TABLE IF NOT EXISTS `安监局_职业健康服务机构` (
  `企业名称` varchar(255) DEFAULT NULL,
  `劳动者总人数` varchar(255) DEFAULT NULL,
  `职业病累计人数` varchar(255) DEFAULT NULL,
  `接触危害总人数` varchar(255) DEFAULT NULL,
  `接触粉尘类人数` varchar(255) DEFAULT NULL,
  `接触化学性人数` varchar(255) DEFAULT NULL,
  `接触物理性人数` varchar(255) DEFAULT NULL,
  `接触放射性人数` varchar(255) DEFAULT NULL,
  `接触其他危害人数` varchar(255) DEFAULT NULL,
  `LXDH` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.安监局_职业健康服务机构 的数据：~0 rows (大约)
DELETE FROM `安监局_职业健康服务机构`;
/*!40000 ALTER TABLE `安监局_职业健康服务机构` DISABLE KEYS */;
/*!40000 ALTER TABLE `安监局_职业健康服务机构` ENABLE KEYS */;


-- 导出  表 xuzhou.房管局_中介经纪机构名册 结构
DROP TABLE IF EXISTS `房管局_中介经纪机构名册`;
CREATE TABLE IF NOT EXISTS `房管局_中介经纪机构名册` (
  `机构名称` varchar(255) DEFAULT NULL,
  `办公地址` varchar(255) DEFAULT NULL,
  `资质等级` varchar(255) DEFAULT NULL,
  `证书编号` varchar(255) DEFAULT NULL,
  `有效期限` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.房管局_中介经纪机构名册 的数据：~0 rows (大约)
DELETE FROM `房管局_中介经纪机构名册`;
/*!40000 ALTER TABLE `房管局_中介经纪机构名册` DISABLE KEYS */;
/*!40000 ALTER TABLE `房管局_中介经纪机构名册` ENABLE KEYS */;


-- 导出  表 xuzhou.房管局_估价机构名册 结构
DROP TABLE IF EXISTS `房管局_估价机构名册`;
CREATE TABLE IF NOT EXISTS `房管局_估价机构名册` (
  `企业名称` varchar(255) DEFAULT NULL,
  `项目名称` varchar(255) DEFAULT NULL,
  `预售证号` varchar(255) DEFAULT NULL,
  `规划用途` varchar(255) DEFAULT NULL,
  `核发日期` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.房管局_估价机构名册 的数据：~0 rows (大约)
DELETE FROM `房管局_估价机构名册`;
/*!40000 ALTER TABLE `房管局_估价机构名册` DISABLE KEYS */;
/*!40000 ALTER TABLE `房管局_估价机构名册` ENABLE KEYS */;


-- 导出  表 xuzhou.房管局_房地产估价师信息 结构
DROP TABLE IF EXISTS `房管局_房地产估价师信息`;
CREATE TABLE IF NOT EXISTS `房管局_房地产估价师信息` (
  `姓名` varchar(255) DEFAULT NULL,
  `性别` varchar(255) DEFAULT NULL,
  `注册号` varchar(255) DEFAULT NULL,
  `执业机构` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.房管局_房地产估价师信息 的数据：~0 rows (大约)
DELETE FROM `房管局_房地产估价师信息`;
/*!40000 ALTER TABLE `房管局_房地产估价师信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `房管局_房地产估价师信息` ENABLE KEYS */;


-- 导出  表 xuzhou.房管局_物业管理师信息 结构
DROP TABLE IF EXISTS `房管局_物业管理师信息`;
CREATE TABLE IF NOT EXISTS `房管局_物业管理师信息` (
  `姓名` varchar(255) DEFAULT NULL,
  `注册证书编号` varchar(255) DEFAULT NULL,
  `注册有效期` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.房管局_物业管理师信息 的数据：~0 rows (大约)
DELETE FROM `房管局_物业管理师信息`;
/*!40000 ALTER TABLE `房管局_物业管理师信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `房管局_物业管理师信息` ENABLE KEYS */;


-- 导出  表 xuzhou.残联_各类残疾人康复机构等级认证申报信息 结构
DROP TABLE IF EXISTS `残联_各类残疾人康复机构等级认证申报信息`;
CREATE TABLE IF NOT EXISTS `残联_各类残疾人康复机构等级认证申报信息` (
  `申报认证机构名称` varchar(255) DEFAULT NULL,
  `法人姓名` varchar(255) DEFAULT NULL,
  `联系电话` varchar(255) DEFAULT NULL,
  `地址` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.残联_各类残疾人康复机构等级认证申报信息 的数据：~0 rows (大约)
DELETE FROM `残联_各类残疾人康复机构等级认证申报信息`;
/*!40000 ALTER TABLE `残联_各类残疾人康复机构等级认证申报信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `残联_各类残疾人康复机构等级认证申报信息` ENABLE KEYS */;


-- 导出  表 xuzhou.法制办_执法监督人员名单 结构
DROP TABLE IF EXISTS `法制办_执法监督人员名单`;
CREATE TABLE IF NOT EXISTS `法制办_执法监督人员名单` (
  `姓名` varchar(255) DEFAULT NULL,
  `所属单位名称` varchar(255) DEFAULT NULL,
  `执法监督证号码` varchar(255) DEFAULT NULL,
  `发证日期` varchar(255) DEFAULT NULL,
  `发证机关` varchar(255) DEFAULT NULL,
  `执法监督种类` varchar(255) DEFAULT NULL,
  `执法监督区域` varchar(255) DEFAULT NULL,
  `F8` varchar(255) DEFAULT NULL,
  `F9` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法制办_执法监督人员名单 的数据：~0 rows (大约)
DELETE FROM `法制办_执法监督人员名单`;
/*!40000 ALTER TABLE `法制办_执法监督人员名单` DISABLE KEYS */;
/*!40000 ALTER TABLE `法制办_执法监督人员名单` ENABLE KEYS */;


-- 导出  表 xuzhou.法制办_行政复议 结构
DROP TABLE IF EXISTS `法制办_行政复议`;
CREATE TABLE IF NOT EXISTS `法制办_行政复议` (
  `姓名` varchar(255) DEFAULT NULL,
  `职务` varchar(255) DEFAULT NULL,
  `资格证号` varchar(255) DEFAULT NULL,
  `发证机关` varchar(255) DEFAULT NULL,
  `发证日期` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法制办_行政复议 的数据：~0 rows (大约)
DELETE FROM `法制办_行政复议`;
/*!40000 ALTER TABLE `法制办_行政复议` DISABLE KEYS */;
/*!40000 ALTER TABLE `法制办_行政复议` ENABLE KEYS */;


-- 导出  表 xuzhou.法制办_行政复议应诉人员 结构
DROP TABLE IF EXISTS `法制办_行政复议应诉人员`;
CREATE TABLE IF NOT EXISTS `法制办_行政复议应诉人员` (
  `资格证书编号` varchar(255) DEFAULT NULL,
  `姓名` varchar(255) DEFAULT NULL,
  `职务` varchar(255) DEFAULT NULL,
  `工作单位` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法制办_行政复议应诉人员 的数据：~0 rows (大约)
DELETE FROM `法制办_行政复议应诉人员`;
/*!40000 ALTER TABLE `法制办_行政复议应诉人员` DISABLE KEYS */;
/*!40000 ALTER TABLE `法制办_行政复议应诉人员` ENABLE KEYS */;


-- 导出  表 xuzhou.法院_失信被执行人名单 结构
DROP TABLE IF EXISTS `法院_失信被执行人名单`;
CREATE TABLE IF NOT EXISTS `法院_失信被执行人名单` (
  `姓名` varchar(255) DEFAULT NULL,
  `类型` varchar(255) DEFAULT NULL,
  `执行案号` varchar(255) DEFAULT NULL,
  `执行法院` varchar(255) DEFAULT NULL,
  `立案时间` varchar(255) DEFAULT NULL,
  `发布时间` varchar(255) DEFAULT NULL,
  `状态` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法院_失信被执行人名单 的数据：~0 rows (大约)
DELETE FROM `法院_失信被执行人名单`;
/*!40000 ALTER TABLE `法院_失信被执行人名单` DISABLE KEYS */;
/*!40000 ALTER TABLE `法院_失信被执行人名单` ENABLE KEYS */;


-- 导出  表 xuzhou.法院_执行案件汇总表 结构
DROP TABLE IF EXISTS `法院_执行案件汇总表`;
CREATE TABLE IF NOT EXISTS `法院_执行案件汇总表` (
  `案号` varchar(255) DEFAULT NULL,
  `案由` varchar(255) DEFAULT NULL,
  `立案日期` varchar(255) DEFAULT NULL,
  `受理法院` varchar(255) DEFAULT NULL,
  `立案标的` varchar(255) DEFAULT NULL,
  `结案日期` varchar(255) DEFAULT NULL,
  `结案方式` varchar(255) DEFAULT NULL,
  `执结标的` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法院_执行案件汇总表 的数据：~0 rows (大约)
DELETE FROM `法院_执行案件汇总表`;
/*!40000 ALTER TABLE `法院_执行案件汇总表` DISABLE KEYS */;
/*!40000 ALTER TABLE `法院_执行案件汇总表` ENABLE KEYS */;


-- 导出  表 xuzhou.法院_法官等级 结构
DROP TABLE IF EXISTS `法院_法官等级`;
CREATE TABLE IF NOT EXISTS `法院_法官等级` (
  `姓名` varchar(255) DEFAULT NULL,
  `性别` varchar(255) DEFAULT NULL,
  `等级` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.法院_法官等级 的数据：~0 rows (大约)
DELETE FROM `法院_法官等级`;
/*!40000 ALTER TABLE `法院_法官等级` DISABLE KEYS */;
/*!40000 ALTER TABLE `法院_法官等级` ENABLE KEYS */;


-- 导出  表 xuzhou.编办_事业单位法人设立登记信息 结构
DROP TABLE IF EXISTS `编办_事业单位法人设立登记信息`;
CREATE TABLE IF NOT EXISTS `编办_事业单位法人设立登记信息` (
  `单位名称（第一名称）` varchar(255) DEFAULT NULL,
  `单位名称（其他名称）` varchar(255) DEFAULT NULL,
  `住所` varchar(255) DEFAULT NULL,
  `举办单位` varchar(255) DEFAULT NULL,
  `举办单位类型` varchar(255) DEFAULT NULL,
  `经费来源` varchar(255) DEFAULT NULL,
  `补充经费来源` varchar(255) DEFAULT NULL,
  `开办资金` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.编办_事业单位法人设立登记信息 的数据：~0 rows (大约)
DELETE FROM `编办_事业单位法人设立登记信息`;
/*!40000 ALTER TABLE `编办_事业单位法人设立登记信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `编办_事业单位法人设立登记信息` ENABLE KEYS */;


-- 导出  表 xuzhou.编办_事业单位法定代表人信息 结构
DROP TABLE IF EXISTS `编办_事业单位法定代表人信息`;
CREATE TABLE IF NOT EXISTS `编办_事业单位法定代表人信息` (
  `单位名称` varchar(255) DEFAULT NULL,
  `姓名` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.编办_事业单位法定代表人信息 的数据：~0 rows (大约)
DELETE FROM `编办_事业单位法定代表人信息`;
/*!40000 ALTER TABLE `编办_事业单位法定代表人信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `编办_事业单位法定代表人信息` ENABLE KEYS */;


-- 导出  表 xuzhou.编办_单位基本情况信息 结构
DROP TABLE IF EXISTS `编办_单位基本情况信息`;
CREATE TABLE IF NOT EXISTS `编办_单位基本情况信息` (
  `单位名称` varchar(255) DEFAULT NULL,
  `主管单位名称` varchar(255) DEFAULT NULL,
  `单位分类` varchar(255) DEFAULT NULL,
  `单位成立批准文号` varchar(255) DEFAULT NULL,
  `单位成立批准机关` varchar(255) DEFAULT NULL,
  `单位地址` varchar(255) DEFAULT NULL,
  `经费来源` varchar(255) DEFAULT NULL,
  `事证号` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.编办_单位基本情况信息 的数据：~0 rows (大约)
DELETE FROM `编办_单位基本情况信息`;
/*!40000 ALTER TABLE `编办_单位基本情况信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `编办_单位基本情况信息` ENABLE KEYS */;


-- 导出  表 xuzhou.编办_慧徐州-编制信息 结构
DROP TABLE IF EXISTS `编办_慧徐州-编制信息`;
CREATE TABLE IF NOT EXISTS `编办_慧徐州-编制信息` (
  `姓名` varchar(255) DEFAULT NULL,
  `个人身份` varchar(255) DEFAULT NULL,
  `住所进入本单位工作时间` varchar(255) DEFAULT NULL,
  `在编类型` varchar(255) DEFAULT NULL,
  `单位名称` varchar(255) DEFAULT NULL,
  `单位` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  xuzhou.编办_慧徐州-编制信息 的数据：~0 rows (大约)
DELETE FROM `编办_慧徐州-编制信息`;
/*!40000 ALTER TABLE `编办_慧徐州-编制信息` DISABLE KEYS */;
/*!40000 ALTER TABLE `编办_慧徐州-编制信息` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
