//
//  XMGKVONotifying_Person.m
//  02-响应式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "XMGKVONotifying_Person.h"

#import <objc/runtime.h>

@implementation XMGKVONotifying_Person

- (void)setAge:(int)age
{
    [super setAge:age];
    
    // 调用KVO
    
    
    // 获取观察者
    id observer =  objc_getAssociatedObject(self, @"observer");
    
    // 调用观察者的方法
    [observer observeValueForKeyPath:@"age" ofObject:observer change:nil context:nil];
    
}

@end
