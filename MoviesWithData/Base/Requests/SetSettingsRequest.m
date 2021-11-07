//
//  SetSettingsRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "SetSettingsRequest.h"
#import "SetSettingsResponse.h"
#import "Constants.h"

static NSString* requestName  = mSetSettings;

@implementation SetSettingsRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    SetSettingsResponse* setSettingsResponse = [[SetSettingsResponse alloc]init];
    [setSettingsResponse createResponse:jsonParsed];
    
    return setSettingsResponse;
    
    
}

-(NSString*)getMethodName
{
    return requestName;
}



@end
