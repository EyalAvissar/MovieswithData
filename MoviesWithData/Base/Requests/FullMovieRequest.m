//
//  FullMovieRequest.m
//  Base-objectiveC
//
//  Created by inmanage on 03/11/2021.
//

#import "FullMovieRequest.h"
#import "FullMovieResponse.h"
#import "Constants.h"

static NSString* requestName  = mDescriptionMovies;

@implementation FullMovieRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    FullMovieResponse *fullMovieResponse = [[FullMovieResponse alloc] init];
    [fullMovieResponse createResponse:jsonParsed];

    return fullMovieResponse;
}

-(NSString*)getMethodName
{
    return requestName;
}

- (BOOL)isGET {
    return YES;
}

@end
