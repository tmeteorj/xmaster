/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : xmaster

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2016-09-28 15:01:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ly_buttom
-- ----------------------------
DROP TABLE IF EXISTS `ly_buttom`;
CREATE TABLE `ly_buttom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `buttom` varchar(200) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_buttom
-- ----------------------------
INSERT INTO `ly_buttom` VALUES ('1', '新增', '<button type=\"button\" id=\"addFun\" class=\"btn btn-primary marR10\">新增</button>', '');
INSERT INTO `ly_buttom` VALUES ('2', '编辑', '<button type=\"button\" id=\"editFun\" class=\"btn btn-info marR10\">编辑</button>', null);
INSERT INTO `ly_buttom` VALUES ('3', '删除', '<button type=\"button\" id=\"delFun\" class=\"btn btn-danger marR10\">删除</button>', null);
INSERT INTO `ly_buttom` VALUES ('4', '上传', '<button type=\"button\" id=\"upLoad\" class=\"btn btn-primary marR10\">上传</button>', null);
INSERT INTO `ly_buttom` VALUES ('5', '下载', '<button type=\"button\" id=\"downLoad\" class=\"btn btn-primary marR10\">下载</button>', null);
INSERT INTO `ly_buttom` VALUES ('6', '上移', '<button type=\"button\" id=\"lyGridUp\" class=\"btn btn-success marR10\">上移</button>', null);
INSERT INTO `ly_buttom` VALUES ('7', '下移', '<button type=\"button\" id=\"lyGridDown\" class=\"btn btn btn-grey marR10\">下移</button>', null);
INSERT INTO `ly_buttom` VALUES ('8', '分配权限', '<button type=\"button\" id=\"permissions\" class=\"btn btn btn-grey marR10\">分配权限</button>', null);

-- ----------------------------
-- Table structure for ly_log
-- ----------------------------
DROP TABLE IF EXISTS `ly_log`;
CREATE TABLE `ly_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountName` varchar(30) DEFAULT NULL,
  `module` varchar(30) DEFAULT NULL,
  `methods` varchar(30) DEFAULT NULL,
  `actionTime` varchar(30) DEFAULT NULL,
  `userIP` varchar(30) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_log
-- ----------------------------

-- ----------------------------
-- Table structure for ly_resources
-- ----------------------------
DROP TABLE IF EXISTS `ly_resources`;
CREATE TABLE `ly_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `resKey` varchar(50) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `resUrl` varchar(200) DEFAULT NULL,
  `level` int(4) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `ishide` int(3) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_resources
