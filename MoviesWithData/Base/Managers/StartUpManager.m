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
#import "BannerViewController.h"

static StartUpManager *_sharedInstance = nil;

@interface StartUpManager ()
{
    NSString *token;
    NSString *moviesUpdate;
    NSString *cinemasUpdate;
    NSString *defaultsMoviesUpdate;
    NSString *defaultsCinemasUpdate;
    NSString *baseUrl;
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
//    [self removeUserDefaults];
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
        unsigned long container = [[ApplicationManager sharedInstance].appGD moviesLastUpdate];
        moviesUpdate = [NSString stringWithFormat:@"%ul", container];
        
        container = [[ApplicationManager sharedInstance].appGD cinemasLastUpdate];
        cinemasUpdate = [NSString stringWithFormat:@"%ul", container];
        NSLog(@"updates %@, %@",moviesUpdate, cinemasUpdate);
        NSLog(@"");
        
        defaultsMoviesUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:@"moviesUpdate"];
        defaultsCinemasUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:@"cinemasUpdate"];
        
        NSLog(@"%@, %@", defaultsMoviesUpdate, defaultsCinemasUpdate);
        NSLog(@"");
        
        NSLog(@"updates %@",defaultsMoviesUpdate, moviesUpdate);
        NSLog(@"");
        
        if (![defaultsMoviesUpdate isEqualToString:moviesUpdate]) {
            [[NSUserDefaults standardUserDefaults] setObject:moviesUpdate forKey:@"moviesUpdate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self movies];
        }
    }
    else if ([baseResponse.methodName isEqual: mGetMovies] && token) {
        if (![defaultsCinemasUpdate isEqualToString:cinemasUpdate]) {
            [[NSUserDefaults standardUserDefaults] setObject:cinemasUpdate forKey:@"cinemasUpdate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self cinemas];
        }
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
