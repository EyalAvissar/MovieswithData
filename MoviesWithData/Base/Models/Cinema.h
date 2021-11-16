//
//  Cinema.h
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cinema : NSObject

@property NSString *cinemaId;
@property NSString *name;
@property NSString *latitudeStr;
@property NSString *longitudeStr;
@property NSMutableArray *movieIdArray;

@end

NS_ASSUME_NONNULL_END
