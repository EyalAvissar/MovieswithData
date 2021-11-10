//
//  StartUpManager.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "StartUpManager.h"
#import "GetHostUrlRequest.h"
#import "GetHostUrlResponse.h"
#import "ClearSessionRequest.h"
#import "ApplicationTokenRequest.h"
#import "ApplicationTokenResponse.h"
#import "SetSettingsRequest.h"
#import "ValidateVersionRequest.h"
#import "GeneralDeclarationRequest.h"
#import "MoviesRequest.h"
#import "CinemasRequest.h"
#import "ApplicationManager.h"
#import "Constants.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BannerViewController.h"

static StartUpManager *_sharedInstance = nil;

@interface StartUpManager ()
{
    NSString *token;
    NSString *baseUrl;
    UIManagedDocument *document;
}
@end

@implementation StartUpManager
+ (StartUpManager *)sharedInstance {
    
    if (! _sharedInstance) {
        _sharedInstance = [[StartUpManager alloc] init];
        _sharedInstance.isValidVersion = true;
    }
    
    return _sharedInstance;
}

- (void)start {
//        [self removeUserDefaults];
    self.inProcess = YES;
    [self getHostUrlRequest];
    
}


- (void)getHostUrlRequest {
    GetHostUrlRequest *getHostUrlRequest = [[GetHostUrlRequest alloc] initWithCallerObject:self andParams:nil];
    getHostUrlRequest.showHud = NO;
    getHostUrlRequest.allowSendingAboveMaxAttempts = YES;
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:getHostUrlRequest];
}

-(void)clearSession {
    ClearSessionRequest *clearSessionRequest = [[ClearSessionRequest alloc] initWithCallerObject:self andParams:nil];
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:clearSessionRequest];
}

-(void)applicationToken {
    ApplicationTokenRequest *applicationTokenRequest = [[ApplicationTokenRequest alloc] initWithCallerObject:self andParams:nil];
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:applicationTokenRequest];
}

-(void)setSettings {
    SetSettingsRequest *setSettingsRequest = [[SetSettingsRequest alloc] initWithCallerObject:self andParams:nil];
    
    NSLog(@"token %@",[[ApplicationManager sharedInstance].requestManager strApplicationToken]);
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:setSettingsRequest];
}

- (void)validateVersion {
    
    ValidateVersionRequest *validateVersionRequest = [[ValidateVersionRequest alloc] initWithCallerObject:self andParams:nil];
    validateVersionRequest.showHud = NO;
    validateVersionRequest.showMessage = NO;
    validateVersionRequest.allowSendingAboveMaxAttempts = YES;
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:validateVersionRequest];
}

