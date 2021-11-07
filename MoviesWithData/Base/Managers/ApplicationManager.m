//
//  ApplicationManager.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "ApplicationManager.h"

@implementation ApplicationManager

static ApplicationManager *_sharedInstance = nil;

+ (ApplicationManager *)sharedInstance {
    
    if (! _sharedInstance) {
        _sharedInstance = [[ApplicationManager alloc] init];
        _sharedInstance.startUpManager = [StartUpManager sharedInstance];
        _sharedInstance.requestManager = [RequestManager sharedInstance];
        _sharedInstance.appGD = [AppGeneralDeclarationResponse new];
        _sharedInstance.movieManager = [MoviesManager sharedInstance];
        _sharedInstance.imageRequestManger = [ImageRequestManager sharedInstance];
    }
    
    return _sharedInstance;
}

@end
