---
title: "Hugo博客搭建指南"
date: 2025-12-02T11:30:00+08:00
draft: false
categories: ["技术", "教程", "Web开发", "静态网站"]
tags: ["Hugo", "GitHub Pages", "博客", "部署", "自动化", "CI/CD"]
notes:
  - "Hugo 的构建速度真的很快，几乎是瞬间完成。"
  - "配合 GitHub Actions 自动部署，只需 push 就能更新博客。"
  - "免费、高效、简单，强烈推荐！"
---

## 前言

使用 Hugo 和 GitHub Pages 搭建个人博客是一个简单又高效的方案。本文记录了我搭建这个博客的完整过程。

## 什么是 Hugo

Hugo 是一个用 Go 语言编写的静态网站生成器，具有以下优点：

- **极快的构建速度**：毫秒级生成网站
- **简单易用**：使用 Markdown 写作
- **主题丰富**：有大量免费主题可选
- **部署方便**：生成的是纯静态文件

## 搭建步骤

### 1. 安装 Hugo

在 Windows 上可以使用 Chocolatey：

```powershell
choco install hugo-extended -y
```

验证安装：

```powershell
hugo version
```

### 2. 创建站点

```powershell
hugo new site myblog
cd myblog
```

### 3. 添加主题

```powershell
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

### 4. 配置网站

编辑 `hugo.toml` 文件：

```toml
baseURL = 'https://yourusername.github.io/'
languageCode = 'zh-cn'
title = '我的博客'
theme = 'ananke'
```

### 5. 创建文章

```powershell
hugo new content posts/my-first-post.md
```

### 6. 本地预览

```powershell
hugo server -D
```

访问 `http://localhost:1313` 查看效果。

### 7. 部署到 GitHub Pages

创建 `.github/workflows/hugo.yaml` 文件配置自动部署，然后推送到 GitHub：

```powershell
git add .
git commit -m "Initial commit"
git push origin main
```

## 总结

Hugo + GitHub Pages 的组合非常适合搭建个人博客，零成本、高性能、易维护。

## 相关链接

- [Hugo 官网](https://gohugo.io/)
- [Hugo 中文文档](https://hugo.opendocs.io/)
- [GitHub Pages 文档](https://docs.github.com/pages)
