//
//  ViewController.m
//  SetTheDate
//
//  Created by Wujianyun on 20/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setTheDateBtn:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:_datePicker.date];
    _dateLabel.text=dateTime;
    [_dateLabel setFont:[UIFont systemFontOfSize:14]];
    [_dateLabel setTextColor:[UIColor blackColor]];
}
@end
