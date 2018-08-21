//
//  Caculator.h
//  03-函数式编程思想
//
//  Created by yz on 15/9/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject


@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) int result;

- (Caculator *)caculator:(int(^)(int result))caculator;


- (Caculator *)equle:(BOOL(^)(int result))operation;

@end
