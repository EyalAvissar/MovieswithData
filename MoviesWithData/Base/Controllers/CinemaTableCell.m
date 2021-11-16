//
//  CinemaTableCell.m
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import "CinemaTableCell.h"
#import "ApplicationManager.h"
#import "Cinema.h"
#import "DetailViewController.h"

@implementation CinemaTableCell {
    int numberOfButtons;
    UIScrollView *scroll;
    Cinema *cinema;
}

+ (NSString *)identifier {
    return @"CinemaCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.cinemaNameLabel.bounds.size.height + 5, self.frame.size.width, self.frame.size.height - self.cinemaNameLabel.bounds.size.height - 5)];
    
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
//    [scroll setBackgroundColor:[UIColor redColor]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCell:(long)index {
    index++; //cinemas ids starts from 1, indices from 0
    cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:[NSString stringWithFormat:@"%lu", index]];
    self.cinemaNameLabel.text = cinema.name;
    self.cinemaId = cinema.cinemaId;
    
    [self addMoviesButtons];
    numberOfButtons++;
}

-(void) addMoviesButtons {
    for (int i = 0; i < cinema.movieIdArray.count; i++) {
        CGFloat xOrigin = i * 200;
        UIButton *movieButton = [[UIButton alloc] initWithFrame:CGRectMake(xOrigin + 10, 0, 190, scroll.frame.size.height)];
    
        Movie *presentedMovie = [[[ApplicationManager sharedInstance].movieManager moviesDictionary] objectForKey:cinema.movieIdArray[i]];
        
        [movieButton setTitle:presentedMovie.name forState:UIControlStateNormal];
        [movieButton setTitle:self.cinemaId forState:UIControlStateSelected];
        
        [movieButton.titleLabel setNumberOfLines:0];
        [movieButton setTag:[presentedMovie.movieId intValue]];
        
        UITapGestureRecognizer *movieTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullMovieDescription:)];
                movieTapRecognizer.numberOfTapsRequired = 1;
        [movieButton addGestureRecognizer:movieTapRecognizer];
        
        movieButton.backgroundColor = [UIColor blackColor];
        [scroll addSubview:movieButton];
    }
    scroll.contentSize = CGSizeMake(cinema.movieIdArray.count * 220 + 220, scroll.frame.size.height);
    [self addSubview:scroll];
}

-(void)showFullMovieDescription:(UITapGestureRecognizer*)sender {
    UIButton *tappedButton = (UIButton *)sender.view;
    
    long pressed = (long)tappedButton.tag;
    NSLog(@"button tag is %li",pressed);
    
    NSString *cinemaId = [tappedButton titleForState:UIControlStateSelected];
    NSLog(@"cinema is %@",cinemaId);

    [self.dataSource didPressMovie:pressed :cinemaId]; 
}

@end
