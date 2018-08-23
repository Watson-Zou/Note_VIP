//
//  BluetoothDefine.h
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-30.
//  Copyright (c) 2014年 fq. All rights reserved.
//
//本身的发现服务

#define TRANSFER_SERVICE_UUID           @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"

//对方的账号
#define TRANSFER_CHARACTERISTIC_UUID    @"08590F7E-DB05-467E-8757-72F6FAEB13D4"

//传输文件，传输完毕的语意
#define BluetoothEnd @"END"

//每一段不能超过20字节
#define NOTIFY_MTU 20