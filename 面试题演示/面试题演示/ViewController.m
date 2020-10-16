//
//  ViewController.m
//  面试题演示
//
//  Created by 王贵彬 on 2020/10/15.
//

#import "ViewController.h"
#import "Cat.h"
#import <objc/runtime.h>

/// 敲代码理解 消息转发机制
@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[Cat new] giaogiaogiao];//消息转发处理第一道防线 方法未实现 动态解析 添加方法
    
    [[Cat new] performSelector:@selector(run)]; //第二道防线 把未实现的方法嫁接给别人去实现  有点栽赃的意思~
    
    [[Cat new] performSelector:@selector(sayHi:) withObject:@"耗子🐀"]; //第三道防线 自己实现方法签名 完成转发
    
    // 无警告⚠️版本
    SEL selector = NSSelectorFromString(@"sayHi:");
    Cat *cat = [Cat new];
    ((void (*)(id, SEL,id))[cat methodForSelector:selector])(cat, selector,@"老虎🐅");
}


@end
