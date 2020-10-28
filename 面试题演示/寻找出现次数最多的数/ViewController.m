//
//  ViewController.m
//  寻找出现次数最多的数
//
//  Created by 王贵彬 on 2020/10/27.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr = @[@1,@2,@3,@2,@2,@2,@5,@4,@2];
    NSNumber *number = [self findMaxCountNumberWithArray:arr];
    NSLog(@"number: %@",number);
}

//数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。例如输入一个长度为9的数组{1,2,3,2,2,2,5,4,2}。由于数字2在数组中出现了5次，超过数组长度的一半，因此输出2。如果不存在则输出0。

- (NSNumber *)findMaxCountNumberWithArray:(NSArray<NSNumber *> *)numberArray{
    if (!numberArray.count || !numberArray) {
        return @(0);
    }
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    NSInteger half = numberArray.count/2;
    NSInteger count = 1;
    for (NSNumber *num in numberArray) {
        if ([dictM.allKeys containsObject:num.stringValue]) {
            count = [dictM[num.stringValue] integerValue] + 1;
            [dictM setObject:@(count) forKey:num.stringValue];
        }else{
            count = 1;
            [dictM setObject:@(count) forKey:num.stringValue];
        }
    }

    NSString *max = [[dictM.allValues valueForKeyPath:@"@max.integerValue"] stringValue];
    if (max.integerValue > half) {
        return [dictM allKeysForObject:@(max.integerValue)].firstObject;
    }
    return @(0);
}



@end
