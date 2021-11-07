//
//  CinemasRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "CinemasRequest.h"
#import "CinemasResponse.h"
#import "Constants.h"

static NSString *requestName = mGetCinemas;

@implementation CinemasRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    CinemasResponse *cinemasResponse = [[CinemasResponse alloc]init];
    [cinemasResponse createResponse:jsonParsed];
    
    return cinemasResponse;
}

- (NSString *)getMethodName {
    return requestName;
}

- (BOOL)isGET {
    return YES;
}

@end
