//
//  CinemasResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "CinemasResponse.h"
#import "ApplicationManager.h"
#import "Cinema.h"

@implementation CinemasResponse

-(void)parseData:(NSDictionary*)JSON{
    NSMutableDictionary *cinemaDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *jsonCinema in JSON[@"cinemas"]) {

        Cinema *cinema = [Cinema new];
        cinema.name = jsonCinema[@"name"];
        cinema.cinemaId = jsonCinema[@"id"];
        
        [cinemaDictionary setObject:cinema forKey:cinema.cinemaId];
    }

    [[ApplicationManager sharedInstance].movieManager setCinemasDictionary:cinemaDictionary];
    [[ApplicationManager sharedInstance].movieManager setLastCinemasUpdate:JSON[@"cinemas_last_update"]];
}

@end
