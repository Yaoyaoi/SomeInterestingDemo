//
//  ViewController.m
//  VideoSplash
//
//  Created by Wujianyun on 23/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
///Users/wujianyun/Desktop/background.gif

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"gif"];
    NSData * backgroundGif = [NSData dataWithContentsOfFile:filePath];
    [_webView setFrame:self.view.frame];
    [_webView loadData:backgroundGif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    _webView.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
