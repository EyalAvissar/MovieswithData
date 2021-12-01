//
//  MovieTableCell.m
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import "MovieTableCell.h"

@implementation MovieTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(Movie *)movie {
    self.movieName.text = movie.name;
    self.movieYear.text = [NSString stringWithFormat:@"%@",movie.year];
}

@end
