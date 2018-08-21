//
//  NSObject+Caculator.h
//  01-链式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CaculatorMaker;
@interface NSObject (Caculator)

// 计算
+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end
