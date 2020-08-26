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

当前观看至: [https://www.bilibili.com/video/av68373450?p=58](https://www.bilibili.com/video/av68373450?p=58) 

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
     package com.painso.study.array;
     
     import java.util.Arrays;
     
     public class BubbleSort {
         public static void main(String[] args) {
             int[] ary = {23,1,44,545,22,5677,223,11,32,4,13};
     //        System.out.println(Arrays.toString(ary));
             sort(ary);
         }
         public static void sort(int[] array){
             for (int i = 0;i< array.length;i++){
                 for (int j = 0;j < array.length-1;j++){
                     int tmp;
                     if (array[j]>array[j+1]){
                         tmp = array[j+1];
                         array[j+1] = array[j];
                         array[j] = tmp;
                     }
     
                 }
     
             }
             System.out.println(Arrays.toString(array));
     
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

     

   * `冒泡排序还是不太懂，需复习` https://www.bilibili.com/video/av68373450?p=58