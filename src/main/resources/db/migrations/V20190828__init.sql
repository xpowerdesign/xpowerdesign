CREATE TABLE `users`
(
    `id`               char(36)     NOT NULL DEFAULT '' COMMENT '主键uuid',
    `username`         varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
    `mobile`           varchar(255) NOT NULL DEFAULT '' COMMENT '用户手机号',
    `email`            varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
    `encrypt_password` varchar(255) NOT NULL DEFAULT '' COMMENT '加密密码',
    `salt`             varchar(255) NOT NULL DEFAULT '' COMMENT '密码串',
    `user_type`        varchar(255) NOT NULL DEFAULT 'user' COMMENT '用户类型：user 普通用户 designer 设计师 admin',
    `nickname`         varchar(36)           DEFAULT '' COMMENT '用户昵称',
    `avatar`           varchar(255)          DEFAULT '' COMMENT '用户头像',
    `status`           varchar(255) NOT NULL DEFAULT 'active' COMMENT '用户状态：active 活动的 ban 禁用',
    `last_login_at`    datetime              DEFAULT NULL COMMENT '最后登陆时间',
    `last_login_ip`    varchar(39)  NOT NULL DEFAULT '' COMMENT '最后登陆IP',
    `registration_at`  datetime              DEFAULT NULL COMMENT '注册时间',
    `registration_ip`  varchar(39)  NOT NULL DEFAULT '' COMMENT '注册IP',
    `openid`           varchar(255) NOT NULL DEFAULT '' COMMENT '微信openid',
    `created_at`       datetime     NOT NULL COMMENT '创建时间',
    `updated_at`       datetime     NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_email` (`email`),
    UNIQUE KEY `uk_mobile` (`mobile`),
    UNIQUE KEY `uk_user_name` (`username`),
    UNIQUE KEY `uk_user_name` (`openid`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '用户表';

CREATE TABLE `categories`
(
    `id`            char(36)     NOT NULL DEFAULT '' COMMENT '主键uuid',
    `name`          varchar(255) NOT NULL DEFAULT '' COMMENT '英文分类名: haibao、dm etc.',
    `name_chn`      varchar(255) NOT NULL DEFAULT '' COMMENT '中文分类名：手机海报、DM宣传单 etc.',
    `type`          varchar(255) NOT NULL DEFAULT 'category' COMMENT '分类：category 分类：电商 group 分组：海报',
    `width`         int(11)      NOT NULL DEFAULT 0 COMMENT '宽度 px',
    `height`        int(11)      NOT NULL DEFAULT 0 COMMENT '高度 px',
    `dpi`           int(11)      NOT NULL DEFAULT 0 COMMENT '分辨率',
    `doc_width`     int(11)      NOT NULL DEFAULT 0 COMMENT '文档宽度',
    `doc_height`    int(11)      NOT NULL DEFAULT 0 COMMENT '文档高度',
    `doc_unit`      varchar(10)  NOT NULL DEFAULT '' COMMENT '文档单位: px, cm, etc.',
    `size`          varchar(255) NOT NULL DEFAULT '' COMMENT '尺寸',
    `cover`         varchar(255) NOT NULL DEFAULT '' COMMENT '封面',
    `cover_display` varchar(255) NOT NULL DEFAULT '' COMMENT '封面背部或者展示页',
    `notices`       text COMMENT '提示',
    `status`        varchar(255) NOT NULL DEFAULT 'unpublished' COMMENT '分类状态：published 发布的 unpublished 下架的',
    `created_at`    datetime     NOT NULL COMMENT '创建时间',
    `updated_at`    datetime     NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '类别表';


CREATE TABLE `projects`
(
    `id`                char(36)     NOT NULL DEFAULT '' COMMENT '主键uuid',
    `group_category_id` char(36)     NOT NULL DEFAULT '' COMMENT '分组类别ID',
    `tag_category_id`   char(36)     NOT NULL DEFAULT '' COMMENT '分类类别ID',
    `user_id`           char(36)     NOT NULL DEFAULT '' COMMENT '用户ID',
    `title`             varchar(255) NOT NULL DEFAULT '' COMMENT '工程标题',
    `description`       varchar(255) NOT NULL DEFAULT '' COMMENT '工程描述',

    `width`             int(11)      NOT NULL DEFAULT 0 COMMENT '宽度 px',
    `height`            int(11)      NOT NULL DEFAULT 0 COMMENT '高度 px',
    `dpi`               int(11)      NOT NULL DEFAULT 0 COMMENT '分辨率',
    `doc_width`         int(11)      NOT NULL DEFAULT 0 COMMENT '文档宽度',
    `doc_height`        int(11)      NOT NULL DEFAULT 0 COMMENT '文档高度',
    `doc_unit`          varchar(10)  NOT NULL DEFAULT '' COMMENT '文档单位: px, cm, etc.',

    `image_url`         varchar(255) NOT NULL DEFAULT '' COMMENT '图片地址',
    `json_url`          varchar(255) NOT NULL DEFAULT '' COMMENT 'json地址：存储工程元数据',
    `svg_url`           varchar(255) NOT NULL DEFAULT '' COMMENT 'svg地址',
    `thumbnail_url`     varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图地址',
    `template_id`       char(36)     NOT NULL DEFAULT '' COMMENT '模板ID',
    `source`            varchar(10)  NOT NULL DEFAULT '' COMMENT '工程来源：web、app、etc.',
    `created_at`        datetime     NOT NULL COMMENT '创建时间',
    `updated_at`        datetime     NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '项目工程表';

# 所有的模板都来自于工程
CREATE TABLE `templates`
(
    `id`                 char(36)     NOT NULL DEFAULT '' COMMENT '主键uuid',
    `user_id`            char(36)     NOT NULL DEFAULT '' COMMENT '用户ID',
    `group_category_id`  char(36)     NOT NULL DEFAULT '' COMMENT '分组类别ID',
    `tag_category_id`    char(36)     NOT NULL DEFAULT '' COMMENT '分类类别ID',
    `project_id`         char(36)     NOT NULL DEFAULT '' COMMENT '工程ID',
    `parent_template_id` char(36)     NOT NULL DEFAULT '' COMMENT '父类模板ID',
    `name`               varchar(255) NOT NULL DEFAULT '' COMMENT '模板名称',
    `title`              varchar(255) NOT NULL DEFAULT '' COMMENT '模板标题',
    `description`        varchar(255) NOT NULL DEFAULT '' COMMENT '工程描述',

    `width`              int(11)      NOT NULL DEFAULT 0 COMMENT '宽度 px',
    `height`             int(11)      NOT NULL DEFAULT 0 COMMENT '高度 px',
    `dpi`                int(11)      NOT NULL DEFAULT 0 COMMENT '分辨率',
    `doc_width`          int(11)      NOT NULL DEFAULT 0 COMMENT '文档宽度',
    `doc_height`         int(11)      NOT NULL DEFAULT 0 COMMENT '文档高度',
    `doc_unit`           varchar(10)  NOT NULL DEFAULT '' COMMENT '文档单位: px, cm, etc.',

    `json_url`           varchar(255) NOT NULL DEFAULT '' COMMENT 'json地址：存储工程元数据',
    `svg_url`            varchar(255) NOT NULL DEFAULT '' COMMENT 'svg地址',
    `image_url`          varchar(255) NOT NULL DEFAULT '' COMMENT '图片地址',
    `thumbnail_url`      varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图地址',

    `tag_meta`           text COMMENT '模板标签：json：{"level1":"发布会,新品,新品首发","level3":"蓝色,黑色,白色","level2":"品牌,水彩,笔触,纹理,简约,商务,媒体,记者,新产品,请帖,请柬"}',

    `verified`           varchar(255) NOT NULL DEFAULT 'unaudited' COMMENT '发布状态：unaudited 未审核  rejected 驳回 checked 已审核',
    `verified_at`        datetime COMMENT '审核通过时间',
    `publish_status`     varchar(255) NOT NULL DEFAULT 'unpublished' COMMENT '发布状态：published 已发布 unpublished 未发布',
    `published_at`       datetime COMMENT '发布时间',

    `used_count`         int(11)      NOT NULL DEFAULT 0 COMMENT '使用次数',
    `created_at`         datetime     NOT NULL COMMENT '创建时间',
    `updated_at`         datetime     NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '模板表';

CREATE TABLE `assets`
(
    `id`             char(36)     NOT NULL DEFAULT '' COMMENT '主键uuid',
    `user_id`        char(36)     NOT NULL DEFAULT '' COMMENT '用户ID',
    `name`           varchar(255) NOT NULL DEFAULT '' COMMENT '素材名',
    `name_chn`       varchar(255) NOT NULL DEFAULT '' COMMENT '素材名：中文',
    `type`           varchar(255) NOT NULL DEFAULT 'background' COMMENT '类型：background 背景图， font 字体, sticker，贴纸',
    `sub_type`       varchar(255) NOT NULL DEFAULT 'color' COMMENT '子类型: background: image, color, sticket:图片容器、插画、图标、纹理',

    `resource_url`   varchar(255) NOT NULL DEFAULT '' COMMENT '图片、资源地址',
    `thumbnail_url`  varchar(255) NOT NULL DEFAULT '' COMMENT '缩略图地址',
    `resources_meta` longtext COMMENT '资源:json {}',
    `sort`         int(11)      NOT NULL DEFAULT 0 COMMENT '排序',

    `source`       varchar(255) NOT NULL DEFAULT 'personal' COMMENT '发布状态：personal 私人的 official 官网的',
    `verified`       varchar(255) NOT NULL DEFAULT 'unaudited' COMMENT '发布状态：unaudited 未审核  rejected 驳回 checked 已审核',
    `verified_at`    datetime COMMENT '审核通过时间',
    `publish_status` varchar(255) NOT NULL DEFAULT 'unpublished' COMMENT '发布状态：published 已发布 unpublished 未发布',
    `published_at`   datetime COMMENT '发布时间',

    `created_at`     datetime     NOT NULL COMMENT '创建时间',
    `updated_at`     datetime     NOT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '素材表';




