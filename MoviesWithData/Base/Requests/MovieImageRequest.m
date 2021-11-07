//
//  MovieImageRequest.m
//  Base-objectiveC
//
//  Created by inmanage on 03/11/2021.
//

#import "MovieImageRequest.h"
#import "MovieImageResponse.h"
#import "Constants.h"

static NSString* requestName = mMovieImage;

@implementation MovieImageRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    MovieImageResponse *movieImageResponse = [[MovieImageResponse alloc] init];
    [movieImageResponse createResponse:jsonParsed];

    return movieImageResponse;
}

-(NSString*)getMethodName
{
    return requestName;
}

//- (BOOL)isGET {
//    return YES;
//}

@end
