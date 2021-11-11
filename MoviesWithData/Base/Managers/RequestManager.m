//
//  RequestManager.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "RequestManager.h"
#import "AFHTTPSessionManager.h"
#import "ApplicationManager.h"
#import "DetailViewController.h"
#import "Movie.h"
#import "Constants.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFImageDownloader.h>
//#import "GetHostUrlResponse.h"

static RequestManager *_sharedInstance = nil;
static const NSTimeInterval methodTimeout = 1.5;

@implementation RequestManager
{
    NSMutableArray* serverRequestDoneDelegates;
    BOOL retryConter;
}

+ (RequestManager *)sharedInstance {
    
    if(! _sharedInstance) {
        _sharedInstance = [[RequestManager alloc] init];
    }
    
    return _sharedInstance;
}

-(id)init{
    self=[super init];
    serverRequestDoneDelegates=[[NSMutableArray alloc]init];
    return self;
}

-(void)addServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller{
    if (![serverRequestDoneDelegates containsObject:caller]) {
        
        BOOL newCaller = YES;
        
        for (id<ServerRequestDoneProtocol>delegate in serverRequestDoneDelegates) {
            if ([delegate isMemberOfClass:[caller class]]) {
                newCaller = NO;
                break;
            }
        }
        
        if (newCaller) {
            [serverRequestDoneDelegates addObject:caller];
            
        }
    }
}

-(void)removeServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller{
    [serverRequestDoneDelegates removeObject:caller];
}

-(void)sendRequestForRequest: (BaseRequest*) baseRequest {


    [baseRequest increaseAttemptCounter];
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    if([[baseRequest getMethodName]isEqualToString:mApplicationToken]) {
        [manager.requestSerializer setValue:kApplicationSecurityToken forHTTPHeaderField:@"TOKEN"];
    } else {
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"TOKEN"];
    }
    
    NSArray *allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSLog(@"\n 🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐 \n\n\n\n");
    NSString *baseUrl = self.hostURLstr;
    
    baseUrl = (baseUrl)? baseUrl : @"https://mobile.inmanage.com/mobile-test/";
    
    

    if ([baseRequest isGET]) {

        NSString * _Nonnull extractedExpr;
        
        if ([baseRequest.getMethodName isEqual: mDescriptionMovies]) {
            NSNumber *movieId = [(DetailViewController *)(baseRequest.callerObject) movieId];
            
            
            extractedExpr = [NSString stringWithFormat:@"%@%@/%@.json",baseUrl, baseRequest.getMethodName, movieId];
        }
        else {
            extractedExpr = [NSString stringWithFormat:@"%@%@.json",baseUrl, baseRequest.getMethodName];
        }
        
        NSString* strPostUrl = extractedExpr;
        
        NSLog(@"cmd GET METHOD %@:\r\nparamaters: %@", strPostUrl, baseRequest.dictParams);
        NSLog(@"\n\n\n\n ❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️" );

        
                
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager GET:strPostUrl parameters:baseRequest.dictParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *reponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"x-cache: %@ - method: strPostUrl %@", [[reponse allHeaderFields] objectForKey:@"x-cache"], strPostUrl);
            
            
            [self handleSuccess:baseRequest res:responseObject task:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailure:baseRequest task:task error:error];
        }];
    }
    else {
        NSString *strPostUrl;
        
        if ([baseRequest.getMethodName isEqual: mMovieImage]) {
            strPostUrl = [NSString stringWithString: baseUrl];
//            AFImageResponseSerializer* serializer = (AFImageResponseSerializer*)[UIImageView sharedImageDownloader].sessionManager.responseSerializer;
//            serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"image/jpg"];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];
        }
        else {
            strPostUrl = [NSString stringWithFormat:@"%@%@.json",baseUrl, baseRequest.getMethodName];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        

        [manager POST:strPostUrl parameters:baseRequest.dictParams headers:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccess:baseRequest res:responseObject task:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            [self handleFailure:baseRequest task:task error:error];
        }];
    }
}

- (void)handleFailure:(BaseRequest*)baseRequest task:(NSURLSessionDataTask*)task error:(NSError*)error {
    NSLog(@"\n❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️ \n\n\n\n " );
    NSLog(@"cmd %@:\r\n failure: %@", baseRequest.getMethodName, error);
    NSLog(@"\n\n\n\n ❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️" );
    
    if ([baseRequest canSendRequestAgain]) {
        
        NSTimeInterval requestAttemptDelay = ([ApplicationManager sharedInstance].appGD.methodTimeout > 0) ? [ApplicationManager sharedInstance].appGD.methodTimeout : methodTimeout;
        
//        NSArray *arrHUDs = [MBProgressHUD allHUDsForView:[UIApplication sharedApplication].keyWindow];
        
//        if (baseRequest.showHud && (!arrHUDs || arrHUDs.count == 0) && [UIApplication sharedApplication].keyWindow) {
//
////            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        }
        
        [self performSelector:@selector(sendRequestForRequest:) withObject:baseRequest afterDelay:requestAttemptDelay];
        
        
    } else {
        
        for (int i = 0; i < serverRequestDoneDelegates.count; i++) {
            
            id caller = [serverRequestDoneDelegates objectAtIndex:i];
            
            // Prevent multiple callbacks
            if (caller == baseRequest.callerObject) {
                continue;
            }
            
//            [caller serverRequestFailed:baseRespone baseRequest:baseRequest];
            
        }
        
    }
}

- (void)handleSuccess:(BaseRequest*)baseRequest res:(id)responseObject task:(NSURLSessionDataTask*)task {
    
    NSLog(@"In HandleSuccess - response for: %@ Response object %@", baseRequest.getMethodName , responseObject);

    BaseServerRequestResponse * baseResponse  = [baseRequest buildBaseServerResponse: responseObject];

    if(baseResponse.isSuccess) {
        
        baseResponse.methodName = baseRequest.getMethodName;
        
        if(![serverRequestDoneDelegates containsObject:baseRequest.callerObject]) {
            [baseRequest.callerObject serverRequestSucceed:baseResponse baseRequest:baseRequest];
            
        }
        
        for (int i =0; i<serverRequestDoneDelegates.count; i++) {
            id caller = [serverRequestDoneDelegates objectAtIndex:i];
            [caller serverRequestSucceed:baseResponse baseRequest:baseRequest];
            
        }
    }
}

@end
