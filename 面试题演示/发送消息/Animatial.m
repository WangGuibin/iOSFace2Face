//
//  Animatial.m
//  发送消息
//
//  Created by 王贵彬 on 2020/10/18.
//

#import "Animatial.h"
/// 方法查找从自己的方法列表开始查找,没找到就去父类的方法列表查找了
/// 如果实例方法都找不到了 只能去找方法名一致的类方法
@implementation Animatial

//- (void)sendMessage{
//    NSLog(@"%s",__FUNCTION__);
//}

+ (void)sendMessage{
    NSLog(@"%s",__FUNCTION__);
}

@end

@implementation Dog

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(sendMessage)) {
        return [Dog class];
    }
    return [super forwardingTargetForSelector:aSelector];
}

//- (void)sendMessage{
//    NSLog(@"%s",__FUNCTION__);
//}

//+ (void)sendMessage{
//    NSLog(@"%s",__FUNCTION__);
//}

@end

