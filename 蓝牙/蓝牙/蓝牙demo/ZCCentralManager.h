//
//  ZCCentralManager.h
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-29.
//  Copyright (c) 2014年 fq. All rights reserved.
//


//中心类
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface ZCCentralManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,strong)CBCentralManager*centralManager;
@property(nonatomic,strong)NSMutableData*data;
//记录是不是自己发现的设备
@property(nonatomic,strong)CBPeripheral*discovedPeripheral;
//block指针
@property(nonatomic,copy)void(^blockValue)(NSString*);
-(id)initWithBlock:(void(^)(NSString*))a;
@end
