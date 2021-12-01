//
//  ViewController.h
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>

@interface MapController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSArray *locations;

@end
