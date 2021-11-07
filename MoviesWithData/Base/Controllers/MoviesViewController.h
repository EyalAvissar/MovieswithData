//
//  MoviesViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moviesTable;

- (IBAction)sort:(UIButton *)sender;
- (IBAction)showMovieGenre:(UIButton *)sender;
- (IBAction)showAll:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;

@end

NS_ASSUME_NONNULL_END
