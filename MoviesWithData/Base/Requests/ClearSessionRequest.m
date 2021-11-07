//
//  GetClearSessionRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "ClearSessionRequest.h"
#import "ClearSessionResponse.h"
#import "Constants.h"

static NSString *requestName = mClearSession;

@implementation ClearSessionRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    ClearSessionResponse* clearSessionResponse = [[ClearSessionResponse alloc]init];
    [clearSessionResponse createResponse:jsonParsed];
    return clearSessionResponse;    
}

- (NSString *)getMethodName {
    return requestName;
}



@end
