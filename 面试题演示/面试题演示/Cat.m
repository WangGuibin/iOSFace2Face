//
//  Cat.m
//  面试题演示
//
//  Created by 王贵彬 on 2020/10/16.
//

#import "Cat.h"
#import <objc/runtime.h>
#import "Dog.h"

@implementation Cat

///mark:- 第一道防线  解析实例方法 如果方法选择子即方法名存在则返回YES 不存在则返回NO
/// 一般要动态添加方法去处理 这一步要返回YES才能生效
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"giaogiaogiao"]) {
        //添加giaogiaogiao的方法和实现
        class_addMethod(self, sel, (IMP)giaoMethod, "v@:");
        return YES;
    }
    
    if (sel == @selector(run)) {
        //这一步先不添加
        return NO;
    }
    
    return [super resolveInstanceMethod:sel];
}

void giaoMethod(id self,SEL cmd){
    NSLog(@"giao giao giao");
}


///mark:- 第二道防线
//让狗去代替猫跑 转发给别的对象去实现这个对应的方法
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(run)) {
        return [Dog new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

///mark:- 第三道防线  拦截方法签名 自己创建一个方法签名返回
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(sayHi:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 处理方法签名 指定对象去实现方法  如果不处理这个方法就会走`doesNotRecognizeSelector:` 
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    Dog *dog = [Dog new];
    SEL sel = [anInvocation selector];
    if ([dog respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:dog];//转发给狗去实现
    }else{
        [super forwardInvocation:anInvocation];
    }
}


///方法未实现的话会走这个方法
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    //不调用super的话 就不会断言崩溃
//    [super doesNotRecognizeSelector:aSelector];
    NSLog(@"%@方法未找到对应的实现,确定实现了这个方法吗?????",NSStringFromSelector(aSelector));
}

@end
