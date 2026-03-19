#let cv-color = rgb("#284967")
#set page(margin: (x: 0.9cm, y: 1.0cm))
#set text(font: "Noto Sans CJK SC", size: 10pt)
#set par(justify: true)
#let chiline = {
  v(-8pt)
  line(stroke: cv-color, length: 100%)
  v(-2pt)
}
#show "|": text(gray, " | ")
#show heading.where(level: 1): it => text(fill: rgb("#222222"), size: 20pt, it) + v(5pt)
#show heading.where(level: 2): it => text(cv-color, it) + chiline
#let item(a, b, c) = grid(
  columns: (20%, 1fr, 30%),
  align: (left, center, right),
  text(fill: rgb("#222222"), weight: "bold", a),
  text(rgb("#222222"), weight: "bold", b),
  text(rgb("#222222"), weight: "bold", c),
)

#grid(
  columns: (1fr, auto),
  align(center)[
    = 高松灯

    #set text(rgb("#333333"))

    运动控制算法工程师（强化学习方向） | 北京市
    
    138XXXX8899 | gaosongdeng\@163.com | github.com/gaosongdeng-rl
  ], image(width: 60pt, "../images/image.png")
)

#set text(rgb("#444444"))

== 教育背景

#item[2020.09 \~ 2024.06][北京理工大学][机器人工程（本科）]

*成绩情况：*GPA 3.8 / 4.0（专业前5%），综测前8%（2/25）

*核心课程：*机器人运动学与动力学、强化学习原理与应用、现代控制理论、深度学习、多刚体动力学、最优控制、机器人仿真技术。

== 实习经历

#item[2023.07 \~ 2023.09][北京智元机器人科技有限公司][运动控制算法实习生]

*工作内容1：*搭建四足机器人强化学习训练环境并优化PPO奖励函数，越障成功率提升35%。

*工作内容2：*参与仿真到实机迁移，结合域随机化与系统辨识，将动作误差从12%降至5%。

*工作内容3：*参与RL+前馈复合控制架构开发，负责关节力矩控制模块，动态行走能耗降低18%。

== 项目经验

#item[2023.03 \~ 2023.06][四足机器人RL动态步态生成与抗扰动控制][算法负责人]

*核心技术：*PPO+TD3混合算法、域随机化、力位混合控制、Isaac Gym并行仿真、TensorRT推理加速。

*量化成果：*设计分层奖励函数后训练效率提升40%；机器人在15°斜坡、5cm凸起砂石路行走稳定性达92%，较传统方案提升45%；单步决策耗时从20ms降至8ms。

#item[2022.09 \~ 2023.02][人形机器人基于AMP的人体运动复刻与泛化][核心开发]

*核心技术：*AMP、行为克隆（BC）、MuJoCo动力学建模、URDF模型标定。

*量化成果：*处理1000+帧动捕数据后动作复刻相似度达95%；引入域自适应后，复刻动作在0.2-0.8摩擦系数地面成功率从70%提升至90%。

#item[2022.03 \~ 2022.08][RL+PID复合控制的机械臂柔顺装配系统][算法开发]

*核心技术：*SAC、阻抗控制、六维力传感器数据融合、ROS2节点开发。

*量化成果：*装配力控制误差从±5N降至±1N；轴承压装场景合格率从85%提升至98%；部署到Jetson Xavier NX后延迟≤10ms。

== 补充信息

#item[技术主页][GitHub / 博客 / 作品集][在线链接]

*GitHub：*#link("https://github.com/gaosongdeng-rl")[https://github.com/gaosongdeng-rl]

*技术博客：*#link("https://blog.csdn.net/gaosongdeng_rl")[https://blog.csdn.net/gaosongdeng_rl]

*项目作品集：*#link("https://pan.baidu.com/s/1XXXX")[https://pan.baidu.com/s/1XXXX]

== 技能特长

- *强化学习算法：*熟练掌握PPO、SAC、TD3、DDPG，具备奖励函数设计、样本效率优化、训练稳定性调优经验
- *仿真与开发：*精通Isaac Gym / MuJoCo并行仿真，熟练使用PyTorch、URDF / MJCF建模与参数标定
- *实机迁移与部署：*掌握域随机化、系统辨识、状态观测器设计，熟悉ONNX / TensorRT优化与Jetson部署

== 荣誉奖项

- 2023.10 全国大学生机器人竞赛（RoboMaster）机甲大师赛，国家级二等奖（全国前10%）
- 2023.05 北京市大学生机械创新设计大赛，省级一等奖（全市前5%）
- 2022.12 北京理工大学“优秀科研创新奖”，校级（专业前3%）
- 2022.06 北京理工大学机器人控制算法竞赛，院级一等奖
