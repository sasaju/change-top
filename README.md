# ChangeTop (Only For Gromacs)
调整Gromacs拓扑文件（.top/.itp）中的原子序号及相应的bonds等信息，主要用于非标准残基(Non-standard residue)的处理 \
根据李继存老师的这篇博文编写脚本：https://jerkwin.github.io/2022/01/06/%E8%87%AA%E5%86%99%E8%84%9A%E6%9C%AC%E5%88%9B%E5%BB%BA%E9%9D%9E%E6%A0%87%E5%87%86%E6%AE%8B%E5%9F%BA%E8%9B%8B%E7%99%BD%E7%9A%84GROMACS%E6%8B%93%E6%89%91/

# 安装方法
## Linux(x64架构，暂未编译ARM版本)
下载cgtop
```bash
sudo cp ./cgtop /usr/local/bin
```

## Windows
暂未编译

# 使用方法

## 删除原子及相关信息

```bash
# 删除原子序号5-10的原子（包括5和10），原文件为demo.top，输出结果到demo_del.top
# 以下两个命令效果一致
cgtop del -s 5 -e 10 -p demo.top -o demo_del.top
cgtop del --start 5 --end 10 --top demo.top --out demo_del.top
```

## 提取原子及相关信息

```bash
# 提取原子序号5-10的原子（包括5和10），原文件为demo.top，输出结果到demo_del.top
# 以下两个命令效果一致
cgtop extra -s 5 -e 10 -p demo.top -o demo_dextra.top
cgtop extra --start 5 --end 10 --top demo.top --out demo_extra.top
```

## 修改原子序号及其相关信息

该部分由于修改的复杂性采用csv输入和纯命令行输入的方式来达不同需求的修改，可以利用WPS或者Microsoft Office来编写csv文件

### csv输入

```bash
# 以下两个命令效果一致
cgtop change -c demo.csv -p demo.top -o demo_change.top
cgtop change --csv demo.csv --top demo.top --o demo_change.top
```

###  纯命令行输入
暂未开发

# 关于开发信息
使用Dart编写主要目的是方便后面使用Flutter编写GUI，权当练手了。