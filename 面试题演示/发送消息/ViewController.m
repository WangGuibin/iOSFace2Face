//
//  ViewController.m
//  发送消息
//
//  Created by 王贵彬 on 2020/10/18.
//

#import "ViewController.h"
#import "Animatial.h"
#import <objc/runtime.h>

@interface ViewController ()
//面试题: 为啥不可变类型用copy而不用strong修饰的原因,出于安全考虑的 strong也行就是要加copy调用
// 类似的题还有 代理用assin和weak修饰的区别,assin修饰不用时需要手动置为nil,不然会crash,weak是自动释放的
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSMutableArray *arr2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr2 = [NSMutableArray array];
    [self.arr2  addObjectsFromArray:@[@6,@7,@8]];
//    self.arr1 = self.arr2; //关键在于这一步 加个copy就没事儿了
    self.arr1 = [self.arr2 copy];//浅拷贝
    NSLog(@"arr1 %@",self.arr1);
    [self.arr2 addObject:@10];
    NSLog(@"arr1 %@",self.arr1); //如果之前那句赋值不加copy,这里会受到arr2的影响

    /// 深拷贝和浅拷贝不能简单只靠copy和mutableCopy来作为区分
    /// 可变容器类的拷贝都是深拷贝 不可变->可变也是深拷贝
    //https://www.cnblogs.com/beckwang0912/p/7212075.html
//    No1：可变对象的copy和mutableCopy方法都是深拷贝（区别完全深拷贝与单层深拷贝） 。
//    No2：不可变对象的copy方法是浅拷贝，mutableCopy方法是深拷贝。
//    No3：copy方法返回的对象都是不可变对象。
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //发送消息 测试OC方法调用链的走向~
    [[Dog new] sendMessage];
}


@end