-- ----------------------------
INSERT INTO `ly_resources` VALUES ('1', '系统基础管理', '0', 'system', '0', 'system', '1', 'fa-desktop', '0', '系统基础管理');
INSERT INTO `ly_resources` VALUES ('2', '用户管理', '1', 'account', '1', '/user/list.shtml', '2', null, '0', null);
INSERT INTO `ly_resources` VALUES ('3', '角色管理', '1', 'role', '1', '/role/list.shtml', '7', 'fa-list', '0', '组管理');
INSERT INTO `ly_resources` VALUES ('4', '菜单管理', '1', 'ly_resources', '1', '/resources/list.shtml', '12', 'fa-list-alt', '0', '菜单管理');
INSERT INTO `ly_resources` VALUES ('5', '新增用户', '2', 'account_add', '2', '/user/addUI.shtml', '3', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('6', '修改用户', '2', 'account_edit', '2', '/user/editUI.shtml', '4', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('7', '删除用户', '2', 'account_delete', '2', '/user/deleteById.shtml', '5', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delAccount&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('8', '新增角色', '3', 'role_add', '2', '/role/addUI.shtml', '8', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addRole&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('9', '修改角色', '3', 'role_edit', '2', '/role/editUI.shtml', '9', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editRole&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('10', '删除角色', '3', 'role_delete', '2', '/role/delete.shtml', '10', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delRole&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('11', '分配权限', '3', 'role_perss', '2', '/resources/permissions.shtml', '11', '无', '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;permissions&quot;&nbsp;class=&quot;btn&nbsp;btn&nbsp;btn-grey&nbsp;marR10&quot;&gt;分配权限&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('25', '登陆信息管理', '0', 'ly_login', '0', 'ly_login', '18', 'fa-calendar', '0', '登陆信息管理');
INSERT INTO `ly_resources` VALUES ('26', '用户登录记录', '25', 'ly_log_list', '1', '/userlogin/listUI.shtml', '19', null, '0', '用户登录记录');
INSERT INTO `ly_resources` VALUES ('27', '操作日志管理', '0', 'ly_log', '0', 'ly_log', '20', 'fa-picture-o', '1', '操作日志管理');
INSERT INTO `ly_resources` VALUES ('28', '日志查询', '27', 'ly_log', '1', '/log/list.shtml', '21', null, '0', null);
INSERT INTO `ly_resources` VALUES ('29', '新增菜单资源', '4', 'ly_resources_add', '2', '/resources/addUI.shtml', '13', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;addFun&quot;&nbsp;class=&quot;btn&nbsp;btn-primary&nbsp;marR10&quot;&gt;新增&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('30', '修改菜单资源', '4', 'ly_resources_edit', '2', '/resources/editUI.shtml', '14', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;editFun&quot;&nbsp;class=&quot;btn&nbsp;btn-info&nbsp;marR10&quot;&gt;编辑&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('31', '删除菜单资源', '4', 'ly_resources_delete', '2', '/resources/delete.shtml', '15', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;delFun&quot;&nbsp;class=&quot;btn&nbsp;btn-danger&nbsp;marR10&quot;&gt;删除&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('32', '系统监控管理', '0', 'monitor', '0', 'monitor', '16', 'fa-tag', '0', '系统监控管理');
INSERT INTO `ly_resources` VALUES ('33', '实时监控', '32', 'sysmonitor', '1', '/monitor/monitor.shtml', '17', null, '0', '实时监控');
INSERT INTO `ly_resources` VALUES ('34', '分配权限', '2', 'permissions', '2', '/resources/permissions.shtml', '6', null, '0', '&lt;button&nbsp;type=&quot;button&quot;&nbsp;id=&quot;permissions&quot;&nbsp;class=&quot;btn&nbsp;btn&nbsp;btn-grey&nbsp;marR10&quot;&gt;分配权限&lt;/button&gt;');
INSERT INTO `ly_resources` VALUES ('35', '告警列表', '32', 'monitor_warn', '1', '/monitor/list.shtml', null, null, '0', '告警列表');
INSERT INTO `ly_resources` VALUES ('37', '资源上传', '0', 'resource_upload', '0', 'resourceupload', null, 'fa-glass', '0', '资源上传');
INSERT INTO `ly_resources` VALUES ('38', '数据集上传', '37', 'dataset_upload', '1', '/resourceupload/datasetupload.shtml', null, null, '0', '数据集上传');
INSERT INTO `ly_resources` VALUES ('39', '数据集审核', '37', 'dataset_audit', '1', '/resourceupload/datasetaudit.shtml', null, null, '0', '数据集审核');
INSERT INTO `ly_resources` VALUES ('40', '资源管理', '0', 'resource_manage', '0', 'resourcemanage', null, 'fa-inbox', '0', '资源管理');
INSERT INTO `ly_resources` VALUES ('41', '数据集管理', '40', 'dataset_manage', '1', '/resourcemanage/datasetmanage.shtml', null, null, '0', '数据集管理');
INSERT INTO `ly_resources` VALUES ('42', '元数据管理', '40', 'metadata_manage', '1', '/resourcemanage/metadatamanage.shtml', null, null, '0', '元数据管理');
INSERT INTO `ly_resources` VALUES ('43', '匿名搜索', '0', 'search', '0', 'search', null, 'fa-search-minus', '0', '匿名搜索');
INSERT INTO `ly_resources` VALUES ('44', '感知搜索', '43', 'perceptual_search', '1', 'perceptual_search', null, null, '0', '感知搜索');
INSERT INTO `ly_resources` VALUES ('45', '数据集搜索 ', '43', 'dataset_search', '1', 'dataset_search', null, null, '0', '数据集搜索 ');
INSERT INTO `ly_resources` VALUES ('46', '结构化检查', '43', 'structured_search', '1', 'structured_search', null, null, '0', '结构化检查');
INSERT INTO `ly_resources` VALUES ('47', '地名搜索', '43', 'placename_search', '1', 'placename_search', null, null, '0', '地名搜索');
INSERT INTO `ly_resources` VALUES ('48', '语义搜索', '43', 'semantic_search', '1', 'semantic_search', null, null, '0', '语义搜索');
INSERT INTO `ly_resources` VALUES ('49', '全文搜索', '43', 'fulltext_search', '1', 'fulltext_search', null, null, '0', '全文搜索');

-- ----------------------------
-- Table structure for ly_res_user
-- ----------------------------
DROP TABLE IF EXISTS `ly_res_user`;
CREATE TABLE `ly_res_user` (
  `resId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`resId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_res_user
-- ----------------------------
INSERT INTO `ly_res_user` VALUES ('1', '4');
INSERT INTO `ly_res_user` VALUES ('2', '4');
INSERT INTO `ly_res_user` VALUES ('3', '4');
INSERT INTO `ly_res_user` VALUES ('4', '4');
INSERT INTO `ly_res_user` VALUES ('5', '4');
INSERT INTO `ly_res_user` VALUES ('6', '4');
INSERT INTO `ly_res_user` VALUES ('7', '4');
INSERT INTO `ly_res_user` VALUES ('8', '4');
INSERT INTO `ly_res_user` VALUES ('9', '4');
INSERT INTO `ly_res_user` VALUES ('10', '4');
INSERT INTO `ly_res_user` VALUES ('11', '4');
INSERT INTO `ly_res_user` VALUES ('25', '4');
INSERT INTO `ly_res_user` VALUES ('26', '4');
INSERT INTO `ly_res_user` VALUES ('27', '4');
INSERT INTO `ly_res_user` VALUES ('28', '4');
INSERT INTO `ly_res_user` VALUES ('29', '4');
INSERT INTO `ly_res_user` VALUES ('30', '4');
INSERT INTO `ly_res_user` VALUES ('31', '4');
INSERT INTO `ly_res_user` VALUES ('32', '4');
INSERT INTO `ly_res_user` VALUES ('33', '4');
INSERT INTO `ly_res_user` VALUES ('34', '4');
INSERT INTO `ly_res_user` VALUES ('35', '4');
INSERT INTO `ly_res_user` VALUES ('37', '4');
INSERT INTO `ly_res_user` VALUES ('38', '4');
INSERT INTO `ly_res_user` VALUES ('39', '4');
INSERT INTO `ly_res_user` VALUES ('40', '4');
INSERT INTO `ly_res_user` VALUES ('41', '4');
INSERT INTO `ly_res_user` VALUES ('42', '4');
INSERT INTO `ly_res_user` VALUES ('43', '4');
INSERT INTO `ly_res_user` VALUES ('44', '4');
INSERT INTO `ly_res_user` VALUES ('45', '4');
INSERT INTO `ly_res_user` VALUES ('46', '4');
INSERT INTO `ly_res_user` VALUES ('47', '4');
INSERT INTO `ly_res_user` VALUES ('48', '4');
INSERT INTO `ly_res_user` VALUES ('49', '4');
INSERT INTO `ly_res_user` VALUES ('1', '5');
INSERT INTO `ly_res_user` VALUES ('2', '5');
INSERT INTO `ly_res_user` VALUES ('3', '5');
INSERT INTO `ly_res_user` VALUES ('4', '5');
INSERT INTO `ly_res_user` VALUES ('5', '5');
INSERT INTO `ly_res_user` VALUES ('6', '5');
INSERT INTO `ly_res_user` VALUES ('7', '5');
INSERT INTO `ly_res_user` VALUES ('8', '5');
INSERT INTO `ly_res_user` VALUES ('9', '5');
INSERT INTO `ly_res_user` VALUES ('10', '5');
INSERT INTO `ly_res_user` VALUES ('11', '5');
INSERT INTO `ly_res_user` VALUES ('25', '5');
INSERT INTO `ly_res_user` VALUES ('26', '5');
INSERT INTO `ly_res_user` VALUES ('27', '5');
INSERT INTO `ly_res_user` VALUES ('28', '5');
INSERT INTO `ly_res_user` VALUES ('29', '5');
INSERT INTO `ly_res_user` VALUES ('30', '5');
INSERT INTO `ly_res_user` VALUES ('31', '5');
INSERT INTO `ly_res_user` VALUES ('32', '5');
INSERT INTO `ly_res_user` VALUES ('33', '5');
INSERT INTO `ly_res_user` VALUES ('34', '5');
INSERT INTO `ly_res_user` VALUES ('35', '5');
INSERT INTO `ly_res_user` VALUES ('37', '5');
INSERT INTO `ly_res_user` VALUES ('38', '5');
INSERT INTO `ly_res_user` VALUES ('39', '5');
INSERT INTO `ly_res_user` VALUES ('40', '5');
INSERT INTO `ly_res_user` VALUES ('41', '5');
INSERT INTO `ly_res_user` VALUES ('42', '5');
INSERT INTO `ly_res_user` VALUES ('43', '5');
INSERT INTO `ly_res_user` VALUES ('44', '5');
INSERT INTO `ly_res_user` VALUES ('45', '5');
INSERT INTO `ly_res_user` VALUES ('46', '5');
INSERT INTO `ly_res_user` VALUES ('47', '5');
INSERT INTO `ly_res_user` VALUES ('48', '5');
INSERT INTO `ly_res_user` VALUES ('49', '5');
INSERT INTO `ly_res_user` VALUES ('40', '6');
INSERT INTO `ly_res_user` VALUES ('41', '6');
INSERT INTO `ly_res_user` VALUES ('42', '6');
INSERT INTO `ly_res_user` VALUES ('37', '7');
INSERT INTO `ly_res_user` VALUES ('39', '7');
INSERT INTO `ly_res_user` VALUES ('43', '8');
INSERT INTO `ly_res_user` VALUES ('44', '8');
INSERT INTO `ly_res_user` VALUES ('45', '8');
INSERT INTO `ly_res_user` VALUES ('46', '8');
INSERT INTO `ly_res_user` VALUES ('47', '8');
INSERT INTO `ly_res_user` VALUES ('48', '8');
INSERT INTO `ly_res_user` VALUES ('49', '8');
INSERT INTO `ly_res_user` VALUES ('37', '9');
INSERT INTO `ly_res_user` VALUES ('38', '9');

-- ----------------------------
-- Table structure for ly_role
-- ----------------------------
DROP TABLE IF EXISTS `ly_role`;
CREATE TABLE `ly_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `state` varchar(3) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `roleKey` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_role
-- ----------------------------
INSERT INTO `ly_role` VALUES ('1', '0', '平台管理者', 'platform_manager', '平台管理者');
INSERT INTO `ly_role` VALUES ('3', '0', '超级管理员', 'SUPER', '超级管理员');
INSERT INTO `ly_role` VALUES ('4', '0', '匿名搜索者', 'visitor', '匿名搜索者');
INSERT INTO `ly_role` VALUES ('5', '0', '应用请求者', 'application_requester', '应用请求者');
INSERT INTO `ly_role` VALUES ('6', '0', '应用管理者', 'application_manager', '应用管理者');
INSERT INTO `ly_role` VALUES ('7', '0', '应用提供者', 'application_provider', '应用提供者');
INSERT INTO `ly_role` VALUES ('8', '0', '平台监控者', 'platform_monitor', '平台监控者');
INSERT INTO `ly_role` VALUES ('9', '0', '资源管理者', 'resource_manager', '资源管理者');
INSERT INTO `ly_role` VALUES ('10', '0', '资源审核者', 'resource_auditor', '资源审核者');
INSERT INTO `ly_role` VALUES ('11', '0', '资源提供者', 'resource_provider', '资源提供者');

-- ----------------------------
-- Table structure for ly_server_info
-- ----------------------------
DROP TABLE IF EXISTS `ly_server_info`;
CREATE TABLE `ly_server_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cpuUsage` varchar(255) DEFAULT NULL,
  `setCpuUsage` varchar(255) DEFAULT NULL,
  `jvmUsage` varchar(255) DEFAULT NULL,
  `setJvmUsage` varchar(255) DEFAULT NULL,
  `ramUsage` varchar(255) DEFAULT NULL,
  `setRamUsage` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_server_info
-- ----------------------------
INSERT INTO `ly_server_info` VALUES ('5', '18', '40', '49', '40', '71', '40', '121261494@qq.com', '2015-04-25 18:07:02', '<font color=\"red\">JVM当前：49%,超出预设值 40%<br>内存当前：71%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('6', '3', '40', '50', '40', '71', '40', '121261494@qq.com', '2015-04-25 18:08:03', '<font color=\"red\">JVM当前：50%,超出预设值 40%<br>内存当前：71%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('7', '5', '40', '50', '40', '70', '40', '121261494@qq.com', '2015-04-25 18:09:02', '<font color=\"red\">JVM当前：50%,超出预设值 40%<br>内存当前：70%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('8', '5', '40', '52', '40', '69', '40', '121261494@qq.com', '2015-04-25 18:10:03', '<font color=\"red\">JVM当前：52%,超出预设值 40%<br>内存当前：69%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('9', '2', '40', '52', '40', '68', '40', '121261494@qq.com', '2015-04-25 18:11:02', '<font color=\"red\">JVM当前：52%,超出预设值 40%<br>内存当前：68%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('10', '7', '40', '53', '40', '67', '40', '121261494@qq.com', '2015-04-25 18:12:02', '<font color=\"red\">JVM当前：53%,超出预设值 40%<br>内存当前：67%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('11', '5', '40', '54', '40', '67', '40', '121261494@qq.com', '2015-04-25 18:13:02', '<font color=\"red\">JVM当前：54%,超出预设值 40%<br>内存当前：67%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('12', '16', '40', '55', '40', '66', '40', '121261494@qq.com', '2015-04-25 18:14:02', '<font color=\"red\">JVM当前：55%,超出预设值 40%<br>内存当前：66%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('13', '5', '40', '56', '40', '65', '40', '121261494@qq.com', '2015-04-25 18:15:02', '<font color=\"red\">JVM当前：56%,超出预设值 40%<br>内存当前：65%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('14', '8', '40', '57', '40', '64', '40', '121261494@qq.com', '2015-04-25 18:16:02', '<font color=\"red\">JVM当前：57%,超出预设值 40%<br>内存当前：64%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('15', '3', '40', '58', '40', '63', '40', '121261494@qq.com', '2015-04-25 18:17:02', '<font color=\"red\">JVM当前：58%,超出预设值 40%<br>内存当前：63%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('16', '6', '40', '59', '40', '62', '40', '121261494@qq.com', '2015-04-25 18:18:03', '<font color=\"red\">JVM当前：59%,超出预设值 40%<br>内存当前：62%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('17', '1', '40', '60', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:19:02', '<font color=\"red\">JVM当前：60%,超出预设值 40%<br>内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('18', '5', '40', '61', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:20:02', '<font color=\"red\">JVM当前：61%,超出预设值 40%<br>内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('19', '5', '40', '38', '40', '61', '40', '121261494@qq.com', '2015-04-25 18:21:02', '<font color=\"red\">内存当前：61%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('20', '5', '40', '39', '40', '60', '40', '121261494@qq.com', '2015-04-25 18:22:02', '<font color=\"red\">内存当前：60%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('21', '4', '40', '40', '40', '59', '40', '121261494@qq.com', '2015-04-25 18:23:02', '<font color=\"red\">内存当前：59%,超出预设值  40%</font>');
INSERT INTO `ly_server_info` VALUES ('22', '32', '80', '41', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:43:05', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('23', '55', '80', '55', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:50:03', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('24', '13', '80', '53', '80', '81', '80', '121261494@qq.com', '2015-04-26 01:59:08', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('25', '85', '80', '58', '80', '72', '80', '121261494@qq.com', '2015-04-26 02:46:06', '<font color=\"red\">CPU当前：85%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('26', '34', '80', '59', '80', '81', '80', '121261494@qq.com', '2015-04-27 00:29:06', '<font color=\"red\">内存当前：81%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('27', '92', '80', '47', '80', '64', '80', '121261494@qq.com', '2015-04-27 00:44:07', '<font color=\"red\">CPU当前：92%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('28', '85', '80', '49', '80', '68', '80', '121261494@qq.com', '2015-04-27 23:38:04', '<font color=\"red\">CPU当前：85%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('29', '94', '80', '69', '80', '73', '80', '121261494@qq.com', '2015-04-28 01:35:03', '<font color=\"red\">CPU当前：94%,超出预设值  80%<br></font>');
INSERT INTO `ly_server_info` VALUES ('30', '6', '80', '43', '80', '87', '80', '121261494@qq.com', '2015-05-09 00:00:08', '<font color=\"red\">内存当前：87%,超出预设值  80%</font>');
INSERT INTO `ly_server_info` VALUES ('31', '88', '80', '59', '80', '87', '80', '121261494@qq.com', '2015-05-09 00:01:14', '<font color=\"red\">CPU当前：88%,超出预设值  80%<br>内存当前：87%,超出预设值  80%</font>');

-- ----------------------------
-- Table structure for ly_user
-- ----------------------------
DROP TABLE IF EXISTS `ly_user`;
CREATE TABLE `ly_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `credentialsSalt` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `locked` varchar(3) DEFAULT '0',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletestatus` int(1) DEFAULT '0' COMMENT '逻辑删除状态0:存在1:删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_user
-- ----------------------------
INSERT INTO `ly_user` VALUES ('4', 'npt', 'npt', '4cb708ca19dbc510e9e4ad172d33ec03', '46f4aae8ab90317d001c803b63b34185', null, '0', '2016-09-26 17:39:22', '0');
INSERT INTO `ly_user` VALUES ('5', 'lx一号:平台管理者', 'lx1', '7e65746ec84e1e9a419a65737274c4ce', '3eea32364613ee64c774d8532130f81f', null, '0', '2016-09-26 20:13:19', '0');
INSERT INTO `ly_user` VALUES ('6', 'lx二号:资源管理者', 'lx2', 'dd21cd227fc9b971c6ae1f8741794777', '665ce1ee70347865c7b549ebbda89ead', null, '0', '2016-09-26 20:26:46', '0');
INSERT INTO `ly_user` VALUES ('7', 'lx三号:资源管理者', 'lx3', '40869eb27a07be5aadf32151598c06d4', '4ce003fc9b34f88582ae462dee3b71ef', null, '0', '2016-09-26 20:27:02', '0');
INSERT INTO `ly_user` VALUES ('8', '游客', 'visitor', '9b6d993a05b6e483e07a5b236f3859d0', '873607ae7ab9e07779327cd96f1a8fec', null, '0', '2016-09-26 22:18:42', '0');
INSERT INTO `ly_user` VALUES ('9', 'lx四号:资源提供者', 'lx4', 'd4558544081b47c95ca7023c7bfeb2b6', 'e5f5a8827749f11e7cfd6298113d81ad', null, '0', '2016-09-26 20:27:55', '0');

-- ----------------------------
-- Table structure for ly_userlogin
-- ----------------------------
DROP TABLE IF EXISTS `ly_userlogin`;
CREATE TABLE `ly_userlogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `loginTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginIP` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_loginlist` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_userlogin
-- ----------------------------
INSERT INTO `ly_userlogin` VALUES ('143', '3', 'admin', '2016-09-26 17:29:35', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('144', '3', 'admin', '2016-09-26 17:32:28', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('145', '3', 'admin', '2016-09-26 17:33:15', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('146', '3', 'admin', '2016-09-26 17:38:40', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('147', '4', 'npt', '2016-09-26 17:39:38', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('148', '3', 'admin', '2016-09-26 17:40:22', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('149', '4', 'npt', '2016-09-26 17:41:03', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('150', '4', 'npt', '2016-09-26 17:56:55', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('151', '4', 'npt', '2016-09-26 18:05:53', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('152', '4', 'npt', '2016-09-26 20:10:31', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('153', '8', 'visitor', '2016-09-26 21:00:04', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('154', '8', 'visitor', '2016-09-26 21:42:29', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('155', '5', 'lx1', '2016-09-26 21:45:27', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('156', '5', 'lx1', '2016-09-26 22:09:03', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('157', '8', 'visitor', '2016-09-26 22:14:18', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('158', '8', 'visitor', '2016-09-26 22:18:27', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('159', '8', 'visitor', '2016-09-26 22:18:51', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('160', null, 'visitor', '2016-09-26 22:19:15', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('161', null, 'visitor', '2016-09-26 22:19:26', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('162', null, 'visitor', '2016-09-26 22:19:40', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('163', null, 'visitor', '2016-09-26 22:19:51', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('164', null, 'visitor', '2016-09-26 22:20:02', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('165', null, 'visitor', '2016-09-26 22:20:42', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('166', '5', 'lx1', '2016-09-26 22:21:14', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('167', null, 'visitor', '2016-09-26 22:21:24', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('168', null, 'visitor', '2016-09-26 22:22:28', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('169', null, 'visitor', '2016-09-26 22:26:05', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('170', '5', 'lx1', '2016-09-26 22:28:56', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('171', '5', 'lx1', '2016-09-26 22:28:56', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('172', '5', 'lx1', '2016-09-26 22:28:56', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('173', '8', 'visitor', '2016-09-26 22:32:32', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('174', '8', 'visitor', '2016-09-26 22:38:21', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('175', '5', 'lx1', '2016-09-26 22:38:26', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('176', '5', 'lx1', '2016-09-28 10:51:18', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('177', '5', 'lx1', '2016-09-28 11:10:49', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('178', '5', 'lx1', '2016-09-28 11:16:12', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('179', '5', 'lx1', '2016-09-28 11:18:50', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('180', '5', 'lx1', '2016-09-28 11:23:12', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('181', '5', 'lx1', '2016-09-28 11:43:11', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('182', '5', 'lx1', '2016-09-28 11:48:52', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('183', '5', 'lx1', '2016-09-28 11:53:05', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('184', '5', 'lx1', '2016-09-28 11:56:31', '127.0.0.1');
INSERT INTO `ly_userlogin` VALUES ('185', '5', 'lx1', '2016-09-28 12:13:29', '127.0.0.1');

-- ----------------------------
-- Table structure for ly_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ly_user_role`;
CREATE TABLE `ly_user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ly_user_role
-- ----------------------------
INSERT INTO `ly_user_role` VALUES ('4', '3');
INSERT INTO `ly_user_role` VALUES ('5', '1');
INSERT INTO `ly_user_role` VALUES ('6', '9');
INSERT INTO `ly_user_role` VALUES ('7', '10');
INSERT INTO `ly_user_role` VALUES ('8', '4');
INSERT INTO `ly_user_role` VALUES ('9', '11');
