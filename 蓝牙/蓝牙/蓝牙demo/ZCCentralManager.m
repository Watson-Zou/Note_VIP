
//
//  ZCCentralManager.m
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-29.
//  Copyright (c) 2014年 fq. All rights reserved.
//

#import "ZCCentralManager.h"
#import "BluetoothDefine.h"
@implementation ZCCentralManager
-(id)initWithBlock:(void(^)(NSString*))a
{
    self.blockValue=a;
    
    return [self init];
}
-(id)init{
    if (self=[super init]) {
       self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.data=[NSMutableData data];
    }
    return self;
}
//检测中央设备状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
    if (central.state!=CBCentralManagerStatePoweredOn) {
        //如果蓝牙关闭，那么无法开启检测，直接返回
        NSLog(@"蓝牙关闭");
        return;
    }
    //开启检测
    [self scan];
    
}
-(void)scan{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    //options中的意思是否允许中央设备多次收到曾经监听到的设备的消息，这样来监听外围设备联接的信号强度，以决定是否增大广播强度，为YES时会多耗电

}
//当外围设备广播同样的UUID信号被发现时，这个代理函数被调用。这时我们要监测RSSI即Received Signal Strength Indication接收的信号强度指示，确保足够近，我们才连接它
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    
    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    
    // 判断是不是我们监听到的外围设备
    if (self.discovedPeripheral != peripheral) {
        self.discovedPeripheral = peripheral;
        [self.centralManager connectPeripheral:peripheral options:nil];;

        NSLog(@"Connecting to peripheral %@", peripheral);
       // [self performSelector:@selector(xx) withObject:nil afterDelay:0.1];
    }
}
-(void)xx{
    
    [self.centralManager stopScan];


}
//连接上外围设备后我们就要找到外围设备的服务特性
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
//连接完成后，就停止检测
    [self.centralManager stopScan];
    
    [self.data setLength:0];
    //确保我们收到的外围设备连接后的回调代理函数
    peripheral.delegate=self;
    //让外围设备找到与我们发送的UUID所匹配的服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
    
}

//相当于对方的账号
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{

    if (error) {
        NSLog(@"Errordiscover:%@",error.localizedDescription);
        [self clearUp];
        return;
    }
    //找到我们想要的特性
    //遍历外围设备
    for (CBService*server in peripheral.services) {
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:server];
    }

}
//当发现传送服务特性后我们要订阅他 来告诉外围设备我们想要这个特性所持有的数据
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"error  %@",[error localizedDescription]);
        [self clearUp];
        return;
    }
    //检查特性
    for (CBCharacteristic*characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            //有来自外围的特性，找到了，就订阅他
              // 如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
          //完成后，等待数据传进来
            NSLog(@"订阅成功");
            
        }
    }
    
}
//这个函数类似网络请求时候只需收到数据的那个函数
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"error~~%@",error.localizedDescription);
        return;
    }
    //characteristic.value 是特性中所包含的数据
    NSString*stringFromData=[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"%@",stringFromData);
    
    if ([stringFromData isEqualToString:BluetoothEnd]) {
        //完成发送，调用代理进行传递self.data
        NSString*str=[[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
        //取消订阅
        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
        [self.centralManager cancelPeripheralConnection:peripheral];
        self.blockValue(str);

    }else{
    //数据没有传递完成，继续传递数据
        [self.data appendData:characteristic.value];
    
    }

}
//外围设备让我们知道，我们订阅和取消订阅是否发生
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"error  %@",error.localizedDescription);
    }
    //如果不是我们要特性就退出
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"外围特性通知开始");
    }else{
        NSLog(@"外围设备特性通知结束，也就是用户要下线或者离开%@",characteristic);
        //断开连接
        [self.centralManager cancelPeripheralConnection:peripheral];
    
    }
}
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"disconnected");
    self.discovedPeripheral=nil;
    [self scan];
}
//连接失败时的处理
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@~~~%@",peripheral,[error localizedDescription]);
    [self clearUp];
    
}

-(void)clearUp{
    if (![self.discovedPeripheral isConnected]) {
        return;
    }
    
    if (self.discovedPeripheral.services!=nil) {
        for (CBService*server in self.discovedPeripheral.services) {
            
            if (server.characteristics!=nil) {
                for (CBCharacteristic*chatacter in server.characteristics) {
                    
                    if ([chatacter.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        
                        //查看是否订阅了
                        if (chatacter.isNotifying) {
                            //如果订阅了。取消订阅
                            [self.discovedPeripheral setNotifyValue:NO forCharacteristic:chatacter];
                            return;
                        }
                        
                    }
                    
                }
            }
        }
    }
    //如果我们连接了，但是没有订阅，就断开连接即可
    [self.centralManager cancelPeripheralConnection:self.discovedPeripheral];
    
}




@end
