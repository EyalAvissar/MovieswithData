//
//  CinemaCollectionViewCell.m
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import "CinemaCollectionViewCell.h"
#import "ApplicationManager.h"
#import "Cinema.h"

@implementation CinemaCollectionViewCell

+ (NSString *)identifier {
    return @"cinemaCell";
}

-(void)configure:(NSString *)cinemaNumber {
    NSDictionary *cinemaDictionary = [[ApplicationManager sharedInstance].movieManager cinemasDictionary];
    
    Cinema *cinema = cinemaDictionary[cinemaNumber ];
    
    self.cinemaLabel.text = cinema.name;
    NSLog(@"%@, %@",cinema.name, cinema.cinemaId);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
