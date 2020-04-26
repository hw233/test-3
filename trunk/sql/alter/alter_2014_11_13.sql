use simserver;

ALTER TABLE `admin_sys_activity` ADD COLUMN `display` tinyint unsigned NOT NULL DEFAULT 1 COMMENT '是否显示(0:否 1:是)';