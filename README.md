# 🧠 心理健康助手 (Mental Health Assistant)

一个专注于心理健康支持与情绪管理的移动应用，帮助用户记录心情、追踪情绪趋势、进行放松训练，并获得基于 AI 的心理建议。

---

## 🌿 功能特点

### 📝 情绪记录
- 每日记录情绪、心情类别和备注
- 自动生成情绪趋势图表，帮助用户了解自己的心理变化

### 💬 AI 心理助理
- 通过自然语言与 AI 对话，获得温和、理性的心理支持  
- 提供压力缓解建议、认知重构思路、正念引导等
- 支持多语言（中文 / 英文）

### 🎯 番茄冥想 & 呼吸练习
- 番茄钟结合心理放松模式  
- 动态动画呼吸训练，帮助调节心率与放松大脑  
- 自定义时间、提醒音效和主题

### 📊 数据分析
- 可视化展示一周、一月情绪变化趋势  
- 支持导出数据或本地备份  
- 自动识别情绪波动高峰期

### 🎨 界面设计
- 明亮与夜间模式自适应  
- 多主题配色（温柔系、森林系、极简黑白等）  
- 动效柔和、UI 沉浸式体验

---

## ⚙️ 技术栈

| 模块 | 技术 |
|------|------|
| 前端框架 | Flutter 3.x |
| 状态管理 | Provider / Riverpod |
| 本地存储 | Drift (SQLite ORM) |
| 网络请求 | http / dio |
| 国际化 | Flutter Intl |
| AI 聊天 | Deepseek api |

---


## 🚀快速开始
### 1️⃣ 环境准备
- flutter SDK: 3.35.4
- Java: 17.0.12
- Dart:3.9.2 +

### 2️⃣ 克隆项目
```bash
git clone https://github.com/yourname/mental-health-assistant.git
```


### 3️⃣ 安装依赖
```bash
flutter pub get
```
### 4️⃣ 运行项目
```bash
flutter run
```
### 🧩 可选配置

在根目录创建 .env 文件：
```
DEEPSEEK_KEY=your_api_key_here
```

⚠️ 用于启用 AI 聊天助手功能。


## 🧘‍♀️关于项目
我们的代码基于[mood-example](https://github.com/AmosHuKe/Mood-Example),重构并完善了项目。增加了心理健康相关的功能。感谢@AmodHuKe开源。

## 🌸 贡献者
感谢所有为心理健康技术努力的人。
如果你也希望参与改进，欢迎提交 PR 或讨论建议。
