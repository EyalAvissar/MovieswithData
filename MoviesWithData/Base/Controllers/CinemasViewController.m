//
//  CinemasViewController.m
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import "CinemasViewController.h"
#import "MoviesViewController.h"
#import "MoviesManager.h"
#import "ApplicationManager.h"
#import "Cinema.h"
#import "CinemaTableCell.h"
#import "DetailViewController.h"

@interface CinemasViewController ()

@end

@implementation CinemasViewController
{
    MenuViewController *menuController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.cinemasTable registerNib:[UINib nibWithNibName:@"CinemaTableCell" bundle:nil] forCellReuseIdentifier:[CinemaTableCell identifier]];
}

- (void)viewDidAppear:(BOOL)animated {
//    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithTitle:@"xyz" style:UIBarButtonItemStyleDone target:self action:@selector(xyz)];

    UINavigationBar *navigationBar = [[self navigationController] navigationBar];
//    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
//    [[menu setImage:UIImage] ]
//    [[self navigationItem] setRightBarButtonItem:menu];
//    [[self navigationItem] setRightBarButtonItems:@[menu]];
//    [self.navigationController.navigationItem setRightBarButtonItem:menu];
    
    float height = navigationBar.bounds.size.height;
    float x = navigationBar.bounds.size.width - 50;
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 40, height)];
    blueView.backgroundColor = [UIColor clearColor];
    UIButton *menuButton =  [UIButton systemButtonWithImage:[UIImage imageNamed:@"person"] target:self action:@selector(menuButtonTapped)];
    [menuButton setTitle:@"אפשרויות" forState:UIControlStateNormal];
        
    [blueView addSubview:menuButton];
    
    [navigationBar addSubview:blueView];
    
}




- (void)didPressNumber:(long)pressed {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"pressed %lu", pressed);
    if (pressed == 0) {
        MoviesViewController *moviesVC = [storyBoard instantiateViewControllerWithIdentifier:@"Movies"];
        [[self navigationController] pushViewController:moviesVC animated:true];
    }
}

- (void)didPressMovie:(long)pressed :(NSString *)at {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailViewController *detailController = [storyBoard instantiateViewControllerWithIdentifier:@"detailController"];
    
    detailController.movieId = [NSString stringWithFormat:@"%li", (long)pressed];
    
    detailController.cinemaId = at;
    
    [self.navigationController pushViewController:detailController animated:true];
}

- (void)setPresentationStyle {
    CATransition *transition = [MoviesManager setPresentationStyle];
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
}

-(void)menuButtonTapped {
    menuController = [[ApplicationManager sharedInstance].movieManager menu];

    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [self setPresentationStyle];
    

    [self presentViewController:menuController animated:true completion:nil];
}

#pragma mark- TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell" forIndexPath:indexPath];
    
    cell.dataSource = self;
    
    [cell configureCell:indexPath.row];
    
    return cell;
}

#pragma mark- TableView Delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    CinemaTableCell *cellTapped = [tableView cellForRowAtIndexPath:indexPath];
//    [cellTapped showFullMovieDescription:1];
//
//}

@end
