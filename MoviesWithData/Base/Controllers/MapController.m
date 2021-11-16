//
//  ViewController.m
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import "MapController.h"

@interface MapController ()

@end

@implementation MapController

//MARK: LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;
    location.latitude = 34.00935149999999;
    location.longitude = -118.49746820000001;
    
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region];
    
    MapPin *annotation = [[MapPin alloc] init];
    annotation.coordinate = location;
    
    [self.mapView addAnnotation:annotation];
    
    locationManager.delegate = self;
    self.mapView.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    
}

//MARK:- MapDelegate

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//
//    span.latitudeDelta = 0.005;
//    span.longitudeDelta = 0.005;
//
//    CLLocationCoordinate2D location;
//    location.latitude = userLocation.coordinate.latitude;
//    location.longitude = userLocation.coordinate.longitude;
//
//    region.span = span;
//    region.center = location;
//
//    [self.mapView setRegion:region];
//
//    MapPin *annotation = [[MapPin alloc] init];
//    annotation.coordinate = location;
//
//}
//MARK:- IBActions

//- (IBAction)directions:(id)sender {
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://maps.apple.com/maps?daddr=34.00935149999999,-118.49746820000001"] options:nil completionHandler:nil];
//
//}
//
//- (IBAction)locate:(id)sender {
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager requestAlwaysAuthorization];
//
//    [locationManager startUpdatingLocation];
//
//    [self.mapView showsUserLocation];
//}
//
//- (IBAction)hybrid:(id)sender {
//
//    self.mapView.mapType = MKMapTypeHybrid;
//}
//
//- (IBAction)satelite:(id)sender {
//    self.mapView.mapType = MKMapTypeSatellite;
//
//}
//
//- (IBAction)standard:(id)sender {
//    self.mapView.mapType = MKMapTypeStandard;
//
//}
@end