-(void)generalDeclaration {
    GeneralDeclarationRequest *generalDeclarationRequest = [[GeneralDeclarationRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:generalDeclarationRequest];
}

-(void)movies {
    MoviesRequest *moviesRequest = [[MoviesRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:moviesRequest];
    
}

-(void)cinemas {
    CinemasRequest *cinemasRequest = [[CinemasRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:cinemasRequest];
}



#pragma mark - ServerRequestDoneProtocol


- (void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest {
    [self callNextRequest:baseResponse];
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
}

- (void)callNextRequest:(BaseServerRequestResponse *)baseResponse {
    
    if ([baseResponse.methodName isEqual: mGetHostUrl]) {
        baseUrl = ((GetHostUrlResponse *) baseResponse).hostURL;
        NSLog(@"url %@",baseUrl);
        
        [ApplicationManager sharedInstance].requestManager.hostURLstr = baseUrl;
        
        [self clearSession];
    }
    else if ([baseResponse.methodName isEqual: mClearSession]) {
        [self applicationToken];
    }
    else if ([baseResponse.methodName isEqual: mApplicationToken]) {
        [ApplicationManager sharedInstance].requestManager.strApplicationToken = ((ApplicationTokenResponse*)baseResponse).strApplicationToken;
        
        token = [ApplicationManager sharedInstance].requestManager.strApplicationToken;
        
        //since token is not part of my calls parameters, pretend it is by checking that it exists.
        
        if (token) {
            [self setSettings];
        }
        else {
            return;
        }
    }
    else if ([baseResponse.methodName isEqual: mSetSettings] && token) {
        [self validateVersion];
        
        if (!self.isValidVersion) { //to check alert reverse the condition and set isValidVersion to false
            NSLog(@"invalid version!");
            token = nil;
        }
    }
    else if ([baseResponse.methodName isEqual: mValidateVersion] && token) {
        [self generalDeclaration];
    }
    else if ([baseResponse.methodName isEqual:mGeneralDeclaration] && token) {
        [self movies];
    }
    else if ([baseResponse.methodName isEqual: mGetMovies] && token) {
        [self prepareDataBaseFile];
        [self cinemas];
    }
}

- (void)prepareDataBaseFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentName = @"moviesList";
    
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    
    NSLog(@"%@",url);
    
    document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    bool fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if(fileExistsAtPath) {
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                if ([[ApplicationManager sharedInstance].movieManager moviesArray]) {
                    [self documentIsReady];
                }
                else {
                    [self getMoviesFromDataBase];
                }
            }
            else {
                NSLog(@"failed to open file");
            }
        }];
    }
    else {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self documentIsReady];
            }
            else {
                NSLog(@"Could not create file at the given url");
            }
        }];
    }
}

- (NSArray *)getMovies {
    NSManagedObjectContext *context = document.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MovieEntity"];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    return results;
}

-(void)getMoviesFromDataBase {
    if (document.documentState == UIDocumentStateNormal) {
        NSArray * results = [self getMovies];
        
        NSLog(@"results count %lu", results.count);
        NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *moviesDictionary = [[NSMutableDictionary alloc] init];
        for (int index = 0; index < results.count; ++index) {
            Movie *movie = [Movie new];
            movie.name = [results[index] valueForKey:@"name"];
            movie.category = [results[index] valueForKey:@"category"];
            movie.movieId = [results[index] valueForKey:@"movieId"];
            movie.cinemasId = [results[index] valueForKey:@"cinemasId"];
            movie.year = [results[index] valueForKey:@"year"];
            movie.imageUrl = [results[index] valueForKey:@"imageUrl"];
            NSData *data = [results[index] valueForKey:@"moviePoster"];
            movie.moviePoster = [UIImage imageWithData:data];
            movie.rating = [results[index] valueForKey:@"rating"];
            movie.promoUrl = [results[index] valueForKey:@"promoUrl"];
            movie.movieDescription = [results[index] valueForKey:@"promoUrl"];
            
            [moviesArray addObject:movie];
            [moviesDictionary setValue:movie forKey:movie.movieId];
        }
        
        [[ApplicationManager sharedInstance].movieManager setMoviesArray:moviesArray];
        [[ApplicationManager sharedInstance].movieManager setMoviesDictionary:moviesDictionary];
    }
}

-(void)documentIsReady {
    if (document.documentState == UIDocumentStateNormal) {
        NSLog(@"queue2 %@",[NSOperationQueue currentQueue]);

        NSManagedObjectContext *context = document.managedObjectContext;
        
        for (Movie *received in [[ApplicationManager sharedInstance].movieManager moviesArray]) {
            
            NSManagedObject *movie = [NSEntityDescription insertNewObjectForEntityForName:@"MovieEntity" inManagedObjectContext:context];
           
            [movie setValue:received.name forKey:@"name"];
            [movie setValue:received.category forKey:@"category"];
            [movie setValue:received.movieId forKey:@"movieId"];
            [movie setValue:received.cinemasId forKey:@"cinemasId"];
            [movie setValue:received.year forKey:@"year"];
        }
        
    } else {
        NSLog(@"not ready %lu", document.documentState);
    }
}

- (void)removeUserDefaults
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

@end
