//
//  GetHostUrlRequest.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "GetHostUrlRequest.h"
#import "GetHostUrlResponse.h"
#import "Constants.h"

static NSString* requestName  = mGetHostUrl;
static int callIndex = 0;

@implementation GetHostUrlRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    GetHostUrlResponse* getHostUrlResponse = [[GetHostUrlResponse alloc]init];
    [getHostUrlResponse createResponse:jsonParsed];
    
    return getHostUrlResponse;
    
    
}

-(NSString*)getMethodName
{
    
    return requestName;
}

- (BOOL)isGET {
    return YES;
}

@end
