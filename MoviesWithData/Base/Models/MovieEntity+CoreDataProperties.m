//
//  MovieEntity+CoreDataProperties.m
//  MoviesWithData
//
//  Created by inmanage on 09/11/2021.
//
//

#import "MovieEntity+CoreDataProperties.h"

@implementation MovieEntity (CoreDataProperties)

+ (NSFetchRequest<MovieEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MovieEntity"];
}

@dynamic category;
@dynamic cinemasId;
@dynamic imageUrl;
@dynamic movieDescription;
@dynamic movieId;
@dynamic moviePoster;
@dynamic name;
@dynamic promoUrl;
@dynamic rating;
@dynamic year;

@end
