//
//  DetailViewController.m
//  CarHome
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIWebViewDelegate>

@end

@implementation DetailViewController

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view showBusyHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideBusyHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self.view showWarning:error.description];
}

- (instancetype)initWithURL:(NSURL *)detailURL{
    if (self = [super init]) {
        _detailURL = detailURL;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [UIWebView new];
    [self.view addSubview:webView];
    webView.delegate = self;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:_detailURL]];
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
