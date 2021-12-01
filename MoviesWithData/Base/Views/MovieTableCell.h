//
//  MovieTableCell.h
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;

-(void)configureCell:(Movie *)movie;
@end

NS_ASSUME_NONNULL_END
