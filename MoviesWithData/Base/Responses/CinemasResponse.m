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
    
    NSString *lastCinemasUpdate = [[ApplicationManager sharedInstance].movieManager lastCinemasUpdate];
    NSString *currentCinemasUpdate = @"1"; //JSON[@"cinemas_last_update"];//@"1";

    
    if ([lastCinemasUpdate isEqual:currentCinemasUpdate]) {
        return;
    }
    
    [[ApplicationManager sharedInstance].movieManager setLastCinemasUpdate:currentCinemasUpdate];
    
    [self cinemasUpdateNeeded];
    
    Cinema *cinema = [Cinema new];
    NSMutableArray *moviesArray = [NSMutableArray new];

    for (NSDictionary *jsonCinema in JSON[@"cinemas"]) {
        cinema.name = jsonCinema[@"name"];
        cinema.cinemaId = jsonCinema[@"id"];
        cinema.latitudeStr = jsonCinema[@"lat"];
        cinema.longitudeStr = jsonCinema[@"lng"];
        

        for (Movie *movie in [[ApplicationManager sharedInstance].movieManager moviesArray]) {

            long tempId = [cinema.cinemaId longLongValue];
            NSNumber *cinemaID = [NSNumber numberWithLong:tempId];
            
            if ([movie.cinemasId containsObject: cinemaID]) {
                [moviesArray addObject:movie.movieId];
            }
        }
        cinema.movieIdArray = moviesArray;
        [cinemaDictionary setObject:cinema forKey:cinema.cinemaId];
        cinema = [Cinema new];
        moviesArray = [NSMutableArray new];
    }

    [[ApplicationManager sharedInstance].movieManager setCinemasDictionary:cinemaDictionary];
}

-(Boolean)cinemasUpdateNeeded {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentName = @"cinemasList";
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl:documentName];//[documentsDirectory URLByAppendingPathComponent:documentName];
    
    [fileManager removeItemAtURL:url error:nil];
    
//    [[NSUserDefaults standardUserDefaults] setObject:currentCinemasUpdate forKey:@"userCinemasUpdate"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}


@end
