//
//  TestCollectionViewCell.h
//  MoviesWithData
//
//  Created by inmanage on 21/11/2021.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCinemaViewCell : UICollectionViewCell

+(NSString *)identifier;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property long tableRow;

//-(NewCinemaViewCell *) resetCell:(NewCinemaViewCell *)cell cinema:(Cinema *)cinema;
@end

NS_ASSUME_NONNULL_END
