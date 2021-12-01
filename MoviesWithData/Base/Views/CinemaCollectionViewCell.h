//
//  CinemaCollectionViewCell.h
//  Base-objectiveC
//
//  Created by inmanage on 04/11/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CinemaCollectionViewCell : UICollectionViewCell

+(NSString *)identifier;

@property (weak, nonatomic) IBOutlet UILabel *cinemaLabel;

-(void)configure:(NSString *)cinemaNumber;

@end

NS_ASSUME_NONNULL_END
