//
//  ViewController.m
//  03-函数式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

#import "Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

// 把每一个操作都写成一连串的函数或者方法，使代码高度聚合，便于管理.
// 每次都可以调用方法，因此肯定要每次都返回自己。

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2  * 5 == 10
    Caculator *c = [[Caculator alloc] init];
    
    // 计算2  * 5 ，并且判断是否等于10
   BOOL isqule = [[[c caculator:^(int result) {
        result += 2;
        result *= 5;
        return result;
    }] equle:^BOOL(int result) {
        
        return result == 10;
        
    }] isEqule];
    
    NSLog(@"%d",isqule);
    
}


@end
