/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-11-17 17:38:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cp_article
-- ----------------------------
DROP TABLE IF EXISTS `cp_article`;
CREATE TABLE `cp_article` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `excerpt` varchar(200) NOT NULL DEFAULT '' COMMENT '文章摘要',
  `content` longtext NOT NULL COMMENT '文章内容',
  `img` varchar(150) NOT NULL DEFAULT '' COMMENT '文章图片路径',
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '文章标题',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:未审核 1：已审核',
  `comment_status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许评论 1：允许 0：不允许',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章更新时间',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击数（查看数）',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否置顶 1：置顶 0：不置顶',
  `praise` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `recommended` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否推荐 1：推荐 0：不推荐',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT '搜索文章的关键字',
  `users_uid` int(11) NOT NULL COMMENT '发布者的ID',
  `is_recycle` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否回收 1：回收  0：不回收',
  `cid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  PRIMARY KEY (`aid`),
  KEY `fk_cp_article_cp_users1_idx` (`users_uid`),
  KEY `cid` (`cid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of cp_article
-- ----------------------------

-- ----------------------------
-- Table structure for cp_article_tags
-- ----------------------------
DROP TABLE IF EXISTS `cp_article_tags`;
CREATE TABLE `cp_article_tags` (
  `cp_tags_tid` int(10) unsigned NOT NULL,
  `cp_article_aid` int(10) unsigned NOT NULL,
  KEY `fk_table2_cp_article1_idx` (`cp_article_aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章和标签的中中间关联表';

-- ----------------------------
-- Records of cp_article_tags
-- ----------------------------

-- ----------------------------
-- Table structure for cp_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `cp_auth_group`;
CREATE TABLE `cp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'status 状态：为1正常，为0禁用',
  `rules` varchar(200) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of cp_auth_group
-- ----------------------------
INSERT INTO `cp_auth_group` VALUES ('1', '超级管理员', '1', '1,2,5,6,7,8,9,10,3,11,12,13,14,15,16,17,18,36,37,38,39,4,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,40');
INSERT INTO `cp_auth_group` VALUES ('2', '管理员', '1', '1,2,8,9,10,3,11,12,13,14,15,16,17,18,36,37,38,39,23,24');

-- ----------------------------
-- Table structure for cp_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `cp_auth_group_access`;
CREATE TABLE `cp_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL COMMENT '后台用户ID',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户和用户组的中间表';

-- ----------------------------
-- Records of cp_auth_group_access
-- ----------------------------
INSERT INTO `cp_auth_group_access` VALUES ('1', '1');
INSERT INTO `cp_auth_group_access` VALUES ('29', '2');
INSERT INTO `cp_auth_group_access` VALUES ('30', '2');
INSERT INTO `cp_auth_group_access` VALUES ('31', '2');

-- ----------------------------
-- Table structure for cp_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cp_auth_rule`;
CREATE TABLE `cp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识 列如：Admin/User/index 模块/控制器/方法',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父类规则ID',
  `condition` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of cp_auth_rule
-- ----------------------------
INSERT INTO `cp_auth_rule` VALUES ('1', 'Admin/Index/index', '后台欢迎页', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('2', 'Admin/Users', '用户管理', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('3', 'Admin/Contents', '内容管理', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('4', 'Admin/Web', '网站设置', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('5', 'Admin/Users/originalUser', '本地用户', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('6', 'Admin/Users/foreignUser', '第三方用户', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('7', 'Admin/Users/LablackUser', 'ajax用户拉黑', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('8', 'Admin/Users/editPassword', '修改密码', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('9', 'Admin/Users/editFace', '修改头像[列表]', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('10', 'Admin/Users/send_FaceUpload', 'ajax修改头像', '1', '2', '');
INSERT INTO `cp_auth_rule` VALUES ('11', 'Admin/Contents/comment', '评论管理', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('12', 'Admin/Contents/del_comment', 'ajax删除评论', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('13', 'Admin/Contents/article', '文章管理', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('14', 'Admin/Contents/tags', '添加|编辑 标签', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('15', 'Admin/Contents/del_tags', 'ajax删除标签信息', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('16', 'Admin/Contents/category', '分类管理', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('17', 'Admin/Contents/add_cate', '添加分类 | 编辑分类', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('18', 'Admin/Contents/del_cate', 'ajax异步删除分类信息', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('19', 'Admin/Web/mailbox', '邮箱设置', '1', '4', '');
INSERT INTO `cp_auth_rule` VALUES ('20', 'Admin/Web/mailbox_tmp', '邮箱模板', '1', '4', '');
INSERT INTO `cp_auth_rule` VALUES ('21', 'Admin/Web/web_info', '网站信息', '1', '4', '');
INSERT INTO `cp_auth_rule` VALUES ('22', 'Admin/Web/future', '第三方登录', '1', '4', '');
INSERT INTO `cp_auth_rule` VALUES ('23', 'Admin/Trash/index', '回收站', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('24', 'Admin/Trash/do_Trash', 'ajax处理回收', '1', '23', '');
INSERT INTO `cp_auth_rule` VALUES ('25', 'Admin/Auth', 'AUTH权限管理', '1', '0', '');
INSERT INTO `cp_auth_rule` VALUES ('26', 'Admin/Auth/rule', '权限管理', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('27', 'Admin/Auth/editRule', '修改权限管理', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('28', 'Admin/Auth/ajaxdelRule', 'ajax删除权限管理', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('29', 'Admin/Auth/ajaxSendRule', 'ajax执行添加修改权限', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('30', 'Admin/Auth/group', '用户组管理', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('31', 'Admin/Auth/ajaxAddGroup', '添加用户组', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('32', 'Admin/Auth/ajaxDelGroup', 'ajax删除用户组', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('33', 'Admin/Auth/allocation', '用户组分配权限', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('34', 'Admin/Auth/admin_user', '管理员列表', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('35', 'Admin/Auth/ajaxAddUser', 'ajax修改|添加 管理员', '1', '25', '');
INSERT INTO `cp_auth_rule` VALUES ('36', 'Admin/Article/add_article', 'ajax执行添加文章', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('37', 'Admin/Article/send_upload', '图片上传', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('38', 'Admin/Article/del_uploadImg', 'ajax图片删除', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('39', 'Admin/Article/del_article', 'ajax删除文章信息', '1', '3', '');
INSERT INTO `cp_auth_rule` VALUES ('40', 'Admin/Auth/ajaxSendAllocation', '分配权限 ajax执行添加', '1', '25', '');

-- ----------------------------
-- Table structure for cp_category
-- ----------------------------
DROP TABLE IF EXISTS `cp_category`;
CREATE TABLE `cp_category` (
  `cid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(60) NOT NULL COMMENT '分类名称',
  `type` varchar(60) NOT NULL COMMENT '分类类型',
  `description` varchar(200) NOT NULL COMMENT '分类描述',
  `parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '分类父id',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `order` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用 1：启用 0：不启用',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

-- ----------------------------
-- Records of cp_category
-- ----------------------------

-- ----------------------------
-- Table structure for cp_comments
-- ----------------------------
DROP TABLE IF EXISTS `cp_comments`;
CREATE TABLE `cp_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论内容',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id  父类ID 0为最高级',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上一次评论的id',
  PRIMARY KEY (`id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`status`),
  KEY `createtime` (`createtime`),
  KEY `aid` (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of cp_comments
-- ----------------------------

-- ----------------------------
-- Table structure for cp_common_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cp_common_action_log`;
CREATE TABLE `cp_common_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user`,`object`,`action`),
  KEY `user_object_action_ip` (`user`,`object`,`action`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问记录表';

-- ----------------------------
-- Records of cp_common_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for cp_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `cp_guestbook`;
CREATE TABLE `cp_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL COMMENT '留言者姓名',
  `email` varchar(100) NOT NULL COMMENT '留言者邮箱',
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `msg` text NOT NULL COMMENT '留言内容',
  `createtime` datetime NOT NULL COMMENT '留言时间',
  `status` smallint(2) NOT NULL DEFAULT '1' COMMENT '留言状态，1：正常，0：删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of cp_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for cp_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `cp_oauth_user`;
CREATE TABLE `cp_oauth_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(20) NOT NULL DEFAULT '' COMMENT '用户来源key',
  `name` varchar(45) NOT NULL DEFAULT '' COMMENT '第三方昵称',
  `head_img` varchar(100) NOT NULL DEFAULT '' COMMENT '第三方用户头像',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL DEFAULT '0.0.0.0' COMMENT '最后登录ip',
  `login_times` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(2) unsigned NOT NULL,
  `access_token` varchar(512) NOT NULL COMMENT '用户登录的TOken',
  `expires_date` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `openid` varchar(45) DEFAULT '' COMMENT '第三方用户id',
  `users_uid` int(11) NOT NULL COMMENT '关联的本站用户id',
  PRIMARY KEY (`id`),
  KEY `fk_cp_oauth_user_cp_users_idx` (`users_uid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='第三方用户表';

-- ----------------------------
-- Records of cp_oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for cp_options
-- ----------------------------
DROP TABLE IF EXISTS `cp_options`;
CREATE TABLE `cp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

-- ----------------------------
-- Records of cp_options
-- ----------------------------

-- ----------------------------
-- Table structure for cp_praise
-- ----------------------------
DROP TABLE IF EXISTS `cp_praise`;
CREATE TABLE `cp_praise` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_ip` varchar(100) NOT NULL DEFAULT '' COMMENT '点赞的用户ip',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞时间',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '点赞类型 0：游客 1：本站用户',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `valid_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效时间 本站用户保留一小时 游客保留一天',
  `nums` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '点击次数',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`aid`) USING BTREE,
  KEY `aid` (`aid`),
  KEY `valid_time` (`valid_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='点赞记录表';

-- ----------------------------
-- Records of cp_praise
-- ----------------------------

-- ----------------------------
-- Table structure for cp_route
-- ----------------------------
DROP TABLE IF EXISTS `cp_route`;
CREATE TABLE `cp_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Records of cp_route
-- ----------------------------

-- ----------------------------
-- Table structure for cp_tags
-- ----------------------------
DROP TABLE IF EXISTS `cp_tags`;
CREATE TABLE `cp_tags` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tname` varchar(45) NOT NULL DEFAULT '' COMMENT '标签名称',
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='标签表';

-- ----------------------------
-- Records of cp_tags
-- ----------------------------

-- ----------------------------
-- Table structure for cp_users
-- ----------------------------
DROP TABLE IF EXISTS `cp_users`;
CREATE TABLE `cp_users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '昵称',
  `u_email` varchar(60) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `face` varchar(100) NOT NULL DEFAULT '' COMMENT '用户头像',
  `sex` enum('男','女') NOT NULL DEFAULT '男' COMMENT '性别',
  `signature` varchar(100) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` char(16) NOT NULL DEFAULT '0.0.0.0',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_type` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '1:admin 2:普通会员',
  `last_login_time` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '最后的登录时间',
  `is_black` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否拉黑 1：拉黑 0：正常',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cp_users
-- ----------------------------
INSERT INTO `cp_users` VALUES ('1', 'admin', 'fd1d213f2013200b00d9bf41c5b50fdf', 'Cocolait', '401498334@qq.com', '', '男', '', '127.0.0.1', '1466754226', '1', '1479375424', '0');

-- ----------------------------
-- Table structure for cp_user_favorites
-- ----------------------------
DROP TABLE IF EXISTS `cp_user_favorites`;
CREATE TABLE `cp_user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL COMMENT '用户 id',
  `title` varchar(255) DEFAULT NULL COMMENT '收藏内容的标题',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) DEFAULT NULL COMMENT '收藏内容的描述',
  `table` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `object_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of cp_user_favorites
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
