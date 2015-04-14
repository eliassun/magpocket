//
//  ViewController.m
//  magpocket
//
//  Created by Elias Sun on 4/13/15.
//  Copyright (c) 2015 ishare. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_FrontWebView setDelegate:self];
    [_FrontWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = [[request URL] absoluteString];
    
    if ([urlString hasPrefix:@"tonamecallnative:"]) {
        NSString *jsonString = [[urlString componentsSeparatedByString:@"tonamecallnative:"] lastObject] ;
        jsonString=[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error;
        id parameters = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (!error) {
            // TODO: Logic based on parameters
        }
        [webView stringByEvaluatingJavaScriptFromString:@"tonameCallBack({id:'0001',name:'hello'})"];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"CallNative" ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
}
- (void)viewDidLayoutSubviews {
    _FrontWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


@end
