//
//  Movie.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "Movie.h"

@implementation Movie
 
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Movie *movieCopy = [[Movie alloc] init];
    
    movieCopy.name = [self.name copy];
    movieCopy.year = [self.year copy];
    movieCopy.category = [self.category copy];
    movieCopy.movieId = [self.movieId copy];
    movieCopy.cinemasId = [self.cinemasId copy];
    
    return movieCopy;
}

- (NSString *)movieString {
    return [NSString stringWithFormat:@"%@, %@, %@, %@, %@", self.name, self.year,
        self.category,
        self.movieId,
        self.cinemasId
    ];
}
@end
