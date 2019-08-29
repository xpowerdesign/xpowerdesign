CREATE TABLE `users`
(
    `id`               bigint(20)   NOT NULL COMMENT '主键',
    `username`         varchar(255) NOT NULL COMMENT '用户名',
    `email`            varchar(255) NOT NULL COMMENT '电子邮箱',
    `encrypt_password` varchar(255) NOT NULL COMMENT '加密密码',
    `salt`             varchar(255) NOT NULL COMMENT '密码串',
    `reg_time`         datetime     NOT NULL,
    `status`           int(11)      NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_email` (`email`),
    UNIQUE KEY `uk_user_name` (`username`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;