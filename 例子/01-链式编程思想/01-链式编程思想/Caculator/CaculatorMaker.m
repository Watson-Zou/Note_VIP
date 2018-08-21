//
//  CaculatorMaker.m
//  01-链式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add
{
    return ^CaculatorMaker *(int value){
        
        self.result += value;
        
        return self;
    };
}

- (CaculatorMaker *(^)(int))muilt
{
    return ^CaculatorMaker *(int value){
        
        self.result *= value;
        
        return self;
    };
}

- (CaculatorMaker *(^)(int))sub
{
    return ^CaculatorMaker *(int value){
        
        self.result -= value;
        
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide
{
    return ^CaculatorMaker *(int value){
        
        self.result /= value;
        
        return self;
    };
}

@end
