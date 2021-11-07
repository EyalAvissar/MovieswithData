//
//  BaseRequest.h
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerRequestResponse.h"
#import "ServerRequestDoneProtocol.h"


@interface BaseRequest : NSObject

@property NSDictionary * dictParams;
@property id callerObject;
@property BOOL showHud;
@property BOOL showMessage;
@property (nonatomic) BOOL isGET;
@property (nonatomic, assign) BOOL allowSendingAboveMaxAttempts;
@property (nonatomic, assign) int maxAttempts;

-(id)init;
-(id)initWithCallerObject: (id<ServerRequestDoneProtocol>)callerObject andParams: (NSDictionary*)dictParams;
-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed;

-(NSString*)getMethodName;

-(BOOL)canSendRequestAgain;
-(void)increaseAttemptCounter;
-(void)resetAttemptCounter;

@end
