//
//  BaseRequest.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "BaseRequest.h"
#import "ApplicationManager.h"

@implementation BaseRequest
{
    int attemptCounter;
}

-(id)init{
    self=[super init];
    
    return self;
}

-(id)initWithCallerObject: (id<ServerRequestDoneProtocol>)callerObject andParams: (NSDictionary*)dictParams {
    self = [super init];
    self.callerObject=callerObject;
    
    NSMutableDictionary * dictAllParams = [[NSMutableDictionary alloc]initWithDictionary:dictParams];
    
    NSString *token = [ApplicationManager sharedInstance].requestManager.strApplicationToken;
    if(token) {
        [dictAllParams setObject:token forKey:@"applicationToken"];
    }
    
    self.dictParams=dictAllParams;
    
    self.showHud=YES;
    self.showMessage=YES;
    
    self.maxAttempts = ([ApplicationManager sharedInstance].appGD.methodAttempts > 0) ? [ApplicationManager sharedInstance].appGD.intMethodAttempts : 3;
    self.allowSendingAboveMaxAttempts = YES;
    
    //Above parameters changed by orders of Itay Bardugo
    [self resetAttemptCounter];
    
    return self;
}
-(BOOL)canSendRequestAgain{
    if (attemptCounter < self.maxAttempts) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)isGET {
    for (NSString *method in [RequestManager sharedInstance].getMethodsArr) {
        if ([method isEqualToString:[self getMethodName]]) {
            [self.dictParams setValue:nil forKey:@"applicationToken"];
            return YES;
        }
    }
    
    return NO;
}

- (void)increaseAttemptCounter {
    attemptCounter++;
}

- (void)resetAttemptCounter {
    attemptCounter = 0;
}

-(NSString*)getMethodName{
    return nil;
}

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed{
    return nil;
}


@end
