//
//  XMGStorVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGStorVC.h"

#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGStorVC ()<UIWebViewDelegate>

@end

@implementation XMGStorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.backgroundColor = kCommonColor;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    
    NSURL *url = [NSURL URLWithString: @"http://www.taobao.com"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [webView loadRequest: request];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
