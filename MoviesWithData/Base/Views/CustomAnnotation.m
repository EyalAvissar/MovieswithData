//
//  CustomAnnotation.m
//  MoviesWithData
//
//  Created by inmanage on 01/12/2021.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

- (instancetype)initWithTitle:(NSString *)title Location:(CLLocationCoordinate2D)location {
    self = [super init];
    
    if (self) {
        _title = title;
        _coordinate = location;
    }
    
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    annotationView.enabled = true;
    annotationView.canShowCallout = true;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    
    return annotationView;
}
@end
