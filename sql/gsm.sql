-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.13 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 xmaster.bd_gsmdataset 结构
DROP TABLE IF EXISTS `bd_gsmdataset`;
CREATE TABLE IF NOT EXISTS `bd_gsmdataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `description` varchar(500) DEFAULT NULL,
  `upload_user_id` int(11) DEFAULT NULL COMMENT '上传者ID',
  `audit_user_id` int(11) DEFAULT NULL COMMENT '审核者ID',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `deleted_mark` int(11) NOT NULL DEFAULT '2' COMMENT '标记删除',
  `meta_created` datetime NOT NULL COMMENT '创建时间',
  `meta_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='手机信令数据集';

-- 正在导出表  xmaster.bd_gsmdataset 的数据：~0 rows (大约)
DELETE FROM `bd_gsmdataset`;
/*!40000 ALTER TABLE `bd_gsmdataset` DISABLE KEYS */;
/*!40000 ALTER TABLE `bd_gsmdataset` ENABLE KEYS */;


-- 导出  表 xmaster.bd_gsmrecord 结构
DROP TABLE IF EXISTS `bd_gsmrecord`;
CREATE TABLE IF NOT EXISTS `bd_gsmrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dataset_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据集ID',
  `type` int(11) DEFAULT NULL COMMENT '手机信令类型',
  `time` datetime DEFAULT NULL COMMENT '记录时间',
  `subject` int(11) DEFAULT NULL COMMENT '主叫ID',
  `object` int(11) DEFAULT NULL COMMENT '被叫ID',
  `lng` double DEFAULT NULL COMMENT '经度',
  `lat` double DEFAULT NULL COMMENT '纬度',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `deleted_mark` int(11) NOT NULL DEFAULT '1' COMMENT '标记删除',
  `meta_created` datetime NOT NULL COMMENT '创建时间',
  `meta_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='手机信令数据';

-- 正在导出表  xmaster.bd_gsmrecord 的数据：~0 rows (大约)
DELETE FROM `bd_gsmrecord`;
/*!40000 ALTER TABLE `bd_gsmrecord` DISABLE KEYS */;
INSERT INTO `bd_gsmrecord` (`id`, `dataset_id`, `type`, `time`, `subject`, `object`, `lng`, `lat`, `remark`, `deleted_mark`, `meta_created`, `meta_updated`) VALUES
	(1, 0, 1, '2016-10-06 15:21:15', 1, 2, 117.117, 39.39, '测试数据', 1, '2016-10-02 15:21:27', '2016-10-06 15:21:26');
/*!40000 ALTER TABLE `bd_gsmrecord` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
