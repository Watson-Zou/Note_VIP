//
//  NSObject+KVO.m
//  02-响应式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "NSObject+KVO.h"

#import <objc/runtime.h>

#import "XMGKVONotifying_Person.h"

@implementation NSObject (KVO)

- (void)xmg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
//    XMGKVONotifying_Person *person = [[XMGKVONotifying_Person alloc] init];    
    // 修改isa指针,就是把当前对象指向一个新类
    object_setClass(self, [XMGKVONotifying_Person class]);
    
    // 给对象绑定观测者对象
    objc_setAssociatedObject(self, @"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
