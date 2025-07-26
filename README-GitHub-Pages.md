# VitalBPDiary 政策文档部署指南

## 概述

为了通过App Store审核，VitalBPDiary应用需要提供以下政策文档的功能链接：
- 隐私政策 (Privacy Policy)
- 用户协议 (Terms of Service)  
- 支持页面 (Support)

本指南将帮助您将这些HTML文档部署到GitHub Pages。

## 文件清单

```
VitalBPDiary/
├── privacy_policy.html      # 隐私政策
├── terms_of_service.html    # 用户协议
├── support.html            # 支持页面
├── medical_references.html # 医疗参考文献
└── README.md              # 部署指南
```

## GitHub Pages 部署步骤

### 1. 创建GitHub仓库

1. 在GitHub上创建一个新仓库，建议命名为 `vitalbpdiary-policies` 或类似名称
2. 设置仓库为公开 (Public)

### 2. 上传HTML文件

将以下文件上传到仓库根目录：
- `privacy_policy.html`
- `terms_of_service.html`
- `support.html`
- `medical_references.html`

### 3. 启用GitHub Pages

1. 进入仓库设置 (Settings)
2. 滚动到 "Pages" 部分
3. 在 "Source" 下选择 "Deploy from a branch"
4. 选择 "main" 分支和 "/ (root)" 文件夹
5. 点击 "Save"

### 4. 获取GitHub Pages URL

启用后，您的文件将可以通过以下URL访问：
```
https://[您的用户名].github.io/[仓库名]/privacy_policy.html
https://[您的用户名].github.io/[仓库名]/terms_of_service.html
https://[您的用户名].github.io/[仓库名]/support.html
https://[您的用户名].github.io/[仓库名]/medical_references.html
```

### 5. 更新应用中的链接

编辑 `VitalBPDiary/Core/Config/AppConfig.swift` 文件，将占位URL替换为实际的GitHub Pages链接：

```swift
struct AppConfig {
    // 更新这些URL为您的实际GitHub Pages链接
    static let privacyPolicyURL = "https://[您的用户名].github.io/[仓库名]/privacy_policy.html"
    static let termsOfServiceURL = "https://[您的用户名].github.io/[仓库名]/terms_of_service.html"
    static let supportURL = "https://[您的用户名].github.io/[仓库名]/support.html"
    static let medicalReferencesURL = "https://[您的用户名].github.io/[仓库名]/medical_references.html"
    
    // 如果需要，也可以更新邮箱地址
    static let supportEmail = "您的实际邮箱@example.com"
}
```

## App Store Connect 配置

### 1. 支持URL (Support URL)
在App Store Connect中设置支持URL为：
```
https://[您的用户名].github.io/[仓库名]/support.html
```

### 2. 隐私政策URL
在App Store Connect的隐私政策字段中填写：
```
https://[您的用户名].github.io/[仓库名]/privacy_policy.html
```

### 3. 应用描述中的用户协议
在App Store Connect的应用描述中添加用户协议链接，或者使用自定义EULA字段。

## 验证部署

部署完成后，请验证以下几点：

1. ✅ 所有HTML文件都能正常访问
2. ✅ 页面内容显示正确，没有乱码
3. ✅ 移动设备上浏览体验良好
4. ✅ 应用内的链接能正确打开页面
5. ✅ App Store Connect中的URL字段已正确填写

## 自定义域名 (可选)

如果您有自己的域名，可以配置GitHub Pages使用自定义域名：

1. 在仓库根目录创建 `CNAME` 文件
2. 在文件中写入您的域名，如：`policies.vitalbpdiary.com`
3. 在DNS设置中添加CNAME记录指向 `[用户名].github.io`

## 维护说明

- HTML文件中的联系邮箱、日期等信息需要定期更新
- 隐私政策和用户协议发生变更时，记得同时更新HTML文件和应用版本
- 建议在每次应用更新前检查所有链接的可访问性

## 故障排除

**问题1：GitHub Pages未启用**
- 检查仓库是否为公开状态
- 确认在设置中正确启用了GitHub Pages

**问题2：HTML文件无法访问**
- 检查文件名是否正确（区分大小写）
- 确认文件已正确上传到仓库根目录

**问题3：中文字符显示乱码**
- 确保HTML文件保存时使用UTF-8编码
- 检查HTML头部是否包含正确的charset声明

**问题4：移动端显示异常**
- 检查HTML中的viewport meta标签
- 测试不同屏幕尺寸的显示效果

## 联系支持

如有任何问题，请通过以下方式联系：
- 应用内反馈功能
- 邮箱：support@vitalbpdiary.com

---

**注意：** 请确保所有政策文档的内容准确、合规，建议在发布前咨询法律专业人士。