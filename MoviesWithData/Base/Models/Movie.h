//
//  Movie.h
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject <NSCopying>

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *cinemasId;
@property (nonatomic, strong) NSString
*movieId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *year;
@property NSNumber *rating;
@property NSString *promoUrl;
@property NSString *imageUrl;
@property NSString *movieDescription;
@property UIImage *moviePoster;

-(NSString *)movieString;

@end

NS_ASSUME_NONNULL_END
