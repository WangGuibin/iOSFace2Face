//
//  NSString+Extra.m
//  面试题演示
//
//  Created by 王贵彬 on 2020/10/17.
//

#import "NSString+Extra.h"
#import <objc/runtime.h>

@implementation NSString (Extra)

+ (void)load{
    Method m1 = class_getInstanceMethod([self class], @selector(substringToIndex:));
    Method m2 = class_getInstanceMethod([self class], @selector(wgb_substringToIndex:));
    BOOL didAddMethod = class_addMethod([self class], @selector(substringToIndex:), method_getImplementation(m2), method_getTypeEncoding(m2));
    if (didAddMethod) {
        class_replaceMethod([self class], @selector(wgb_substringToIndex:), method_getImplementation(m1), method_getTypeEncoding(m1));
    }else{
        method_exchangeImplementations(m1, m2);
    }

}

- (NSString *)wgb_substringToIndex:(NSUInteger)to{
    if (to > self.length) {
        to = self.length;
    }
    NSLog(@"走了自定义的方法:>> %@",NSStringFromSelector(_cmd));
    return [self wgb_substringToIndex:to];
}



//- (NSString *)substringToIndex:(NSUInteger)to{
//    if (self.length < to) {
//        to = self.length;
//    }
//    NSLog(@"这是走了分类的方法");
//    return [self substringToIndex:to];
//    //递归调用了 不能直接这样操作 可以采用方法交换 method swizzle
//}

@end
