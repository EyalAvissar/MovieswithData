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
#import "DetailViewController.h"

@interface MapController ()

@end

@implementation MapController

//MARK: LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
//    [self.mapView registerClass:nil forAnnotationViewWithReuseIdentifier:@"custom"];


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
//        self.mapView.delegate = self;
    //    locationManager = [[CLLocationManager alloc] init];

}

- (void)setAnnotationView:(MKAnnotationView *)annotationView {
    annotationView.canShowCallout = true;
    annotationView.enabled = true;
    annotationView.frame = CGRectMake(0, 0, 10, 10);
    annotationView.backgroundColor = [UIColor greenColor];
    
    UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = disclosureButton;
    annotationView.image = [UIImage systemImageNamed:@"person"];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"custom"];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"custom"];
        
        [self setAnnotationView:annotationView];
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"Annotation tapped");
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Annotation button tapped");
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
        
    detailController.movieId = self.movie.movieId;
    
    [self.navigationController pushViewController:detailController animated:true];
}

@end
