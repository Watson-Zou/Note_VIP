//
//  ViewController.m
//  01-链式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "ViewController.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *redView = [[UIView alloc] init];
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    // 设置布局
    [redView makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.equalTo(10);

        
        make.right.equalTo(-10);
        
    }];
    

    // Masonry实现原理
    // 1.给所有UIView提供一个设置约束的方法makeConstraints
    // 2.makeConstraints方法实现：
    // 2.1 创建约束制造者,约束制造者提供了很多设置约束的方法，每个制造约束（equalTo）的方法,方法不需要参数，但是必须返回block,每个block需要传入一个参数，计算什么值。

    // 2.2 把约束制造者传入block中,block用于把所有的约束保存到约束制造者中。
    // 3.执行block,
    // 4.利用约束制造者给view一次性添加所有约束。
    
    // 模仿masonry，设计计算器。
    // 链式编程思想，每一个操作都返回block
    // 1.给所有类提供一个计算方法makeCaculator,
    // 2.创建计算制造者,计算制造者提供了很多方法计算，每个计算方法,方法不需要参数，但是必须返回block,每个block需要传入一个参数，计算什么值。
    // 3.传入block，block用于把所有的计算保存到计算制造者中
    // 4.执行blcok
    // 5.把计算制造者计算的值，返回出去。
    

    // (1 + 2 + 3 + 4) / 5
    
    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
       
        make.add(1).add(2).add(3).add(4).divide(5);
    }];
    
    NSLog(@"%d",result);
    
}



@end
