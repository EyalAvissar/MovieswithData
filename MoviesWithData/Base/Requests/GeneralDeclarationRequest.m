//
//  GeneralDeclarationRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "GeneralDeclarationRequest.h"
#import "GeneralDeclarationResponse.h"
#import "Constants.h"

static NSString* requestName  = mGeneralDeclaration;

@implementation GeneralDeclarationRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    GeneralDeclarationResponse* generalDeclarationResponse = [[GeneralDeclarationResponse alloc]init];
    [generalDeclarationResponse createResponse:jsonParsed];
    
    return generalDeclarationResponse;
    
    
}

-(NSString*)getMethodName
{
    return requestName;
}

@end
