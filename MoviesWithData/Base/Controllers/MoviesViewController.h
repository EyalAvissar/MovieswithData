//
//  MoviesViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoviesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MenuProtocol>

@property (weak, nonatomic) IBOutlet UITableView *moviesTable;

- (IBAction)sort:(UIButton *)sender;
- (IBAction)showMovieGenre:(UIButton *)sender;
- (IBAction)showAll:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;
- (IBAction)menuButtonTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
