//
//  MapViewController.m
//  Hutong
//
//  Created by 王蕾 on 2017/3/22.
//  Copyright © 2017年 王蕾. All rights reserved.
//

#import "MapViewController.h"
#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "MyCustomAnnotationView.h"
#import "ListModel.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)MKMapView *mapView;
@property (nonatomic, assign)CLLocationCoordinate2D userLocation;

@end

@implementation MapViewController

- (void)customNavItems{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[playGifView shareInstance]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (AUDIOManager.playing) {
        [[playGifView shareInstance] play];
    }else{
        [[playGifView shareInstance] pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kSetColor(240, 240, 240);
    
    [self AddLeftImageBtn:[UIImage imageNamed:@"list"] target:self action:@selector(goList)];
    [self customNavItems];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 64)];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    _mapView.rotateEnabled = NO;
    _mapView.showsCompass = YES;
    [self.view addSubview:_mapView];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    //116.421543,39.946147 香饵胡同
    //116.420959,39.946268 土儿胡同
}
/*判断一个Annotation是否在当前地图中可见
 MKMapRect visibleMapRect=self.mapView.visibleMapRect;
 
 NSSet*visibleAnnotation=[self.mapView annotationsInMapRect:visibleMapRect];
 
 if([visibleAnnotation containsObject:annotation]) {
 
 }
 */
/*将地图缩放到某个合适的位置 使一些Annotation同时可见
 [self.mapView showAnnotations:@[annotation,annotation2]animated:YES];
 */
/*// 计算距离
 CLLocationDistance meters=[current distanceFromLocation:before];
 */

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    if (!_userLocation.latitude && !_userLocation.longitude) {
        _userLocation = userLocation.location.coordinate;
        //设置显示区域
        
        CLLocationDistance maxMeters =0;
        for (ListModel *model in DATAManager.dataArray) {
            MyAnnotation *annotation = [[MyAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake([model.lat doubleValue], [model.lon doubleValue]);
            annotation.title = model.name;
            annotation.mid = model.id;
            [self.mapView addAnnotation:annotation];
            
            CLLocationDistance meters=[[[CLLocation alloc]initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude ] distanceFromLocation:[[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude ]];
            if (meters > maxMeters) {
                maxMeters = meters;
            }
        }
        
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, maxMeters * 2, maxMeters * 2) animated: false];
        [_locationManager stopUpdatingLocation];
    }
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *annotationViewID = @"annotationViewID";
    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        MyAnnotation *myAnnotation = (MyAnnotation *)annotation;
        MyCustomAnnotationView *aView = (MyCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
        if (!aView) {
            aView = [[MyCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
            aView.canShowCallout = NO;
            
        }
        [aView setContent:myAnnotation.title];
        aView.mid = myAnnotation.mid;
        aView.clickBlock = ^(NSInteger index){
            PlayerViewController *ctrl  = [PlayerViewController shareInstance];
            ListModel *model = DATAManager.dataArray[index];
            if (![model.id isEqualToString:DATAManager.playingModel.id] || !AUDIOManager.playing) {
                DATAManager.playingModel = model;
                [AUDIOManager newPlay];
            }
            [self.navigationController presentViewController:ctrl animated:YES completion:nil];
        };
        return aView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
}

- (void)goList{
    MainViewController *mCtrl = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mCtrl animated:YES];
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
