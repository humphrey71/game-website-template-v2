# 项目初始化指引

## 一键创建新项目

1. 首先配置 GitHub Personal Access Token（仅需执行一次）：
   - 访问 https://github.com/settings/tokens 创建 token
   - 勾选 `repo` 权限
   - 复制生成的 token，执行以下命令：
```bash
git config --global github.token YOUR_TOKEN
```

2. 在新项目目录下执行以下命令：
```powershell
$token = git config --global --get github.token; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/humphrey71/game-website-template-v2/master/init-project.bat" -Headers @{"Authorization"="token $token"} -OutFile "$env:TEMP\init-project.bat" ; if ($?) { & "$env:TEMP\init-project.bat" ; if ($?) { Remove-Item "$env:TEMP\init-project.bat" } }
```

对于 CMD 用户：
```batch
for /f "tokens=*" %a in ('git config --global github.token') do curl -H "Authorization: token %a" -s https://raw.githubusercontent.com/humphrey71/game-website-template-v2/master/init-project.bat -o "%TEMP%\init-project.bat" && "%TEMP%\init-project.bat" && del "%TEMP%\init-project.bat"
```


# FaWeb游戏站代码模板
当前项目用于 Faweb(https://fafafa.ai) 在线一站式出海游戏网站制作工具所使用的代码模板。

# FaWeb 特点
- 无需编写代码即可实现快速上站，不懂一行代码的人也能完成游戏上站
- 支持多语言，支持游戏iframe内嵌配置，支持游戏下载链接配置，配置游戏相关视频，游戏评论，游戏推荐，游戏FAQ等配置

# 演示站点
- [https://sprunkiretake.fun/](https://sprunkiretake.fun/) Iframe嵌入模式
- [https://devourer.fun/](https://devourer.fun/) 下载链接模式



 # update.json配置注意事项
 - 当需要发布新模板版本时，文件更新列里面不可以添加文件夹目录，只需要将需要更新的文件相对路径添加到更新列表中即可。

 # 版本更新记录
 - 2025-02-11 "解决评论内容头像不显示的问题"
 - 2025-02-07 兼容部分游戏国际化内容值为null导致编译报错的问题
            - 解决iframe加载时的文字提示不正确的问题（改为当前游戏名称而非网站名称）
 - 2025-02-06 更新模板样式主题，修复部分样式下文字颜色显示对比度不够的问题，修复下载游戏的样式没有随主题更新
 - 2025-01-18 新增多个网站主题配置，优化游戏分类页面样式，优化游戏推荐卡片组件样式
 - 2025-01-14 新增游戏盒子页面，优化游戏推荐卡片组件，新增游戏盒子设置功能
 - 2025-01-08  "优化博客、游戏、隐私政策等页面，实现全静态化",
 - 2025-01-08 "优化iframe蒙版样式和iframe自动加载策略",
            "增加文章列表分页功能以及调整文章显示顺序",
            "修复部分Image组件缺失width属性的问题"
 - 2024-12-31 当推荐游戏数据为空时，隐藏推荐列表，解决文章列表404的问题，文章详情页面增加面包屑导航
 - 2024-12-30 优化游戏页面布局，默认不加载iframe,调整推荐游戏列表位置，页面详情增加自定义内容渲染功能
 - 2024-12-19 解决游戏列表页面alternates配置错误导致404的问题
 - 2024-12-10 支持自定义logo图片
 - 2024-12-09 优化自定义页面模板，防止编译报错，去掉自定义页面slug属性，防止错误的路径导致404，改为自动根据文件名生成
 - 2024-12-05 解决某些子游戏名称包含多语言符号，导致路径404的问题
 - 2024-12-03 "优化推荐游戏列表、FAQ样式",
            "修复导航菜单过多时导致子菜单位置不正确的问题",
            "修复隐私政策和用户协议菜单页面导致的过多404地址出现的问题",
            "解决推荐游戏列表为空时右侧会出现空白的问题"
            解决已有的子游戏目录模板未更新导致右侧推荐游戏样式不正确的问题
 - 2024-11-29 新增游戏列表页面，优化多个组件的性能和功能，更新导航栏组件，更新资源工具函数，更新游戏页面模板消息
 - 2024-11-28 修复下载站多出h1标签的问题
   - 增加弹窗方式显示游戏页面，解决无法嵌入iframe的问题
 - 2024-11-25 修复Google Adsense 配置缺失导致编译报错
 - 2024-11-23 解决配置下载游戏页面显示404的问题，优化loading组件样式，改为黑色背景，去掉默认的游戏推荐数据
    - 删除guide页面,统一采用自定义页面功能
    - 修改导航栏在手机下样式不匹配，链接不正确问题
    - 更新站点配置文件，增加google adsense配置
 - 2024-11-19 修复游戏推荐卡片组件类型编译报错，支持多语言游戏推荐、增加子游戏页面模板
  - 修复游戏推荐组件不显示的问题
  - 支持设置游戏推荐位置
  - 修复子游戏iframe无法加载正确地址的问题
  - 修复多语言下出现路径不正确导致google抓取404的问题
