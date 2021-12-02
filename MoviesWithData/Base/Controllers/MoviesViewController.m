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
#import "NewCinemaViewController.h"
#import "MapController.h"


static NSString *identifier;
static NSString *popupIdentifier;

@interface MoviesViewController ()
{
    NSArray *moviesArray;
    NSMutableArray *partialMoviesArray;
    MenuViewController *menuController;
    UITableView *popupView;
    NSArray *optionsArray;
    Movie *selectedMovie;
    int rows;
    bool isByCategory;
}
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movieSearchBar.delegate = self;
    moviesArray = [[ApplicationManager sharedInstance].movieManager moviesArray];
    partialMoviesArray = [NSMutableArray arrayWithArray:moviesArray];
    identifier = @"movieCell";
    popupIdentifier = @"Cell";
    [self.moviesTable registerNib:[UINib nibWithNibName:@"MovieTableCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    optionsArray = @[@"תיאור", @"בתי קולנוע"];
    rows = 8;
}

#pragma mark - tableView datasource methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (tableView == popupView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:popupIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popupIdentifier];
        }
        
        cell.textLabel.text = optionsArray[indexPath.row];
        cell.textLabel.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    else {
        MovieTableCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        Movie *movie = partialMoviesArray[indexPath.row];
        [cell configureCell:movie];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == popupView) {
        return optionsArray.count;
    }
    return partialMoviesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == popupView) {
        return popupView.bounds.size.height / 2;
    }
    else {
        return self.view.bounds.size.height / rows;
    }
}

#pragma mark - tableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (tableView == popupView) {
        if (indexPath.row == 0) {
            NSLog(@"%lu", indexPath.row);
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
            
            detailController.movieId = selectedMovie.movieId;
            
            [self.navigationController pushViewController:detailController animated:true];
            
        }
        else {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            MapController *mapController = [storyBoard instantiateViewControllerWithIdentifier:@"Map"];
            
            mapController.locations = selectedMovie.cinemasId;
            mapController.movie = selectedMovie;
            
            [self.navigationController pushViewController:mapController animated:true];
        }
        
        [popupView setHidden:true];
        [popupView removeFromSuperview];
    }
    
    else {
        MovieTableCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        selectedMovie = partialMoviesArray[indexPath.row];
        [self showPopup:indexPath.row];
    }
}


#pragma mark - Sort Movies Methods

-(void)sortMoviesByCategory:(NSString *) category {
    partialMoviesArray = [[ApplicationManager sharedInstance].movieManager sortMoviesByCategory:category];
    [self.moviesTable reloadData];
}

- (IBAction)showAll:(UIButton *)sender {
    isByCategory = false;
    partialMoviesArray = [NSMutableArray arrayWithArray:moviesArray];
    [self.moviesTable reloadData];
}

- (IBAction)sort:(UIButton *)sender {
    isByCategory = false;
    
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
    
    isByCategory = true;
    
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
    Boolean didCallShowAll;
    @try
    {
        NSMutableArray *searchArray = (isByCategory) ? [NSMutableArray arrayWithArray:partialMoviesArray] : [NSMutableArray arrayWithArray:moviesArray];
        
        if (!searchArray.count) {
            searchArray = [NSMutableArray arrayWithArray:moviesArray];
            isByCategory = false;
        }
        
        NSMutableArray *localMovies = [NSMutableArray new];
        
        NSString *name = @"";
        if ([searchText length] > 0)
        {
            for (int i = 0; i < [searchArray count] ; i++)
            {
                Movie *movie = searchArray[i];
                name = movie.name;
                if (name.length >= searchText.length)
                {
                    NSRange titleResultsRange = [name rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    
                    if ([searchText length] == 0) {
                        localMovies = nil;
                        [localMovies arrayByAddingObjectsFromArray:searchArray];
                        break;
                    }
                    
                    if (titleResultsRange.length > 0)
                    {
                        [localMovies addObject:[movie copy]];
                    }
                }
            }
        }
        else
        {
            partialMoviesArray = [NSMutableArray arrayWithArray:moviesArray];
            [self showAll:nil];
            didCallShowAll = true;
        }
        
        if (!didCallShowAll) {
            partialMoviesArray = localMovies;
            [self.moviesTable reloadData];
        }
        
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

#pragma mark- Menu Methods

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
        NewCinemaViewController *testVC = [storyBoard instantiateViewControllerWithIdentifier:@"Cinemas"];
        [[self navigationController] pushViewController:testVC animated:true];
    }
    
}

#pragma mark - Popup method

- (void)showPopup:(float)y {
    float width = 200;
    float height = 200;
    
    float x = 20;
    y = self.view.bounds.size.height / rows * y;
    
    if ((y + height) > self.view.bounds.size.height - 50) {
        y = y - height - 45;
    }
    
    if (popupView) {
        [popupView removeFromSuperview];
    }
    
    popupView = [[UITableView alloc] initWithFrame: CGRectMake(x, y, width, height)];
    [popupView registerClass:[UITableViewCell class] forCellReuseIdentifier: popupIdentifier];
    popupView.delegate = self;
    popupView.dataSource = self;
    
    [self.moviesTable addSubview:popupView];
    
}
@end
