//
//  FullMovieResponse.m
//  Base-objectiveC
//
//  Created by inmanage on 03/11/2021.
//

#import "FullMovieResponse.h"
#import "ApplicationManager.h"

@implementation FullMovieResponse

-(void)parseData:(NSDictionary *)JSON {
    
    NSNumber *movieId = JSON[@"id"];
    Movie *movie  = [[[ApplicationManager sharedInstance].movieManager moviesDictionary] objectForKey:movieId];
    [movie setRating:JSON[@"rate"]];
    [movie setImageUrl:JSON[@"imageUrl"]];
    [movie setPromoUrl:JSON[@"promoUrl"]];
    [movie setMovieDescription:JSON[@"description"]];

    NSLog(@"");
}

@end
