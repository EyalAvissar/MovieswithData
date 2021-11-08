//
//  StartUpManager.h
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "BaseManager.h"
#import "BaseManager.h"
#import "ServerRequestDoneProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface StartUpManager : BaseManager

+ (StartUpManager *)sharedInstance;

@property (assign, nonatomic) int counter;
@property (assign, nonatomic) int countToShowImages;
@property (strong, nonatomic) NSMutableArray *imagesToShowArr;
@property (assign, nonatomic) BOOL didRegisterToRemoteNotifications;
@property (strong, nonatomic) id callerObject;
@property (assign, nonatomic) BOOL didFinishStartUpProcess;
@property (assign, nonatomic) BOOL didFinishSplashVideo;
@property BOOL inProcess;

@property NSString *receivedURL;
@property Boolean isValidVersion;

-(void)start;
@end

NS_ASSUME_NONNULL_END
