//
//  rootViewController.m
//  AnimatedSplash
//
//  Created by Wujianyun on 16/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import "rootViewController.h"

@interface rootViewController ()<CAAnimationDelegate>
{
    CALayer* _mask;
    UIImageView* _imageView;
}
@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.117 green:0.631 blue:0.949 alpha:1]];
    _imageView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_imageView setImage:[UIImage imageNamed:@"screen"]];
    [self.view addSubview:_imageView];
    
    _mask=[[CALayer alloc]init];
    [_mask setContents:[UIImage imageNamed:@"twitter"].CGImage];
    [_mask setContentsGravity:kCAGravityResizeAspect];
    [_mask setBounds:CGRectMake(0, 0, 100, 81)];
    [_mask setAnchorPoint:CGPointMake(0.5, 0.5)];
    [_mask setPosition:CGPointMake(_imageView.frame.size.width/2, _imageView.frame.size.height/2)];
    _imageView.layer.mask=_mask;
    [self animateMask];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) animateMask
{
    CAKeyframeAnimation* keyFA=[[CAKeyframeAnimation alloc]init];
    [keyFA setDelegate:self];
    [keyFA setKeyPath:@"bounds"];
    [keyFA setDuration:0.6];
    [keyFA setBeginTime:CACurrentMediaTime()+0.5];
    [keyFA setTimingFunctions:[[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil]];
    NSValue* initalBounds=[NSValue valueWithCGRect:_mask.bounds];
    NSValue* secondBounds=[NSValue valueWithCGRect:CGRectMake(0, 0, 90, 73)];
    NSValue* finalBounds=[NSValue valueWithCGRect:CGRectMake(0, 0, 1600, 1300)];
    [keyFA setValues:[[NSArray alloc]initWithObjects:initalBounds,secondBounds,finalBounds, nil]];
    [keyFA setKeyTimes:[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithFloat:0],[[NSNumber alloc]initWithFloat:0.3],[[NSNumber alloc]initWithFloat:1],nil]];
    [_mask addAnimation:keyFA forKey:@"bounds"];
}
-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _imageView.layer.mask=nil;
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
