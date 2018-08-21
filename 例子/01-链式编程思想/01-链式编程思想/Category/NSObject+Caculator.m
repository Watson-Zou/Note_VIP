//
//  NSObject+Caculator.m
//  01-链式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "NSObject+Caculator.h"

#import "CaculatorMaker.h"

@implementation NSObject (Caculator)
+ (int)makeCaculators:(void (^)(CaculatorMaker *))caculatorMaker
{
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    
    caculatorMaker(maker);
    
    return maker.result;
}
@end
