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
#import "Cinema.h"

static StartUpManager *_sharedInstance = nil;

@interface StartUpManager ()
{
    NSString *token;
    NSString *baseUrl;
    UIManagedDocument *moviesDocument;
    UIManagedDocument *cinemasDocument;

    bool isCinemas;
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

#pragma mark- Requests methods

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
        
        //Check Alert shows - reverse the condition and set isValidVersion to false
        if (!self.isValidVersion) {
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
        [self prepareMoviesDataBaseFile];
        [self cinemas];
    }
    else {
        isCinemas = true;
        [self prepareCinemasDataBaseFile];
    }
}

#pragma mark - cinemas database methods

- (void)prepareCinemasDataBaseFile {
    NSString * documentName = @"cinemasList";
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl: documentName];
    NSLog(@"prepareCinemasDataBaseFile %@",url);
    
    cinemasDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    
    bool fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if(fileExistsAtPath) {
        [cinemasDocument openWithCompletionHandler:^(BOOL success) {
            NSLog(@"block prepareMoviesDataBaseFile");

            if (success) {
                if ([[ApplicationManager sharedInstance].movieManager cinemasDictionary]) {
                    [self cinemasDocumentIsReady];
                }
                else {
                    [self getCinemasFromDataBase];
                }
            }
            else {
                NSLog(@"failed to open file");
            }
        }];
    }
    else {
        [cinemasDocument saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self cinemasDocumentIsReady];
            }
            else {
                NSLog(@"Could not create file at the given url");
            }
        }];
    }
}

-(void)cinemasDocumentIsReady {
    if (cinemasDocument.documentState == UIDocumentStateNormal) {
        NSLog(@"cinemasDocument is ready. 1");

        NSManagedObjectContext *context = cinemasDocument.managedObjectContext;
        
            NSDictionary *cinemas = [[ApplicationManager sharedInstance].movieManager cinemasDictionary];
            
            for (id key in [[ApplicationManager sharedInstance].movieManager cinemasDictionary]) {
                
                NSManagedObject *cinema = [NSEntityDescription insertNewObjectForEntityForName:@"CinemaEntity" inManagedObjectContext:context];
                NSLog(@"");
                
                Cinema *received = cinemas[key];
                
                [cinema setValue: received.cinemaId forKey:@"cinemaId"];
                [cinema setValue:received.name forKey:@"name"];
                [cinema setValue:received.latitudeStr forKey:@"latitudeStr"];
                [cinema setValue:received.longitudeStr forKey:@"longitudeStr"];


                NSLog(@"");
        }
        
    } else {
        NSLog(@"cinemasDocument not ready 1 %lu", cinemasDocument.documentState);
    }
}

-(void)getCinemasFromDataBase {
    if (cinemasDocument.documentState == UIDocumentStateNormal) {
        NSLog(@"cinemasDocument is ready.2");

        NSManagedObjectContext *context = cinemasDocument.managedObjectContext;

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CinemaEntity"];

        NSArray *results = [context executeFetchRequest:request error:nil];

        NSLog(@"results count %lu", results.count);
        NSMutableDictionary *cinemasDictionary = [[NSMutableDictionary alloc] init];
        
        for (int index = 0; index < results.count; ++index) {
            Cinema *cinema = [Cinema new];
            cinema.name = [results[index] valueForKey:@"name"];
            cinema.cinemaId = [results[index] valueForKey:@"cinemaId"];
            cinema.latitudeStr = [results[index] valueForKey:@"latitudeStr"];
            cinema.longitudeStr = [results[index] valueForKey:@"longitudeStr"];

            [cinemasDictionary setValue:cinema forKey:cinema.cinemaId];
        }

        [[ApplicationManager sharedInstance].movieManager setCinemasDictionary:cinemasDictionary];
    }
    else {
        NSLog(@"cinemasDocument is not ready 2 %lu",cinemasDocument.documentState);
    }
    
}

#pragma mark - movies database methods

- (void)prepareMoviesDataBaseFile {
    NSString *documentName = @"moviesList";
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl: documentName];
    NSLog(@"prepareMoviesDataBaseFile %@",url);
    
    moviesDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    
    bool fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if(fileExistsAtPath) {
        [moviesDocument openWithCompletionHandler:^(BOOL success) {
            NSLog(@"block prepareMoviesDataBaseFile");

            if (success) {
                if ([[ApplicationManager sharedInstance].movieManager moviesArray]) {
                    [self moviesDocumentIsReady];
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
        [moviesDocument saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self moviesDocumentIsReady];
            }
            else {
                NSLog(@"Could not create file at the given url");
            }
        }];
    }
}

- (NSArray *)getMovies {
    NSManagedObjectContext *context = moviesDocument.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MovieEntity"];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    return results;
}

- (void)setMovieFields:(int)index movie:(Movie *)movie results:(NSArray *)results {
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
    movie.movieDescription = [results[index] valueForKey:@"movieDescription"];
}

-(void)getMoviesFromDataBase {
    if (moviesDocument.documentState == UIDocumentStateNormal) {
        NSArray * results = [self getMovies];
        
        NSLog(@"results count %lu", results.count);
        NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *moviesDictionary = [[NSMutableDictionary alloc] init];
        for (int index = 0; index < results.count; ++index) {
            Movie *movie = [Movie new];
            [self setMovieFields:index movie:movie results:results];
            
            [moviesArray addObject:movie];
            [moviesDictionary setValue:movie forKey:movie.movieId];
        }
        
        [[ApplicationManager sharedInstance].movieManager setMoviesArray:moviesArray];
        [[ApplicationManager sharedInstance].movieManager setMoviesDictionary:moviesDictionary];
    }
}



-(void)moviesDocumentIsReady {
    if (moviesDocument.documentState == UIDocumentStateNormal) {
        NSLog(@"movies document ready");

        NSManagedObjectContext *context = moviesDocument.managedObjectContext;
        
        for (Movie *received in [[ApplicationManager sharedInstance].movieManager moviesArray]) {
            
            NSManagedObject *movie = [NSEntityDescription insertNewObjectForEntityForName:@"MovieEntity" inManagedObjectContext:context];
            
            [movie setValue:received.name forKey:@"name"];
            [movie setValue:received.category forKey:@"category"];
            [movie setValue:received.movieId forKey:@"movieId"];
            [movie setValue:received.cinemasId forKey:@"cinemasId"];
            [movie setValue:received.year forKey:@"year"];
        }
    }
    else {
        NSLog(@"movies document not ready %lu", moviesDocument.documentState);
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
