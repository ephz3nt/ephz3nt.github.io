---
title: "Java 基础"
date: 2020-08-23T17:25:46+08:00
tags: 
  - basic
  - java
categories:
  -
---

## 狂神说JAVA学习笔记 - JavaSE基础部分

Bilibili: [https://www.bilibili.com/video/av68373450](https://www.bilibili.com/video/av68373450)

当前观看至: [https://www.bilibili.com/video/av68373450?p=63](https://www.bilibili.com/video/av68373450?p=63) 

### 运算符

1. 不同类型运算返回值

   ```java
   double a = 55;
   float b = 10F;
   long c = 10;
   int d = 20;
   short e = 25;
   byte f = 25;
   ```

   * 如果变量`a+b+c+d`相加，返回值类型为`double`
* 如果变量`b+c+d+e`相加，返回值类型为`float`
   * 如果`d+e`相加，返回值为int
   * 如果`e+f`相加，返回值为int
   * 。。。
   
   结论 

   * 如果一组不同类型的变量进行运算，返回值取类型最大数据类型
* 如果其中最大的数据类型为`int`，返回值为`int`
   * 如果小于`int`的类型，返回`int`
   
2. 自增、自减  `++` `--`

   ```java
   package operator;
   
   public class Demo01 {
       public static void main(String[] args) {
           int a = 1;
           int b = a++;
           int c = ++a;
           System.out.println(a);
           System.out.println(b);
           System.out.println(c);
       }
   }
   ```

   输出结果为

   ```shell
   3
   1
   3
   ```

   `a++ ==  a = a+1`

   `++a == a = a+1`

   乍看好像都一样，实则进行赋值时顺序有所不同

   ```java
   int b = a++; // 先把a的值复制给b再做自增运算
   int c = ++a; // 先进行自增运算再复制给c
   ```

   所以b的值是上述的`1`， 不信我们在b后紧跟一条输出`a 和 b`看看结果

   ```java
   package operator;
   
   public class Demo01 {
       public static void main(String[] args) {
           int a = 1;
           int b = a++;
           System.out.println(a);
           System.out.println(b);
           int c = ++a;
           System.out.println(a);
           System.out.println(b);
           System.out.println(c);
       }
   }
   ```

   

   ```shell
   2
   1
   3
   1
   3
   
   Process finished with exit code 0
   ```

3. 短路运算

    逻辑于运算中如果第一个为`false`则不再进行后面的运算

     ```java
     package operator;
     
     public class Demo01 {
         public static void main(String[] args) {
             int c = 10;
             System.out.println((c < 11 && c++ < 100)); // 添加自增运算验证第二个表达式是否执行
             System.out.println(c);
         }
     }
     /* 
     c < 11 为真 继续后面的表达式运算
     结果为：
     true
     11
     */
     ```

     ```java
     package operator;
     
     public class Demo01 {
         public static void main(String[] args) {
             int c = 10;
             System.out.println((c > 11 && c++ < 100)); // 添加自增运算验证第二个表达式是否执行
             System.out.println(c);
         }
     }
     /* 
     c > 11 为假 直接忽略后面的表达式运算返回假
     结果为：
     false
     10
     */
     ```

     > 逻辑或同理 

4. 字符串拼接顺序

   ```java
   int a = 10;
   int b = 20;
   System.out.println(""+a+b);
   // 结果为 1020
   int a = 10;
   int b = 20;
   System.out.println(a+b+"");
   // 结果为 30
   ```

   字符串拼接所在位置会影响输出结果，如果字符串在前则后方的`int`变量以字符串拼接，如果整型在前则进行算术运算

5. 三元运算符

    `x ? y : z`

    如果 `x` 的运算结果为`true`则值为`y`

    反之为`z`

### 条件表达式

1. 九九乘法表

   ```java
   package com.painso.study.condition;
   
   /**
    * @author ephz3nt
    * @version 1.0
    *
    * @description 使用for实现99乘法表
    * 1x1=1
    * 1x2=2 2x2=4
    * 1x3=3 2x3=6 3x3=9
    * 1x4=4 2x4=8 3x4=12 4x4=16
    * 1x5=5 2x5=10 3x5=15 4x5=20 5x5=25
    * 1x6=6 2x6=12 3x6=18 4x6=24 5x6=30 6x6=36
    * 1x7=7 2x7=14 3x7=21 4x7=28 5x7=35 6x7=42 7x7=49
    * 1x8=8 2x8=16 3x8=24 4x8=32 5x8=40 6x8=48 7x8=56 8x8=64
    * 1x9=9 2x9=18 3x9=27 4x9=36 5x9=45 6x9=54 7x9=63 8x9=72 9x9=81
    */
   public class D1 {
       public static void main(String[] args) {
           for(int x =1;x<=9;x++){ // 定义x 为被乘的数，不超过9
               for(int y =1;y<=x;y++){ // 定义y为乘数，循环乘到不满足<=x退出
                   System.out.printf("%dx%d=%d\t",y,x,y*x); // 使用格式化输出 "乘数x被乘数=积" , 不换行
               }
               System.out.println(); // 嵌套for执行结束后输出换行
           }
       }
   }
   ```

2. 打印金字塔三角形

   ```java
      package com.painso.study.condition;
      
      public class D2 {
          public static void main(String[] args) {
              /**
               * 打印一个三角形
               * 1. 把三角形拆分成左右两边
               * 2. 定义几个矩形框起来
               * 3. 打印左边空白区域
               * 4. 打印三角形左边
               */
              for (int i = 1; i <= 5; i++) {
                  // 打印空白区
                  for (int j = 5; j >= i; j--) {
                      System.out.print(" ");
                  }
                  // 反向打印三角形左边
                  for (int j = 1; j <= i; j++) {
                      System.out.print("*");
                  }
                  // 打印三角形右边
                  for (int j = 1; j < i; j++) {
                      System.out.print("*");
                  }
                  System.out.println();
              }
          }
      }
      // 输出
           *
          ***
         *****
        *******
       *********
   ```


### 方法

1. 方法的重载

   * 重载就是在一个类中，有相同的函数名称，但形参不同的函数
   
   * 方法的重载规则
     1. 方法名称必须相同
     2. 参数列表必须不同(个数、类型、排列顺序)
     3. 方法的返回值类型可以相同也可以不同
     4. 仅仅返回值类型不同不足以成为方法的重载
   
   * 实现理论
   
     方法名称相同时，编译器会根据调用方法的参数个数、参数类型等去逐个匹配，以选择对应的方法，如果匹配失败则编译器报错
   
2. 可变参数
   * JDK 1.5开始支持
   * 在方法声明中，在制定参数类型后加一个省略号`...`
   * 一个方法中只能制定一个可变参数，它必须是该方法的最后一个参数。
   * 可变参数的传入类型必须一致
   * 任何普通的参数必须在它之前声明

3. 递归 `Recursion`

   * 自己调用自己
   * 利用递归可以用简单的程序来解决一些复杂的问题
   * 它通常把一个大型复杂的问题层层转化为一个与原问题相似的且规模较小的问题来求解
   * 递归策略只需少量的程序代码就可描述出解题过程所需要的多次重复计算，大大减少了程序的代码量
   * 递归的能力在与用有限的语句来定义对象的无限集合
   * 递归结构包含两个部分
   * 1. 递归头: 什么时候不调用自身的方法。如果没有头，将陷入死循环
     2. 递归体: 什么时候需要调用自身方法

   * 下面的代码体现了递归的 `它通常把一个大型复杂的问题层层转化为一个与原问题相似的且规模较小的问题来求解`

     ```java
     package com.painso.study.method;
     
     public class Recursion2 {
         /* 阶乘
             2! = 2 * 1
             3! = 3 * 2 * 1
             5! = 5 * 4 * 3 * 2 * 1
          */
         public static void main(String[] args) {
             /*
                 计算5的阶乘
                 流程如下:
                 main -&gt; recursion(5) -&gt; recursion(4) -&gt; recursion(3) -&gt; recursion(2) -&gt; recursion(1)
                 由于递归体if判断了参数为1直接返回
                 所以最后的recursion(1)得到一个具体值 1 后开始回传
                 recursion(1):1  返回给       recursion(2) == 2*1 == 2
                 recursion(2):2  继续返回给    recursion(3) == 3*2 == 6
                 recursion(3):6  继续返回给    recursion(4) == 4*6 == 24
                 recursion(4):24 继续返回给    recursion(5) == 5*24 == 120
              */
             System.out.println(recursion(5));
         }
     
         // 使用递归计算阶乘
         public static int recursion(int n){
             if (n == 1){
                 return n;
             }else{
                 /*
                    5的阶乘这里等于 return recursion(5); == 5 * 4 * 3 * 2 * 1
                    因为我们在上面的if判断如果n==1直接返回从而跳出递归体
                  */
                 return n*recursion(n-1);
             }
     
         }
     }dd
     ```

   * 递归适用于少量计算，因会在栈积压栈空间，容易引发异常且资源消耗很大(因为一直在嵌套调用方法)

### 数组

1. 冒泡排序

   * 比较数组中相邻的两个数值大小，如果`a[0]>a[1]` 则进行位置互换 

   * java 实现

     ```java
     package com.painso.study.array2;
     
     import java.util.Arrays;
     
     /**
      * @author ephz3nt
      * @version 1.0
      * @description 冒泡排序算法实现
      */
     public class BubbleSort {
     
         // sort method
         public static int[] sort(int[] s){
             /* 一层for循环
                二层循环每次排序结束后的处理
              */
             for (int i = 0; i < s.length-1;i++){
                 /*
                 二层for循环
                 实际进行排序算法的循环体
                 一二层的条件s.length要-1 否则会触发二层循环下标越界
                  */
                 //
                 for (int j = 0; j < s.length-1;j++ ){
                     // 定义临时变量用作交换数组值的位置
                     int tmp;
                     // 判断如果当前值>后一位索引的值则互换位置
                     if (s[j] > s[j+1]){
                         tmp = s[j];
                         s[j] = s[j+1];
                         s[j+1] = tmp;
                     }else{
                         continue;
                     }
                 }
             }
             return s;
         }
     
         public static void main(String[] args) {
             int[] s1 = {9,7,5,3,1,55,71,555,9879,11};
             int[] s2 = sort(s1);
             for (int i = 0; i < s2.length; i++) {
                 System.out.printf("%d\t",s2[i]);
             }
             System.out.println();
             for (int i = 0; i < s1.length; i++) {
                 System.out.printf("%d\t",s1[i]);
             }
             System.out.println();
     
             Arrays.sort(s1);
             for (int i = 0; i < s1.length; i++) {
                 System.out.printf("%d\t",s1[i]);
             }
         }
     
     }
     ```

   * 顺便发一下Go的实现，Go的互换支持更简洁的写法 `a,b = b,a`

     ```go
     package main
     
     import (
     	"fmt"
     )
     
     func sort(arr []int) []int {
     	for j := 0; j < len(arr)-1; j++ {
     		for i := 0; i < len(arr)-1; i++ {
     			if arr[i] > arr[i+1] {
     				arr[i], arr[i+1] = arr[i+1], arr[i]
     			}
     		}
     	}
     	return arr
     }
     
     func main() {
     	//{3,22,1,55,33,76,32,22}
     	var b = []int{3, 23, 1, 55, 33, 76, 8, 32, 22}
     	fmt.Println(sort(b))
     
     }
     ```

     

   * 冒泡排序的关键

     * 假设有以下数组 

       * ```java
         int[] s = {9,7,5,3,1};
             for (int i = 0; i < s.length-1;i++){
                 for (int j = 0; j < s.length-1;j++ ){
                     int tmp;
                     if (s[j] > s[j+1]){ // [1]
                         tmp = s[j];
                         s[j] = s[j+1];
                         s[j+1] = tmp;
                     }else{
                         continue;
                     }
                 }
             }
         // 执行嵌套循环顺序为 
         /* 0-0 表示 外层和内层的第几次循环
         // 原始数据 	9,7,5,3,1
         	      1-1: 7,9,5,3,1 // 第一次 因9>7则互换位置
                   1-2: 7,5,9,3,1 // 第二次 因9>5则互换位置
                   1-3: 7,5,3,9,1 // 第三次 因9>3则互换位置
                   1-4: 7,5,3,1,9 // 第四次 因9>3则互换位置
                   1-5: 7,5,3,1,9 // 第五次 这里注意上方[1]处比较的是 s[j] > s[j+1] 因为这里是第五次循环 j的值是4 下标为4的值正好是最后一位：9 ， 如果比较 下标为5的话就会提示下标越界，因为数组s一共才5个元素，下标从0开始最高为4而已，所以需要在二层for条件表达式减去1
                   既然第二层循环条件表达式减去1了外层也应同样减去1, 不然后面两次只是重复运行
         */
         ```

2. 稀疏矩阵

   * 稀疏矩阵应用于一个矩阵中其元素大部分为零的矩阵

   * 稀疏矩阵包含 行,列,值 固定三列

   * 其中第一行为矩阵参数信息 包含 X行,Y列,Z个值

   * 实现

     ```java
     package com.painso.study.array2;
     
     /**
      * @author ephz3nt
      * @version 1.0
      * @description Sparse Matrix
      */
     public class SparseMatrix {
         /**
          * 稀疏矩阵，在数值分析中，是其元素大部分为零的矩阵。
          * 反之，如果大部分元素都非零，则这个矩阵是稠密的。
          * 在科学与工程领域中求解线性模型时经常出现大型的稀疏矩阵。
          * 在使用计算机存储和操作稀疏矩阵时，经常需要修改标准算法以利用矩阵的稀疏结构。
          * 由于其自身的稀疏特性，通过压缩可以大大节省稀疏矩阵的内存代价。
          * 稀疏矩阵包含 行,列,值 固定三列
          *         0	0	0	0	0
          *         0	0	1	0	0
          *         0	0	0	2	0
          *         0	0	0	0	0
          *         0	0	0	0	0
          * 其中第一行为矩阵参数信息 包含 X行,Y列,Z个值
          * 如上矩阵 包含 5行,5列,2个值
          * 用稀疏矩阵表示为
          *         5    6   2   参数信息: 5行 5列 2个值
          *         1    2   1   1行2列值为1
          *         2    3   2   2行3列值为2
          */
         // 定义 压缩方法
         public static int[][] zip(int[][] s){
             // 定义稀疏矩阵数组行变量，需遍历原数组
             int sparseLine = 0;
             // 获取原数组中值的个数，定义稀疏数组前置需求
             for (int i = 0; i < s.length; i++) {
                 for (int j = 0; j < s[i].length; j++) {
                     if (s[i][j] != 0){
                         sparseLine++;
                     }
                 }
             }
             // 获取到值个数sparseLine，定义稀疏矩阵数组
             // 因第一行需额外记录矩阵参数信息需要+1，列为固定3列
             int[][] sparseMatrix = new int[sparseLine+1][3];
     
             // 定义x存储行信息，定义y存储总共多少值用于求列，定义valueSum值总量
             int x=0;
             int y =0;
             int valueSum = 0;
             for (int i = 0; i < s.length; i++) {
                 for (int j = 0; j < s[i].length; j++) {
                     if (s[i][j] !=0){
                         valueSum++;
                         // 设置 有效值的x，y轴坐标及值
                         sparseMatrix[valueSum][0] = i;
                         sparseMatrix[valueSum][1] = j;
                         sparseMatrix[valueSum][2] = s[i][j];
                     }
                     y++;
                 }
                 x++;
             }
             // 定义稀疏数组参数 行的值
             sparseMatrix[0][0] = x;
             // 定义稀疏数组参数 列的值
             sparseMatrix[0][1] = y/x;
             // 定义稀疏数组参数 值总量
             sparseMatrix[0][2] = valueSum;
             // 输出并返回压缩后的稀疏矩阵
     //        for (int i = 0; i < sparseMatrix.length; i++) {
     //            for (int j = 0; j < sparseMatrix[i].length; j++) {
     //                System.out.print(sparseMatrix[i][j]+"\t");
     //            }
     //            System.out.println();
     //        }
             return sparseMatrix;
         }
         // 定义解压缩稀疏矩阵方法
         public static int[][] unzip(int[][] s){
             // 定义解压缩数组参数信息
             // 这里看着方括号很多 其实 s[0][0] 和 s[0][1] 为稀疏数组元信息的 行与列的值
             int[][] unCompressMatrix = new int[s[0][0]][s[0][1]];
     
             // 遍历还原值坐标 这里行从1开始因为第0行是稀疏数组元信息
             for (int i = 1; i < s.length; i++) {
                 int x=0;
                 int y=0;
                 int value=0;
                 // 取 x,y坐标轴 s[i][0], s[i][1] 的值 s[i][2] 赋给unCompressMatrix
                 unCompressMatrix[s[i][0]][s[i][1]] = s[i][2];
             }
                 return unCompressMatrix;
         }
         public static void main(String[] args) {
             /*
             定义一个  5*5 的矩阵
             其中有两个值 1,2
             坐标分别为
             1： 第一行第二列
             2： 第二行第三列
             0	0	0	0	0
             0	0	1	0	0
             0	0	0	2	0
             0	0	0	0	0
             0	0	0	0	0
              */
             int[][] s1 = new int[5][6];
             s1[1][2] = 1;
             s1[2][3] = 2;
             System.out.println("输出原数组");
             for (int i = 0; i < s1.length; i++) {
                 for (int j = 0; j < s1[i].length; j++) {
                     System.out.print(s1[i][j]+"\t");
                 }
                 System.out.println();
             }
             System.out.println("==========================");
             int[][] zipArray = zip(s1);
             System.out.println("压缩原数组");
             for (int i = 0; i < zipArray.length; i++) {
                 for (int j = 0; j < zipArray[i].length; j++) {
                     System.out.print(zipArray[i][j]+"\t");
                 }
                 System.out.println();
             }
             System.out.println("解压缩稀疏矩阵");
             System.out.println("==========================");
             int[][]  unCompressMatrix=unzip(zipArray);
             for (int i = 0; i < unCompressMatrix.length; i++) {
                 for (int j = 0; j < unCompressMatrix[i].length; j++) {
                     System.out.print(unCompressMatrix[i][j]+"\t");
                 }
                 System.out.println();
             }
         }
     }
     ```

### 面向对象 `Object-Oriented Programming, OOP`

* 面向过程思想
  * 步骤清晰简单，1->2->3...
  * 面向过程难以处理复杂的问题，适合处理较简单的问题

* 面向对象思想
  * 物以类聚，分类的思维模式，思考问题首先会解决问题需要哪些分类，然后对这些分类进行单独思考。最后才对某个分类下的具体实现进行面向过程的思索。
  * 面向对象适合处理复杂的问题与需多人协作的问题
* 对于描述复杂的事物，为了宏观上把握从整体上合理分析，我们需要使用面向对象思路来分析整个系统。但是具体到微观操作仍需要面向过程的思路。
* **面向对象编程的本质： 以类的方式组织代码，以对象的方式组织(封装)数据**
* 抽象 抽出共同点
* 三大特性
  1. 封装 `数据包装对外提供相应接口`
  2. 继承 `对应现实继承`
  3. 多态 `同一事物多种形态`

* 从认识的角度考虑的是先有对象后有类。 对象是指具体的事物，类是抽象的，是对对象的抽象
* 从代码运行的角度考虑的是先有类后有对象。类是对象的模板。
* 一个类里面只有属性和方法。`再牛逼的人写都一样`