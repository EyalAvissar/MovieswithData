//
//  MovieManager.m
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "MoviesManager.h"

@implementation MoviesManager

static MoviesManager *_sharedInstance = nil;

+ (id)sharedInstance {
    if (!_sharedInstance) {
        _sharedInstance = [[MoviesManager alloc] init];
    }
    
    return _sharedInstance;
}

-(NSMutableArray *)sortMoviesByCategory:(NSString *) category {
    NSMutableArray *partialMoviesArray = [[NSMutableArray alloc] init];
    
    for (Movie *currentMovie in self.moviesArray) {
        
        if ([[currentMovie.category lowercaseString] isEqual: category])
        {
            [partialMoviesArray addObject:[currentMovie copy]];
        }
    }
    return partialMoviesArray;
}

-(NSMutableArray *)sortBy:(NSString *)title arrayToSort: (NSMutableArray *) array {
    NSSortDescriptor *sort;
    
    if (![title isEqual:@"מיון לפי שנה"]) {
        sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [array sortUsingDescriptors:[NSMutableArray arrayWithObject:sort]];
        
    }
    else {
        sort = [NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES];
        [array sortUsingDescriptors:[NSMutableArray arrayWithObject:sort]];
    }
    
    return array;
}

@end
