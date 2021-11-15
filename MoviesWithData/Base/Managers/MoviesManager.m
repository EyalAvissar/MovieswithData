//
//  MovieManager.m
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "MoviesManager.h"
#import "CoreData/CoreData.h"
#import "ApplicationManager.h"

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

-(NSURL *)getUrl:(NSString *)documentName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    
    NSLog(@"getUrl %@",url);
    return url;
}

- (MenuViewController *)menu {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuViewController *menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"Menu"];
    return menuVC;
}

+(CATransition *)setPresentationStyle {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return transition;
}

@end
