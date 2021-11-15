//
//  MovieManager.h
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "BaseRequest.h"
#import "Movie.h"
#import "MenuViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoviesManager : BaseRequest

+(MoviesManager *)sharedInstance;
+(UIManagedDocument *)prepareUIManagedDocumentFor:(NSURL *)url;
+(CATransition *)setPresentationStyle; //move to Utilities?

@property NSArray *moviesArray;
@property NSDictionary *moviesDictionary;
@property NSDictionary *cinemasDictionary;
@property NSString *lastMoviesUpdate;
@property NSString *lastCinemasUpdate;

-(NSMutableArray *)sortMoviesByCategory:(NSString *) category;
-(NSMutableArray *)sortBy:(NSString *)title arrayToSort: (NSArray *) array;
-(NSURL *)getUrl:(NSString *)documentName;
-(MenuViewController *)menu;
@end

NS_ASSUME_NONNULL_END
