//
//  XMGMyOrderVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGMyOrderVC.h"
#import "Base.h"

@interface XMGMyOrderVC ()<UIWebViewDelegate>

@end

@implementation XMGMyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.backgroundColor = kCommonColor;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    
    NSURL *url = [NSURL URLWithString: @"http://xzone.ximalaya.com/x-zone-post/v1/zones?device=iPhone&ownerId=12279675"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [webView loadRequest: request];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
