//
//  ViewController.m
//  magpocket
//
//  Created by Elias Sun on 4/13/15.
//  Copyright (c) 2015 ishare. All rights reserved.
//

#import "ViewController.h"
#import "logicExecutor.h"

@interface ViewController ()
@property (nonatomic, readwrite)  SoftCPUInputOutputManager * cpu;
@property (nonatomic,readwrite)  NSMutableArray *cmdtable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_FrontWebView setDelegate:self];
    [_FrontWebView loadRequest:requestObj];
    _FrontWebView.allowsInlineMediaPlayback=true;
    self.cpu = new SoftCPUInputOutputManager;
    self.cpu->setcmdfunc(getNextEntry);
    
    //self.cpu->newEvent((char*)"{\"onclick\":{\"timestamp\":\"4455\",\"value\":\"990\"}}");
    //self.cpu->newEvent((char*)"{\"onchange\":{\"timestamp\":\"4455\",\"value\":\"990\"}}");
    //self.cpu->readEvent((char*)"uid0000000001");

    //NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"defaultbp" ofType:@"jason"];
    //self.cpu->runApp([jsPath UTF8String]);
    
    //self.cpu->elLoadApp([jsPath UTF8String]);
    [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob) toTarget:self withObject:nil];
    
}

- (void)startTheBackgroundJob {
    
    // wait for 3 seconds before starting the thread, you don't have to do that. This is just an example how to stop the NSThread for some time
    //[NSThread sleepForTimeInterval:3];
    //[self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:NO];
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"defaultbp" ofType:@"jason"];
    self.cpu->runApp([jsPath UTF8String]);
    
}

- (void)makeMyProgressBarMoving {
/*
    float actual = [threadProgressView progress];
    threadValueLabel.text = [NSString stringWithFormat:@"%.2f", actual];
    if (actual < 1) {
        threadProgressView.progress = actual + 0.01;
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(makeMyProgressBarMoving) userInfo:nil repeats:NO];
    }
    else threadStartButton.hidden = NO;
  */
    NSLog(@"Hello......");
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
        [webView stringByEvaluatingJavaScriptFromString:@"tonamePlayVideo({gui:['uid000001','uid000002']})"];
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

char * getNextEntry(unsigned long cmdseq)
{
    return NULL;
}

@end
