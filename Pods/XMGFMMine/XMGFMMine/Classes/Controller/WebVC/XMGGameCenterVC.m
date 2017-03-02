//
//  XMGGameCenterVC.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGGameCenterVC.h"
#import "Base.h"

@interface XMGGameCenterVC ()<UIWebViewDelegate>

@end

@implementation XMGGameCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.backgroundColor = kCommonColor;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    

    NSURL *url = [NSURL URLWithString: @"http://game.ximalaya.com/games-operation/v1/games/list?app=iting&device=iPhone&impl=com.gemd.iting&ly=wo&type=btnbottom&version=5.4.21"];
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
