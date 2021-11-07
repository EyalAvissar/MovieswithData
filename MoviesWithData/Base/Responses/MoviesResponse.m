//
//  MoviesResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesResponse.h"
#import "Movie.h"
#import "ApplicationManager.h"

@implementation MoviesResponse

-(void)parseData:(NSDictionary *)JSON {

    NSLog(@"movies json %@",JSON[@"movies"]);

    NSArray *jsonMoviesArray = JSON[@"movies"];
    
    NSMutableDictionary *moviesDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < jsonMoviesArray.count; i++) {
        Movie *movie = [Movie new];
        movie.name = jsonMoviesArray[i][@"name"];
        movie.category = jsonMoviesArray[i][@"category"];
        movie.movieId = jsonMoviesArray[i][@"id"];
        movie.cinemasId = jsonMoviesArray[i][@"cenimasId"];
        
        movie.year = jsonMoviesArray[i][@"year"];

        [moviesArray addObject:movie];
        [moviesDictionary setObject:movie forKey:movie.movieId];
    }
    
    
    [[ApplicationManager sharedInstance].movieManager setMoviesArray:moviesArray];
    [[ApplicationManager sharedInstance].movieManager setMoviesDictionary:moviesDictionary];
}

@end
