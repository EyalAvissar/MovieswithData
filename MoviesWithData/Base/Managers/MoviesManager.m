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

-(NSURL *)getUrl {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentName = @"moviesList";
    
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    
    NSLog(@"%@",url);
    return url;
}

+(UIManagedDocument *)prepareUIManagedDocumentFor:(NSURL *)url {
    return [[UIManagedDocument alloc] initWithFileURL:url];
}

-(void)saveMoviesToDataBaseFileAndMovieManager {
    NSURL * url = [self getUrl];
    self.document = (self.document) ? self.document :[MoviesManager prepareUIManagedDocumentFor:url];
    
    bool fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if(fileExistsAtPath) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                if ([[ApplicationManager sharedInstance].movieManager moviesArray]) {
                    [self documentIsReady];
                }
                else {
                    [self InsertMoviesFromDataBaseToMovieManager];
                }
            }
            else {
                NSLog(@"failed to open file");
            }
        }];
    }
    else {
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady];
            }
            else {
                NSLog(@"Could not create file at the given url");
            }
        }];
    }
}

-(void)setMoviesQueryResults:(nullable NSString *) movieId {
    NSURL * url = [self getUrl];
    self.document = (self.document) ? self.document :[MoviesManager prepareUIManagedDocumentFor:url];
        
    [self.document openWithCompletionHandler:^(BOOL success) {
        if (success) {
            if (self.document.documentState == UIDocumentStateNormal) {
                NSManagedObjectContext *context = self.document.managedObjectContext;
                
                NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MovieEntity"];
                
                if (movieId) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"movieId == %@", movieId];
                    [request setPredicate:predicate];
                }
                
                self.queryResults = [context executeFetchRequest:request error:nil];
            }
            else {
                NSLog(@"Not Normal");
            }
        }
    }];
}


-(void)documentIsReady {
    if (self.document.documentState == UIDocumentStateNormal) {
        NSLog(@"queue2 %@",[NSOperationQueue currentQueue]);

        NSManagedObjectContext *context = self.document.managedObjectContext;
        
        for (Movie *received in [[ApplicationManager sharedInstance].movieManager moviesArray]) {
            
            NSManagedObject *movie = [NSEntityDescription insertNewObjectForEntityForName:@"MovieEntity" inManagedObjectContext:context];
           
            [movie setValue:received.name forKey:@"name"];
            [movie setValue:received.category forKey:@"category"];
            [movie setValue:received.movieId forKey:@"movieId"];
            [movie setValue:received.cinemasId forKey:@"cinemasId"];
            [movie setValue:received.year forKey:@"year"];
        }
        
    } else {
        NSLog(@"Document is not ready %lu", self.document.documentState);
    }
}


@end
