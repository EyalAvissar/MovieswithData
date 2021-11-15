//
//  MoviesViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesViewController.h"
#import "ApplicationManager.h"
#import "MovieTableCell.h"
#import "Movie.h"
#import "DetailViewController.h"
#import "MenuViewController.h"
#import "CinemasViewController.h"


static NSString *identifier;

@interface MoviesViewController ()
{
    NSArray *moviesArray;
    NSMutableArray *partialMoviesArray;
    MenuViewController *menuController;
}
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movieSearchBar.delegate = self;
    moviesArray = [[ApplicationManager sharedInstance].movieManager moviesArray];
    partialMoviesArray = [NSMutableArray arrayWithArray:moviesArray];
    identifier = @"movieCell";
    [self.moviesTable registerNib:[UINib nibWithNibName:@"MovieTableCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    
}

#pragma mark - tableView datasource methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    Movie *movie = partialMoviesArray[indexPath.row];
    
    [cell configureCell:movie];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return partialMoviesArray.count;
}

#pragma mark - tableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    Movie *selectedMovie = partialMoviesArray[indexPath.row];

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
    
    detailController.movieId = [NSString stringWithFormat:@"%@", selectedMovie.movieId];
    
    [self.navigationController pushViewController:detailController animated:true];
}


#pragma mark - Sort Movies Methods

-(void)sortMoviesByCategory:(NSString *) category {
    partialMoviesArray = [[ApplicationManager sharedInstance].movieManager sortMoviesByCategory:category];
    [self.moviesTable reloadData];
}

- (IBAction)showAll:(UIButton *)sender {
    partialMoviesArray = [NSMutableArray arrayWithArray:moviesArray];
    [self.moviesTable reloadData];
}

- (IBAction)sort:(UIButton *)sender {
    
    if (![sender.currentTitle isEqual:@"מיון לפי שנה"]) {
        partialMoviesArray = [[ApplicationManager sharedInstance].movieManager sortBy:@"מיון לפי א״ב" arrayToSort:partialMoviesArray];
        [sender setTitle:@"מיון לפי שנה" forState:UIControlStateNormal];
    }
    else {
        partialMoviesArray = [[ApplicationManager sharedInstance].movieManager sortBy:@"מיון לפי שנה" arrayToSort:partialMoviesArray];
        [sender setTitle:@"מיון לפי א״ב" forState:UIControlStateNormal];
    }
        
    [self.moviesTable reloadData];
}

- (IBAction)showMovieGenre:(UIButton *)sender {

    NSString *category = sender.titleLabel.text;
    
    if ([category isEqual:@"קומדיה"]) {
        category = @"comedy";
    }
    else if ([category isEqual:@"פשע"]) {
        category = @"crime";
    }
    else if ([category isEqual:@"פנטזיה"]) {
        category = @"fantasy";
    }
    else if ([category isEqual:@"אקשן"]) {
        category = @"action";
    }
    else if ([category isEqual:@"דרמה"]) {
        category = @"drama";
    }
    [self sortMoviesByCategory:category];
}

#pragma mark - Searchbar delegate methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
  @try
  {
//    [partialMoviesArray removeAllObjects];
      NSMutableArray *localMovies = [NSMutableArray new];
    NSString *name = @"";
    if ([searchText length] > 0)
    {
        for (int i = 0; i < [partialMoviesArray count] ; i++)
        {
            Movie *movie = partialMoviesArray[i];
            name = movie.name;
            if (name.length >= searchText.length)
            {
                NSRange titleResultsRange = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResultsRange.length > 0)
                {
                    [localMovies addObject:[movie copy]];
                }
            }
        }
    }
    else
    {
        [partialMoviesArray addObjectsFromArray:moviesArray];
    }
      partialMoviesArray = localMovies;
    [self.moviesTable reloadData];
}
@catch (NSException *exception) {
}
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
  searchBar.showsCancelButton=YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
  [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  @try
  {
    searchBar.showsCancelButton=NO;
    [searchBar resignFirstResponder];
    [self.moviesTable reloadData];
  }
  @catch (NSException *exception) {
  }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  [searchBar resignFirstResponder];
}


- (void)setPresentationStyle {
    CATransition *transition = [MoviesManager setPresentationStyle];
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
}

- (IBAction)menuButtonTapped:(id)sender {
    menuController = [[ApplicationManager sharedInstance].movieManager menu];
    
    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self setPresentationStyle];
    [self presentViewController:menuController animated:true completion:nil];

}

- (void)didPressNumber:(long)pressed {
    NSLog(@"pressed %lu", pressed);
    
    if (pressed == 1) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CinemasViewController *cinemasVC = [storyBoard instantiateViewControllerWithIdentifier:@"Cinemas"];
        [[self navigationController] pushViewController:cinemasVC animated:true];
    }

}
@end
