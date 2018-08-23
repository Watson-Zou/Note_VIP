//
//  ZCPeripheralManager.h
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-29.
//  Copyright (c) 2014年 fq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface ZCPeripheralManager : NSObject<CBPeripheralManagerDelegate>
//周边设备管理类
@property(nonatomic,strong)CBPeripheralManager*peripheralManager;
//可变服务特性
@property(nonatomic,strong)CBMutableCharacteristic*transferCharacteristic;
@property(nonatomic,copy)NSString*message;
@property(nonatomic)int sendDataIndex;
@property(nonatomic,strong)NSData*sendData;
//block
@property(nonatomic,copy)void(^BlockResult)(int);
-(id)initWithBlock:(void(^)(int))a;
-(void)sendDataClick;
@end
