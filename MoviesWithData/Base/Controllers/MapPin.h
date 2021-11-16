//
//  MapPin.h
//  MapApp
//
//  Created by inmanage on 20/10/2021.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapPin : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

NS_ASSUME_NONNULL_END
