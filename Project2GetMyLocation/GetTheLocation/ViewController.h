//
//  ViewController.h
//  GetTheLocation
//
//  Created by Wujianyun on 20/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

