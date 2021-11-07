//
//  ApplicationTokenRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "ApplicationTokenRequest.h"
#import "ApplicationTokenResponse.h"

static NSString *requestName = mApplicationToken;

@implementation ApplicationTokenRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    ApplicationTokenResponse *applicationTokenResponse = [[ApplicationTokenResponse alloc]init];
    [applicationTokenResponse createResponse:jsonParsed];
    
    return applicationTokenResponse;    
}

- (NSString *)getMethodName {
    return requestName;
}



@end
