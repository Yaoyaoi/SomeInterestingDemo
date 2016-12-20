//
//  ViewController.h
//  SetTheDate
//
//  Created by Wujianyun on 20/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)setTheDateBtn:(id)sender;


@end

