

//
//  ZCViewController1.m
//  蓝牙demo
//
//  Created by zhangcheng on 14-7-30.
//  Copyright (c) 2014年 fq. All rights reserved.
//

#import "ZCViewController1.h"
#import "ZCCentralManager.h"
#import "ZCPeripheralManager.h"
@interface ZCViewController1 ()
{
    ZCPeripheralManager*manager1;
}
@end

@implementation ZCViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 100, 100, 100);
    [button setTitle:@"接收信息" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadMessage) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor redColor];
    [self.view addSubview:button];
    
    
    UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(120, 100, 100, 100);
    [button1 setTitle:@"发送消息" forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor greenColor];
    [button1 addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    manager1=[[ZCPeripheralManager alloc]initWithBlock:^(int x) {
        NSLog(@"发送完成");
    }];
    // Do any additional setup after loading the view.
}
-(void)loadMessage{
    ZCCentralManager*manager=[[ZCCentralManager alloc]initWithBlock:^(NSString *str) {
        NSLog(@"接收到得信息%@",str);
        UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"11" message:str delegate:self cancelButtonTitle:@"22" otherButtonTitles: nil];
        [al show];
        
    }];
}

-(void)sendMessage{
    manager1.message=@"哈哈哈哈";

    manager1.sendDataIndex=0;
    [manager1 sendDataClick];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
