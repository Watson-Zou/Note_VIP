//
//  NSObject+KVO.h
//  02-响应式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)
- (void)xmg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
