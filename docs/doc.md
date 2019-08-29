# XPowerDesign MVP

XPowerDesign 是一个在线的图片海报设计器，使用 Canvas 技术在浏览器端实现类似 PS 的图片组合设计功能。平台提供用户管理、工程管理、素材管理、模板管理、编辑器、图片导出下载与分享等功能。

## 一、需求分析

### 功能性需求

- 用户管理
- 工程管理
- 素材管理
- 模板管理
- 编辑器
- 图片导出

#### 用户管理

1. 用户可以注册、登录、注销
2. 用户分为「管理员」与「普通用户」两种角色
3. 「管理员」角色拥有所有资源的管理权限

#### 工程管理

1. 用户可以创建、删除、修改自己的工程，工程仅对用户自己可见
2. 界面提供按钮保存工程到云端
3. 工程具有 name、category、width、height 等可编辑属性
4. 需要显示工程等最近更新时间
5. 在工程选择界面需要展示工程缩略图
6. 工程需要保存当前编辑器的状态

#### 素材管理

1. 素材是构成工程的重要元素，素材 type 可以是背景图、图片、字体
2. 用户可添加素材到工程，在编辑器右侧设有当前工程所有素材的展示列表
3. 素材具有 name、type、category 等可编辑属性
4. 用户可以上传公共素材，上传素材需经过管理员审核后公开
5. 用户可以上传私有素材，上传的素材不作为公共素材，仅该用户可见
6. 在界面上需具有素材选择器，需展示素材缩略图
7. 在素材选择器中可根据素材的 type、category 进行分类过滤选择
8. 可以从素材选择器拖拽素材到编辑器，或者点击素材自动添加到编辑器

#### 模版管理

1. 模板是一种特殊的工程，是一些素材元素的集合。用户可以从工程生成、更新模版
2. 模版需要管理员审核后才能公开
3. 模板的使用分为「小白模式」与「设计师模式」，「小白模式」下用户仅可编辑设定的可编辑内容，「设计师模式」下则可以编辑所有元素
4. 用户生成、更新模版时可指定「小白模式」下哪些元素可被编辑
5. 界面上应具有模板选择器，可根据 category 过滤选择
6. 界面提供开关切换「小白模式」和「设计师模式」

#### 编辑器

1. 编辑器提供对工程中的素材元素进行编辑的能力
2. 可以添加、修改背景图
3. 所有可编辑的素材都可以拖动、旋转、缩放
4. 可以添加、修改文本元素、图片素材
5. 文本元素可设置对齐、字体、大小、样式、粗细、颜色
6. 图片元素可以进行裁剪

#### 图片导出

1. 界面提供按钮将当前工程导出为图片，可提供下载以及链接分享
2. 当工程未保存时，先保存工程，再导出图片

### 非功能性需求

- 项目初始化
  - 架构搭建
- 环境部署
  - 部署服务器：腾讯云
  - 使用 GitHub 管理代码以及 CI/CD，配置 Pipeline
  - 配置 JIB 生成应用 Docker 镜像
  - Docker Registry 初始化
  - 编写 Docker 容器（数据库、Nginx、应用）管理脚本
  - 编写 Nginx 配置
- 异常处理

## 二、业务、架构与选型

<iframe frameborder="0" width="100%" height="500" src="https://www.processon.com/embed/mind/5d526f9de4b04399f5a2dcd5"></iframe>
### 技术选型

#### 前端
- UI 框架：**React + Ant Design**
- 状态管理：**Redux**
- Canvas 框架：**Fabric.js**
- 测试框架：**Jest**

#### 后端
- 框架：**Java + Spring Boot**
- 鉴权：**Spring Security**
- ORM：**Spring Data JPA**
- 数据库：**MySQL**
- 测试框架：**Mockito + Spring Boot Test + JUnit**

#### 基础设施
- 托管、CI/CD：**GitHub**
- 容器化：**JIB**、**Docker**
- 静态资源服务、反向代理：**Nginx**
- 云服务器：**腾讯云**

## 三、实现方案

#### 表结构：E-R 图

<iframe frameborder="0" width="100%" height="500" src='https://dbdiagram.io/embed/5d5cbe4aced98361d6ddc5db'> </iframe>
#### 用户管理

1. 使用 Spring Security 完成对用户的鉴权

#### 工程管理

