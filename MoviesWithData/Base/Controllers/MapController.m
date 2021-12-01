//
//  ViewController.m
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import "MapController.h"
#import "Cinema.h"
#import "ApplicationManager.h"
#import <MapKit/MapKit.h>

@interface MapController ()

@end

@implementation MapController

//MARK: LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

//    region.span = span;
//    region.center = location;
    
//    [self.mapView setRegion:region];
    
//    MapPin *annotation = [[MapPin alloc] init];
//    annotation.coordinate = location;
//
//    [self.mapView addAnnotation:annotation];
//
//    locationManager.delegate = self;
//    self.mapView.delegate = self;
//    locationManager = [[CLLocationManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//    
//    span.latitudeDelta = 0.005;
//    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;

    for (NSString *cinemaID in self.locations) {
        Cinema *cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:[NSString stringWithFormat:@"%@",cinemaID]];
        
        location.latitude = [cinema.latitudeStr doubleValue];
        location.longitude = [cinema.longitudeStr doubleValue];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] initWithCoordinate:location];
        
        
        annotation.title = cinema.name;

        [self.mapView addAnnotation:annotation];
    }
    
    
    //    region.span = span;
    //    region.center = location;
        
    //    [self.mapView setRegion:region];
        
    //    MapPin *annotation = [[MapPin alloc] init];
    //    annotation.coordinate = location;
    //
    //    [self.mapView addAnnotation:annotation];
    //
    //    locationManager.delegate = self;
    //    self.mapView.delegate = self;
    //    locationManager = [[CLLocationManager alloc] init];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"custom"];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"custom"];
        annotationView.canShowCallout = false;
    }
    
//    UIButton *movieButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    movieButton.titleLabel.text = @"back to movie details";
//    annotationView.rightCalloutAccessoryView = movieButton;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"Annotation tapped");
}

@end
