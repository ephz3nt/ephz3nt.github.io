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

[Bilibili]: https://www.bilibili.com/video/av68373450

[当前观看至]: https://www.bilibili.com/video/av68373450?p=45

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

      