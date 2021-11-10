//
//  MovieEntity+CoreDataProperties.h
//  MoviesWithData
//
//  Created by inmanage on 09/11/2021.
//
//

#import "MovieEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MovieEntity (CoreDataProperties)

+ (NSFetchRequest<MovieEntity *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, retain) NSObject *cinemasId;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *movieDescription;
@property (nullable, nonatomic, copy) NSString *movieId;
@property (nullable, nonatomic, retain) NSData *moviePoster;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *promoUrl;
@property (nonatomic) int16_t rating;
@property (nonatomic) int16_t year;

@end

NS_ASSUME_NONNULL_END
