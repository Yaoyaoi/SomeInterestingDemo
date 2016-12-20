//
//  ViewController.m
//  GetTheLocation
//
//  Created by Wujianyun on 20/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>{
    NSString* _locationString;
}
@property (strong,nonatomic) CLGeocoder *geocoder;
@property(strong,nonatomic)CLLocationManager*locationManager;
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


- (IBAction)getMyLocationLabel:(id)sender {
}
- (IBAction)btn:(id)sender {
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
#pragma mark -CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [_locationManager stopUpdatingLocation];
    _geocoder=[[CLGeocoder alloc]init];
    CLLocation* location=[locations lastObject];
    NSString* latitudeString=[NSString stringWithFormat:@"%g\u00B0",location.coordinate.latitude];
    _latitude.text=latitudeString;
    [_latitude setTextColor:[UIColor blackColor]];
    NSString* longitudeString=[NSString stringWithFormat:@"%g\u00B0",location.coordinate.longitude];
    _longitude.text=longitudeString;
    [_longitude setTextColor:[UIColor blackColor]];
    [_geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:
     ^(NSArray< CLPlacemark *> * placemarks, NSError * error){
         if (error != nil) {
             [_location setText:error.localizedDescription];
             [_location setTextColor:[UIColor blackColor]];
         }
         
         if (placemarks.count > 0) {
             CLPlacemark* pm = placemarks[0];
             [self displayLocation:pm];
         } else {
             [_location setText:@"Problem with the data received from geocoder"] ;
         }
     }];
}

-(void) displayLocation:(CLPlacemark*)placemark{
    
    if(placemark.country!=nil){
        _locationString=[[NSString alloc]initWithString:placemark.country];
        [_location setTextColor:[UIColor blackColor]];
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

@end
