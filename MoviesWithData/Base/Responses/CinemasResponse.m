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
    NSString *currentCinemasUpdate =  JSON[@"cinemas_last_update"];//@"1";

    
    if ([lastCinemasUpdate isEqual:currentCinemasUpdate]) {
        return;
    }
    
    [[ApplicationManager sharedInstance].movieManager setLastCinemasUpdate:currentCinemasUpdate];
    
    [self cinemasUpdateNeeded];
    
    for (NSDictionary *jsonCinema in JSON[@"cinemas"]) {

        Cinema *cinema = [Cinema new];
        cinema.name = jsonCinema[@"name"];
        cinema.cinemaId = jsonCinema[@"id"];
        cinema.latitudeStr = jsonCinema[@"lat"];
        cinema.latitudeStr = jsonCinema[@"lng"];

        [cinemaDictionary setObject:cinema forKey:cinema.cinemaId];
    }

    [[ApplicationManager sharedInstance].movieManager setCinemasDictionary:cinemaDictionary];
}

-(Boolean)cinemasUpdateNeeded {
//    NSString *userCinemasUpdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"userCinemasUpdate"];
//
//    if ([userCinemasUpdate isEqual:currentCinemasUpdate]) {
//        return false;
//    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentName = @"cinemasList";
    
//    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl:documentName];//[documentsDirectory URLByAppendingPathComponent:documentName];
    
    [fileManager removeItemAtURL:url error:nil];
    
//    [[NSUserDefaults standardUserDefaults] setObject:currentCinemasUpdate forKey:@"userCinemasUpdate"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}


@end
