# 福州大学期末试卷 LaTeX 模板

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![LaTeX](https://img.shields.io/badge/LaTeX-Template-green.svg)

这是一个为福州大学教师设计的期末试卷 LaTeX 模板，基于 `exam` 文档类进行二次开发，旨在简化试卷制作流程，提高排版效率。

## 📋 开发历程

1. **创作动机**
   - 作为新入职的教师，习惯了使用 LaTeX 进行学术排版，发现传统的 Word 试卷模板存在以下问题：
     - 格式调整繁琐，难以保证多份试卷的一致性
     - 数学公式、代码等专业内容排版效果不佳
     - 评卷表格等重复性内容需要手动制作
   - 因此决定开发此 LaTeX 模板，为福州大学教师提供一个专业、高效的试卷制作解决方案。

2. **技术基础**
   - 基于功能强大的 `exam` 文档类进行二次开发
   - 结合福州大学官方试卷格式要求进行定制化设计
   - 通过参数化配置实现试卷信息的快速设置

## ✨ 模板特点

### 1. 自动化试卷头生成
   - 通过简单的文档参数设置，自动生成符合福州大学规范的试卷头
   - 自动创建学生信息填写区域（姓名、学号、专业等）
   - 支持课程名称、考试时间、总分等关键信息的快速配置

```latex
\documentclass[,
  addpoints, % 启用分数累加，方便大题计算总分
  % answers, %　输出带参考答案的试卷，排版会略有不同（取消评卷表格等）
  coursename={测试课程}, % 课程名称，出现在试卷第一页
  at={期末}, % 自定义内容，可以改成期中，生成的PDF中会出现“期末考试”或者“期中考试”
  examtype={A}, % 可选参数，默认为A卷，即正常考卷，B卷通常为补考卷
  examdate={2026年1月21日}, % 可选参数，考试时间，默认为\today
]{fzuexam}
```

### 2. 结构化题目环境
   - 重新设计 `question` 和 `part` 命令，使其对应"大题"和"小题"层级
   - 支持分数自动计算和显示
```latex
\question[30] 单项选择题（15题，每题2分）
\begin{parts}
  % 推荐使用\fillin[A][1.5em]在题号后面生成空格方便学生填写与教师批改，A为结果，在激活answers参数后可以自动生成到参考答案文档中
  \part \fillin[A][1.5em]这是第一道选择题，choices环境排版选项，每个选项一行
  \begin{choices}
    \choice 选项1
    \choice 选项2
    \choice 选项3
    \choice 选项4
    \choice 选项5
  \end{choices}
  \part \fillin[A][1.5em]这是第二道选择题，oneparchoices环境排版选项，所有选项一行，需要插入空行进行换行

  \begin{oneparchoices}
    \choice 选项1
    \choice 选项2
    \choice 选项3
    \choice 选项4
    \choice 选项5
  \end{oneparchoices}
\end{parts}
\droptotalpoints
```

### 3. 智能评卷表格
   - 使用 `gradetable` 功能自动生成评卷表格
   - 基于大题结构自动计算各题分值
   - 在每个大题之后添加对应的评卷表格（使用 `totalformat` 定制）
   - 支持总分统计和阅卷人签名区域

## 🚀 快速开始

### 环境要求
- LaTeX 发行版（TeX Live 2020+ 或 MiKTeX 最新版）
- 支持 `exam` 文档类及相关宏包

### 安装使用
1. 下载本模板文件
2. 将模板文件`fzuexam.cls`放入您的 LaTeX 项目目录
3. 编辑主 `.tex` 文件中的配置参数
4. 使用 XeLaTeX 或 LuaLaTeX（推荐） 编译

### 常见问题

#### 留空白
```latex
\begin{solutionorlines}[6cm]
  \zhlipsum[1]
\end{solutionorlines}
% 或
\ifprintanswers
参考答案
\else
\vspace{10cm} % 竖向留白10cm
% \vspace{\stretch{1}}自适应留白，类似\vfill，\stretch{1}中的1为权重，比如这一页两道题目，希望上一题留白更多，则可以使用\stretch{2}或更多
\fi
```

#### 分数计算
在`\question`、`\part`、`\subpart`后均可以使用`[10|20|...]`来标记大题、题、小题的分数。正常来说，它们应当是互斥的，否则分数会重复计算。例如
```latex
\question[20] 
\begin{parts}
    \part[10]
    \part[10]
\end{parts}
```
这样子，看着是把大题的20分分配到了两题中，但`exam`宏包没有那么智能，会导致该大题的分数重复累加为40分。

因此，如果希望既要标注大题总分，又想标注每一题分值，甚至想要标注小题分值的情况下，需要在`\question[20] ...`下一行使用`\noaddpoints`临时关闭分数统计，这样再声明小题分数就不会累加，第一页的评卷表内分数就不会有错了。如果需要恢复则使用`\addpoints`即可。


## 🎯 使用场景

1. **常规期末考试**
   - 自动生成标准格式试卷
   - 自动计算总分和每大题分值

2. **参考答案生成**
   - 使用 `answers` 选项快速生成参考答案
   - 便于教学讨论和评分标准制定

## 🔧 技术细节

### 主要宏包依赖
- `exam`: 核心试卷文档类
- `geometry`: 页面布局设置
- `graphicx`: 图片插入支持
- `amsmath`, `amssymb`: 数学公式支持
- `xcolor`: 颜色控制

### 编译建议
```bash
# 推荐使用LuaLaTeX编译
lualatex main.tex
lualatex main.tex
# 至少运行两遍保证交叉引用正确解析

# 如需生成参考答案
lualatex -jobname=answers "\PassOptionsToClass{answers}{fzuexam}\input{main.tex}"
lualatex -jobname=answers "\PassOptionsToClass{answers}{fzuexam}\input{main.tex}"
```

## 🤝 贡献指南

欢迎各位教师和LaTeX爱好者参与改进！

1. **问题反馈**
   - 在GitHub Issues中提交问题或建议
   - 提供最小可复现示例

2. **功能改进**
   - Fork本仓库
   - 创建功能分支
   - 提交Pull Request

3. **文档完善**
   - 补充使用示例
   - 翻译或校对文档

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

**温馨提醒**：使用前请仔细核对学校最新的试卷格式要求，本模板会不定期更新以匹配官方规范。