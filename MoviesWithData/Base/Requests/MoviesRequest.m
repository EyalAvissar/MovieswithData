//
//  MoviesRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesRequest.h"
#import "MoviesResponse.h"
#import "Constants.h"

static NSString* requestName  = mGetMovies;

@implementation MoviesRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    MoviesResponse *moviesResponse = [[MoviesResponse alloc] init];
    [moviesResponse createResponse:jsonParsed];

    return moviesResponse;
}

-(NSString*)getMethodName
{
    return requestName;
}

- (BOOL)isGET {
    return YES;
}
@end
