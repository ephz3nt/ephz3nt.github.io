---
title: "Java 变量作用域"
date: 2020-08-23T16:50:36+08:00
tags: 
  - java
  - variable
  - scope
categories:
  -
---

### Java 变量分为:

1. 类变量
2. 实例变量
3. 局部变量

#### 类变量

需要在变量前添加修饰符`static`，可以在方法中直接调用

```java
public class Hello {
    static int number = 10; // 定义类变量
    public static void main(String[] args) {
        System.out.println(number);  // 直接调用
    }
}
```

#### 实例变量

定义格式为`String <type> <name> = <value>;`

实例变量从属于对象，使用时需要进行初始化

```java
public class Hello {
    // 定义实例变量
    String name = "Benjamin";
    int age = 18;
    public static void main(String[] args) {
        Hello instance = new Hello() ; // new 一个当前的Hello对象
        System.out.printf("name: %s, age: %s\n",instance.name,instance.age);
        System.out.println("-------------------------------------------------");
        // 修改实例变量的值
        instance.name = "Bob";
        instance.age = 24;
        System.out.printf("name: %s, age: %s\n",instance.name,instance.age);

    }
}
```

#### 局部变量

定义在方法内部的变量，该方法体使用完后跟随销毁，无法被其他方法直接调用

```java
public class Hello {

    public static void main(String[] args) {
        // 定义局部变量
        String name = "Benjamin";
        int age = 18;
        System.out.printf("name: %s, age: %s\n",name,age);
    }
}
```

