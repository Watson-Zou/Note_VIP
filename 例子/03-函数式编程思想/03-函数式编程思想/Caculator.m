//
//  Caculator.m
//  03-函数式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

- (Caculator *)caculator:(int(^)(int result))caculatorOperation{
    
    _result += caculatorOperation(_result);
    
    return self;
}
- (Caculator *)equle:(BOOL (^)(int))operation
{
    _isEqule = operation(_result);
    
    return self;
}
@end