1. 用户创建工程时需要填写 `name`、`category`、`width`、`height` 等信息作为项目基本信息
2. MySQL 自动记录项目每次更新的时间
3. 工程保存时，在前端生成低品质的图像，上传到七牛云，获得 URL 后将其作为工程缩略图地址
4. canvas 的状态使用 fabric.js 的 `toJSON` 方法获得

#### 素材管理

1. 规定素材 type 可以是 `BACKGROUND_IMAGE`、`IMAGE`、`TEXT` 三种
2. 用户上传素材时可选择已有 `category` 将素材添加到其中，也可自定义 `category`
3. 上传素材到数据库后，默认其 checked 字段为 `false`，在管理员审核后将其设为 `true` 后才能公开
4. 使用关系表 project_asset 记录工程与素材之间的包含关系
5. asset 表具有 private 字段表示该资源是其对应的工程的私有资源
6. 素材保存时上传到七牛云，获得 URL 后将其作为素材缩略图地址
7. 后端设置接口用于获取所有素材的 `type` 与 `category`，在素材选择器中根据素材的 `type`、`category` 进行分类过滤选择
8. 拖放添加素材到编辑器实现：前端设置 asset 的 `draggable` 为 true 使其可以拖动，并在元素上设置 data 属性保存需要的素材信息（例如：`data-id="xxx"`）；在 asset 的容器元素上设置 dragstart 事件监听器拦截内部的 asset 拖动，根据 `event.target.dataset['需要的信息key']` 获得所需信息后通过 `event.dataTransfer.setData` 添加数据；在编辑器上注册 `drop` 事件处理函数，便可以通过 `event.dataTransfer.getData` 获取拖来的素材信息，实现添加

#### 模版管理

1. 模版从工程生成，生成模版需要提供 `projectId`，以及 canvas 状态的 json 序列化数据（`canvas`）
2. 上传模版到数据库后，默认其 checked 字段为 `false`，在管理员审核后将其设为 `true` 后才能公开
3. 生成模版时，在编辑器右侧的素材列表中选择需要在「小白模式」下固定的素材对象并记录；通过 `canvas.toJSON` 生成编辑器状态对象，遍历其 `objects` 数组，按顺序匹配素材列表中的素材，如果需要固定，则对该对象添加 `fixed: true`；之后使用 `JSON.stringify` 序列化状态对象，作为 canvas 参数调用生成/更新模版的接口
4. 在「小白模式」与「设计师模式」之间切换时，需要使用 `canvas.getObjects` 所有素材遍历，对元素应用 fabric.js 的 `lockMovementX`, `lockMovementY`, `hasControls` 等方法来控制元素是否可以编辑

#### 编辑器

1. 使用 fabric.js 作为编辑器的核心部件，其提供元素的拖动、旋转、缩放功能
2. 添加、修改背景图：`canvas.setBackgroundImage`
3. 添加素材流程：素材选择器在获取素材时将素材的信息放入素材包装元素的 dataset 中，添加入编辑器时将素材 id 信息等加入新建的 fabric object，使用 `canvas.add` 添加新建 object
4. 删除素材：使用 `canvas.remove(canvas.getActiveObject())` 删除选中的素材
5. 编辑器右侧放置一个素材列表，其内容是 `canvas.getObjects` 所得对象列表；当 canvas 的 `object:added` 以及 `object:removed` 事件触发时，更新素材列表
6. 素材添加、修改：
   - 使用 fabric 的 `IText`、`Image` 对象
   - 替换图片使用 Image 对象的 `setSrc` 方法
   - 替换后调用 canvas 的 `renderAll` 方法进行重绘
7. 文本元素的对齐、字体、大小、样式、粗细、颜色属性修改通过设置 IText 对象的 `textAlign`, `fontFamily`, `fontSize`, `fontStyle`, `fontWeight`, `setColor()` 实现
8. 图片元素裁剪：获取所选对象的图片，使用裁剪器裁剪后生成 base64 的 URL 存入 canvas 状态

#### 图片导出

1. 导出流程：判断工程是否已保存，如果没有保存则先将其保存；调用 `canvas.toDataURL` 生成 dataurl，之后使用 fetch 将其转换为 blob 对象；使用七牛云 SDK 上传 blob 图片，获得图片地址后，进行分享或者下载
2. 分享方案：将生成图片链接放到 input 中，使用 `input.select()` 和 `document.execCommand("copy")` 将链接复制到剪切板，提示用户已成功复制链接，从而实现分享