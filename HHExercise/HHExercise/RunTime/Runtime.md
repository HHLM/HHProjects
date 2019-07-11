//
//  Runtime_md.metal
//  HHExercise
//
//  Created by Now on 2019/4/26.
//  Copyright © 2019 where are you. All rights reserved.
//

# runtime知识点总结
runtime 知识点总结：
 1.OC是一门动态语言，动态语言的本质就是因为有了Runtime，在运行时候可以进行消息转发，可以讲编译时候工作延迟到运行时期。
这个不是由编译器来做，而是有运行时来做。

struct objc_class {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;              //指针指向其所属的类
#if !__OBJC2__
    Class _Nullable super_class                              //父类
    const char * _Nonnull name                              //常量
    long version                                                       //版本
    long info                                                             //信息
    long instance_size                                             //所占大小
    struct objc_ivar_list * _Nullable ivars                 //成员列表
    struct objc_method_list * _Nullable * _Nullable methodLists               //方法列表
    struct objc_cache * _Nonnull cache                       //缓存方法列表的 使用过的方法就在此结构体中
    struct objc_protocol_list * _Nullable protocols          //协议列表
#endif
    
} OBJC2_UNAVAILABLE;



    - 每一个对象都是一个object_class的结构体，在结构体中有一个isa指针指向其所属的类
    - 类对象的isa指向元类 元类对象的isa 指向根元类，根元类对象的isa指向自己


2.Method 方法 也是一个结构体 里面有个SEL 方法名 IMP是一个函数指针  *types 一般是 'V@:'

struct method_t {
    SEL name;
    const char *types;
    MethodListIMP imp;
    
    struct SortBySELAddress :
    public std::binary_function<const method_t&,
    const method_t&, bool>
    {
        bool operator() (const method_t& lhs,
                         const method_t& rhs)
        { return lhs.name < rhs.name; }
    };
};

IMP 是一个函数指针 指向方法所在地址

 typedef void (*IMP)(void /* id, SEL, ... */ );
 IMP 有两个默认参数 id 和 SEL ， id 就是方法中的 self， 和objc_msgSend()传递是一样的
 objc_msgSend(self，SEL)

 2.消息转发机制



