//
//  rootViewController.m
//  GetMyLocation
//
//  Created by Wujianyun on 17/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import "rootViewController.h"
#import "CoreLocation/CoreLocation.h"


@interface rootViewController ()<CLLocationManagerDelegate>
{
    
    UIButton* _getLocation;
    UILabel* _latitude;
    UILabel* _longitude;
    UILabel* _latitudeLabel;
    UILabel* _longitudeLabel;
    UILabel* _locationLabel;
    UILabel* _location;
    NSString* _locationString;
}
@property (strong,nonatomic) CLGeocoder *geocoder;
@property UIImageView* backgroundImage;
@property(strong,nonatomic)CLLocationManager*locationManager;

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    _backgroundImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    [_backgroundImage setFrame:self.view.bounds];
    [self.view addSubview:_backgroundImage];
    
    _getLocation=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_getLocation setTitle:@"Find my Location" forState:UIControlStateNormal];
    [_getLocation setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2,[UIScreen mainScreen].bounds.size.height/8, 200, 50)];
    _getLocation.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [_getLocation setBackgroundColor: [UIColor blueColor]];
    [_getLocation.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_getLocation addTarget:self action:@selector(getLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getLocation];
    
    _latitudeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 250, 70, 50)];
    [_latitudeLabel setText:@"latitude:"];
    _longitudeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 350, 100, 50)];
    [_longitudeLabel setText:@"longitude:"];
    _locationLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 450, 70, 50)];
    [_locationLabel setText:@"location:"];
    _latitude=[[UILabel alloc]initWithFrame:CGRectMake(150, 250, 200, 50)];
    _longitude=[[UILabel alloc]initWithFrame:CGRectMake(150, 350, 200, 50)];
    _location=[[UILabel alloc]initWithFrame:CGRectMake(150, 450, 200, 50)];
    
    [_backgroundImage addSubview:_latitude];
    [_backgroundImage addSubview:_longitude];

    // Do any additional setup after loading the view.
}
-(void)getLocation
{
    _locationManager=[[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([CLLocationManager locationServicesEnabled])
    {
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else
    {
        [self errorReport];
    }
}
-(void)errorReport
{
    NSLog(@"there was an error to get you permission.");
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

#pragma mark -CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [_locationManager stopUpdatingLocation];
    _geocoder=[[CLGeocoder alloc]init];
    [self.view addSubview:_locationLabel];
    [self.view addSubview:_latitudeLabel];
    [self.view addSubview:_longitudeLabel];
    CLLocation* location=[locations lastObject];
    NSString* latitudeString=[NSString stringWithFormat:@"%g\u00B0",location.coordinate.latitude];
    _latitude.text=latitudeString;
    NSString* longitudeString=[NSString stringWithFormat:@"%g\u00B0",location.coordinate.longitude];
    _longitude.text=longitudeString;
    [_geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:
     ^(NSArray< CLPlacemark *> * placemarks, NSError * error){
         if (error != nil) {
             [_location setText:error.localizedDescription];
         }
         
         if (placemarks.count > 0) {
             CLPlacemark* pm = placemarks[0];
             [self displayLocation:pm];
         } else {
             [_location setText:@"Problem with the data received from geocoder"] ;
         }
     }];
}

-(void) displayLocation:(CLPlacemark*)placemark
{

    if(placemark.country!=nil){
        _locationString=[[NSString alloc]initWithString:placemark.country];
        if(placemark.administrativeArea!=nil)
        {
            _locationString=[_locationString stringByAppendingString:placemark.administrativeArea];
            if(placemark.locality!=nil){
                _locationString=[_locationString stringByAppendingString:placemark.locality];
            }
        }
    }
    NSLog(@"%@",_locationString);
    [_location setText:_locationString];
    [self.view addSubview:_location];
}




//_______________



@end
