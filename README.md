<h1 align="center">ChangeTop (Only For Gromacs) </h1>

[![DOI](https://zenodo.org/badge/659792234.svg)](https://zenodo.org/badge/latestdoi/659792234)\
调整Gromacs拓扑文件（.top/.itp）中的原子序号及相应的bonds等信息，主要用于非标准残基(Non-standard residue)的处理 \
根据李继存老师的这篇博文编写脚本：https://jerkwin.github.io/2022/01/06/%E8%87%AA%E5%86%99%E8%84%9A%E6%9C%AC%E5%88%9B%E5%BB%BA%E9%9D%9E%E6%A0%87%E5%87%86%E6%AE%8B%E5%9F%BA%E8%9B%8B%E7%99%BD%E7%9A%84GROMACS%E6%8B%93%E6%89%91/

## 安装方法

### Linux(x64架构，暂未编译ARM版本)

下载cgtop
```bash
sudo cp ./cgtop /usr/local/bin
```

### Windows
暂未编译

## 使用方法

### 删除原子及相关信息
<details> <summary>demo.top 点击展开</summary>

```
;
;       Example topology file
;
; The force-field files to be included
#include "amber99.ff/forcefield.itp"

[ moleculetype ]
; name  nrexcl
Urea         3

[ atoms ]
   1  C  1  URE      C      1     0.880229  12.01000   ; amber C  type
   2  O  1  URE      O      2    -0.613359  16.00000   ; amber O  type
   3  N  1  URE     N1      3    -0.923545  14.01000   ; amber N  type
   4  H  1  URE    H11      4     0.395055   1.00800   ; amber H  type
   5  H  1  URE    H12      5     0.395055   1.00800   ; amber H  type
   6  N  1  URE     N2      6    -0.923545  14.01000   ; amber N  type
   7  H  1  URE    H21      7     0.395055   1.00800   ; amber H  type
   8  H  1  URE    H22      8     0.395055   1.00800   ; amber H  type

[ bonds ]
    1    2
    1    3
    1    6
    3    4
    3    5
    6    7
    6    8

[ dihedrals ]
;   ai    aj    ak    al funct  definition
     2     1     3     4   9
     2     1     3     5   9
     2     1     6     7   9
     2     1     6     8   9
     3     1     6     7   9
     3     1     6     8   9
     6     1     3     4   9
     6     1     3     5   9

[ dihedrals ]
     3     6     1     2   4
     1     4     3     5   4
     1     7     6     8   4

[ position_restraints ]
; you wouldn't normally use this for a molecule like Urea,
; but we include it here for didactic purposes
; ai   funct    fc
   1     1     1000    1000    1000 ; Restrain to a point
   2     1     1000       0    1000 ; Restrain to a line (Y-axis)
   3     1     1000       0       0 ; Restrain to a plane (Y-Z-plane)

[ dihedral_restraints ]
; ai   aj    ak    al  type  phi  dphi  fc
    3    6     1    2     1  180     0  10
    1    4     3    5     1  180     0  10

; Include TIP3P water topology
#include "amber99.ff/tip3p.itp"

[ system ]
Urea in Water

[ molecules ]
;molecule name   nr.
Urea             1
SOL              1000
```
</details>

```bash
# 删除原子序号5-10的原子（包括5和10），原文件为demo.top，输出结果到demo_del.top
# 以下两个命令效果一致
cgtop del -s 5 -e 10 -p demo.top -o demo_del.top
cgtop del --start 5 --end 10 --top demo.top --out demo_del.top

```
<details> <summary>cgtop del 执行结果</summary>

```
;
;       Example topology file
;
; The force-field files to be included
#include "amber99.ff/forcefield.itp"

[ moleculetype ]
; name  nrexcl
Urea         3

[ atoms ]
   1  C  1  URE      C      1     0.880229  12.01000   ; amber C  type
   2  O  1  URE      O      2    -0.613359  16.00000   ; amber O  type
   3  N  1  URE     N1      3    -0.923545  14.01000   ; amber N  type
   4  H  1  URE    H11      4     0.395055   1.00800   ; amber H  type

[ bonds ]
    1    2
    1    3
    3    4

[ dihedrals ]
;   ai    aj    ak    al funct  definition
     2     1     3     4   9

[ dihedrals ]

[ position_restraints ]
; you wouldn't normally use this for a molecule like Urea,
; but we include it here for didactic purposes
; ai   funct    fc
   1     1     1000    1000    1000 ; Restrain to a point
   2     1     1000       0    1000 ; Restrain to a line (Y-axis)
   3     1     1000       0       0 ; Restrain to a plane (Y-Z-plane)

[ dihedral_restraints ]
; ai   aj    ak    al  type  phi  dphi  fc

; Include TIP3P water topology
#include "amber99.ff/tip3p.itp"

[ system ]
Urea in Water

[ molecules ]
;molecule name   nr.
Urea             1
SOL              1000

```

</details>

### 提取原子及相关信息

```bash
# 提取原子序号5-10的原子（包括5和10），原文件为demo.top，输出结果到demo_del.top
# 以下两个命令效果一致
cgtop extra -s 5 -e 10 -p demo.top -o demo_extra.top
cgtop extra --start 5 --end 10 --top demo.top --out demo_extra.top
```

<details> <summary>cgtop extra 执行结果</summary>

```
;
;       Example topology file
;
; The force-field files to be included
#include "amber99.ff/forcefield.itp"
[ moleculetype ]
; name  nrexcl
[ atoms ]
   5  H  1  URE    H12      5     0.395055   1.00800   ; amber H  type
   6  N  1  URE     N2      6    -0.923545  14.01000   ; amber N  type
   7  H  1  URE    H21      7     0.395055   1.00800   ; amber H  type
   8  H  1  URE    H22      8     0.395055   1.00800   ; amber H  type

[ bonds ]
    1    6
    3    5
    6    7
    6    8

[ dihedrals ]
;   ai    aj    ak    al funct  definition
     2     1     3     5   9
     2     1     6     7   9
     2     1     6     8   9
     3     1     6     7   9
     3     1     6     8   9
     6     1     3     4   9
     6     1     3     5   9

[ dihedrals ]
     3     6     1     2   4
     1     4     3     5   4
     1     7     6     8   4

[ position_restraints ]
; you wouldn't normally use this for a molecule like Urea,
; but we include it here for didactic purposes
; ai   funct    fc

[ dihedral_restraints ]
; ai   aj    ak    al  type  phi  dphi  fc
    3    6     1    2     1  180     0  10
    1    4     3    5     1  180     0  10

; Include TIP3P water topology
#include "amber99.ff/tip3p.itp"

[ system ]
[ molecules ]
;molecule name   nr.
```

</details>


### 修改原子序号及其相关信息

该部分由于修改的复杂性采用csv输入和纯命令行输入的方式来达不同需求的修改，可以利用WPS或者Microsoft Office来编写csv文件

- csv输入
<details> <summary>demo.csv</summary>

```csv
2,24
3,25
4,26
```
第一列为原始index，第二列为新的index，程序会自动更新bonds等项下的数字
</details>


```bash
# 以下两个命令效果一致
cgtop change -c demo.csv -p demo.top -o demo_change.top
cgtop change --csv demo.csv --top demo.top --out demo_change.top
```
<details> <summary>cgtop change 执行结果</summary>

```
;
;       Example topology file
;
; The force-field files to be included
#include "amber99.ff/forcefield.itp"

[ moleculetype ]
; name  nrexcl
Urea         3

[ atoms ]
   1  C  1  URE      C      1     0.880229  12.01000   ; amber C  type
  24  O  1  URE      O     24    -0.613359  16.00000   ; amber O  type
  25  N  1  URE     N1     25    -0.923545  14.01000   ; amber N  type
  26  H  1  URE    H11     26     0.395055   1.00800   ; amber H  type
   5  H  1  URE    H12      5     0.395055   1.00800   ; amber H  type
   6  N  1  URE     N2      6    -0.923545  14.01000   ; amber N  type
   7  H  1  URE    H21      7     0.395055   1.00800   ; amber H  type
   8  H  1  URE    H22      8     0.395055   1.00800   ; amber H  type

[ bonds ]
    1   24
    1   25
    1    6
   25   26
   25    5
    6    7
    6    8

[ dihedrals ]
;   ai    aj    ak    al funct  definition
    24     1    25    26   9
    24     1    25     5   9
    24     1     6     7   9
    24     1     6     8   9
    25     1     6     7   9
    25     1     6     8   9
     6     1    25    26   9
     6     1    25     5   9

[ dihedrals ]
    25     6     1    24   4
     1    26    25     5   4
     1     7     6     8   4

[ position_restraints ]
; you wouldn't normally use this for a molecule like Urea,
; but we include it here for didactic purposes
; ai   funct    fc
   1     1     1000    1000    1000 ; Restrain to a point
  24     1     1000       0    1000 ; Restrain to a line (Y-axis)
  25     1     1000       0       0 ; Restrain to a plane (Y-Z-plane)

[ dihedral_restraints ]
; ai   aj    ak    al  type  phi  dphi  fc
   25    6     1   24     1  180     0  10
    1   26    25    5     1  180     0  10

; Include TIP3P water topology
#include "amber99.ff/tip3p.itp"

[ system ]
Urea in Water

[ molecules ]
;molecule name   nr.
Urea             1
SOL              1000

```

</details>

- 纯命令行输入
暂未开发

**注意**：程序输出不会覆盖文件，会在原有文件上增加内容，如果输出文件有误，请删除原来的输出文件再重新执行命令！！！

## 关于开发信息
使用Dart编写主要目的是方便后面使用Flutter编写GUI，权当练手了。