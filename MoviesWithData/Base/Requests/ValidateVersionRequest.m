//
//  ValidateVersionRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "ValidateVersionRequest.h"
#import "ValidateVersionResponse.h"
#import "Constants.h"

static NSString* requestName  = mValidateVersion;

@implementation ValidateVersionRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    ValidateVersionResponse* validateVersionResponse = [[ValidateVersionResponse alloc]init];
    [validateVersionResponse createResponse:jsonParsed];
    
    return validateVersionResponse;    
}

-(NSString*)getMethodName
{
    return requestName;
}

@end
