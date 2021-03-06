//
//  ZCPeripheralManager.m
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-29.
//  Copyright (c) 2014年 fq. All rights reserved.
//
//外围设备，也就发送广播使用
#import "ZCPeripheralManager.h"
#import "BluetoothDefine.h"
static BOOL sendingEOM = NO;
@implementation ZCPeripheralManager
-(id)initWithBlock:(void(^)(int))a{

    self.BlockResult=a;
    return [self init];
}
-(id)init{
    if (self=[super init]) {
        self.peripheralManager=[[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    }
    return self;
}
//检测状态
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state!=CBPeripheralManagerStatePoweredOn) {
        return;
    }
    //启动service
    //启动可变服务特性properties：Notify允许没有回答的服务特性，向中心设备发送数据，permissions：read通讯属性为只读
    self.transferCharacteristic=[[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    //创建服务 primary 是首次还是第二次
    CBMutableService*transferService=[[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID] primary:YES];
    //把特性加到服务上
    transferService.characteristics=@[self.transferCharacteristic];
    //把服务加到管理上
    [self.peripheralManager addService:transferService];
    
    //发送广播，标示是TRANSFER_SERVICE_UUID为对方观察接收的值，2边要对应上
  
     [self.peripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]}];
}

//当发现我们的人订阅了我们的特性后，我们要发送数据给他
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"订阅成功");
//    self.sendDataIndex=0;
//    [self sendDataClick];
}
//当中央设备结束订阅时候调用
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    
}

-(void)sendDataClick{
    
    if (sendingEOM) {
        //第三个参数代表指定与我们的订阅的中心设备发送，返回一个布尔值，代表发送成功
        BOOL didSend=[self.peripheralManager updateValue:[BluetoothEnd dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        
        if (didSend) {
            //全部发送完成
            sendingEOM=NO;
            NSLog(@"发送完成");
            self.BlockResult(1);
        }
        //如果没有发送，我们就要退出并且等待
        //peripheralManagerIsReadyToUpdateSubscribers 来再一次调用sendData来发送数据
        return;
    }
    //如果没有正在发送BluetoothEnd，就是在发送数据
    self.sendData=[self.message dataUsingEncoding:NSUTF8StringEncoding];
    //判断是否还有剩下的数据
    if (self.sendDataIndex>=self.sendData.length) {
        //没有数据，退出即可
        return;
    }
    //如果有数据没有发送完就发送它，除非回调失败或者我们发送完
    BOOL didSend=YES;
    while (didSend) {
        //发送下一块数据，计算出数据有多大
        NSInteger amountToSend=self.sendData.length-self.sendDataIndex;
        if (amountToSend>NOTIFY_MTU) {
            //如果剩余的数据还是大于20字节，那么我最多传送20字节
            amountToSend=NOTIFY_MTU;
        }
        //切出我想要发送的数据 +sendDataIndex就是从多少字节开始向后切多少
        NSData*chunk=[NSData dataWithBytes:self.sendData.bytes+self.sendDataIndex length:amountToSend];
        //发送
        didSend=[self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
        //如果没发送成功，等待回调发送
        if (!didSend) {
            return;
        }else{
            self.sendDataIndex+=amountToSend;
            //判断是否发送完
            if (self.sendDataIndex>=self.sendData.length) {
                //发送完成，就开始发送结束标示bluetoothEND
                sendingEOM=YES;
                [self performSelector:@selector(sendDataClick) withObject:nil afterDelay:0.1];
//                //发送
//                NSData*data=  [BluetoothEnd dataUsingEncoding:NSUTF8StringEncoding];
//                
//                
//                BOOL endsend=[self.peripheralManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
//                
//                if (endsend) {
//                    sendingEOM=NO;
//                    NSLog(@"发送完成");
//                    //设置block回调
//                    self.BlockResult(1);
//
//                    
//                }
//                return;
                
            }
        }
        
    }
}
////当以上发送队列满了，导致发送失败时候，会再次准备发送
//-(void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
//{
//    [self sendDataClick];
//}


@end














