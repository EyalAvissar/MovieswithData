//
//  FullMovieResponse.h
//  Base-objectiveC
//
//  Created by inmanage on 03/11/2021.
//

#import "BaseServerRequestResponse.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FullMovieResponse : BaseServerRequestResponse

@property NSString *promoUrl;
@property NSString *imageUrl;
@property NSString *rating;
@property NSString *movieDescription;
@property UIImage *moviePoster;

@end

NS_ASSUME_NONNULL_END
