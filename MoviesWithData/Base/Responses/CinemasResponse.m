//
//  CinemasResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "CinemasResponse.h"
#import "ApplicationManager.h"
#import "Cinema.h"

@implementation CinemasResponse {
    NSString *currentCinemasUpdate;
}

-(void)parseData:(NSDictionary*)JSON{
    NSMutableDictionary *cinemaDictionary = [[NSMutableDictionary alloc] init];
    
    [[ApplicationManager sharedInstance].movieManager setLastCinemasUpdate:JSON[@"cinemas_last_update"]];
    currentCinemasUpdate = JSON[@"cinemas_last_update"];

    
    if (![self isCinemasUpdateNeeded]) {
        return;
    }
    
    for (NSDictionary *jsonCinema in JSON[@"cinemas"]) {

        Cinema *cinema = [Cinema new];
        cinema.name = jsonCinema[@"name"];
        cinema.cinemaId = jsonCinema[@"id"];
        
        [cinemaDictionary setObject:cinema forKey:cinema.cinemaId];
    }

    [[ApplicationManager sharedInstance].movieManager setCinemasDictionary:cinemaDictionary];
}

-(Boolean)isCinemasUpdateNeeded {
    NSString *userCinemasUpdate = [[NSUserDefaults standardUserDefaults] valueForKey:@"userCinemasUpdate"];
    
    if ([userCinemasUpdate isEqual:currentCinemasUpdate]) {
        return false;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentName = @"cinemasList";
    
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    
    [fileManager removeItemAtURL:url error:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:currentCinemasUpdate forKey:@"userCinemasUpdate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}


@end
