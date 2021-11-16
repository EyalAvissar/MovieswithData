//
//  CinemaTableCell.h
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CinemaTableCell : UITableViewCell

+(NSString *)identifier;

@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;

@property id<MenuProtocol> dataSource;
@property NSString *cinemaId;

- (void)configureCell:(long)index;

@end

NS_ASSUME_NONNULL_END
