//
//  MovieManager.h
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "BaseRequest.h"
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoviesManager : BaseRequest

+(MoviesManager *)sharedInstance;
+(UIManagedDocument *)prepareUIManagedDocumentFor:(NSURL *)url;

@property NSArray *moviesArray;
@property NSDictionary *moviesDictionary;
@property NSDictionary *cinemasDictionary;
@property NSString *lastMoviesUpdate;
@property NSString *lastCinemasUpdate;
@property UIManagedDocument *document;
@property NSArray *queryResults;

-(NSMutableArray *)sortMoviesByCategory:(NSString *) category;
-(NSMutableArray *)sortBy:(NSString *)title arrayToSort: (NSArray *) array;
-(NSURL *)getUrl;

@end

NS_ASSUME_NONNULL_END
