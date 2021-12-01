//
//  CustomAnnotation.h
//  MoviesWithData
//
//  Created by inmanage on 01/12/2021.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

-(instancetype)initWithTitle:(NSString *)title Location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;
@end

NS_ASSUME_NONNULL_END
