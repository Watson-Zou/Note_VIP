//
//  ViewController.m
//  webView
//
//  Created by Watson_Zou on 2018/6/21.
//  Copyright © 2018年 Watson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** <#zhushi#> */
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self loadFile];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(50, CGRectGetMaxY(self.webView.frame) + 50, self.view.frame.size.width - 100, 50);
    [refreshBtn setTitle:@"Refresh" forState:UIControlStateNormal];
    [refreshBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:refreshBtn];
    [refreshBtn addTarget:self action:@selector(refreshHTML) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loadFile  {
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"barAndLine.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.webView loadRequest:request];
}

- (void)refreshHTML {
    [self.webView reload];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 400)];
        _webView.backgroundColor = [UIColor whiteColor];
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self.view addSubview:_webView];
    }
    return _webView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
