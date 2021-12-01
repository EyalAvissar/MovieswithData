//
//  TestViewController.m
//  MoviesWithData
//
//  Created by inmanage on 21/11/2021.
//

#import "NewCinemaViewController.h"
#import "NewCinemaTableViewCell.h"
#import "ApplicationManager.h"
#import "Cinema.h"
#import "MoviesViewController.h"
#import "DetailViewController.h"

@interface NewCinemaViewController ()
{
    Cinema *cinema;
}
@end

@implementation NewCinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.localTableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:[NewCinemaTableViewCell identifier]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewCinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewCinemaTableViewCell identifier] forIndexPath:indexPath];
    
    if (cell) {
        self.tableRow = [NSString stringWithFormat:@"%li", indexPath.section + 1];
        cell.tableRow = self.tableRow;
        [cell updateData];
    }
    else {
        cell.tableRow = self.tableRow;
    }

    cell.dataSource = self;

    NSLog(@"tableView cellForRowAtIndexPath tableRow: %@", self.tableRow);
    
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
//    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithTitle:@"xyz" style:UIBarButtonItemStyleDone target:self action:@selector(xyz)];

    UINavigationBar *navigationBar = [[self navigationController] navigationBar];
    
    float height = navigationBar.bounds.size.height;
    float x = navigationBar.bounds.size.width - 50;
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 40, height)];

    UIButton *menuButton =  [UIButton systemButtonWithImage:[UIImage imageNamed:@"person"] target:self action:@selector(menuButtonTapped)];
    [menuButton setTitle:@"אפשרויות" forState:UIControlStateNormal];
        
    [blueView addSubview:menuButton];
    
    [navigationBar addSubview:blueView];
    
}

-(void)menuButtonTapped {
    MenuViewController *menuController;

    menuController = [[ApplicationManager sharedInstance].movieManager menu];

    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

//    [self setPresentationStyle];
    [self presentViewController:menuController animated:true completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    self.tableRow =  [NSString stringWithFormat:@"%ld", (long)(section + 1)];
        
    cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:self.tableRow];
    
    return cinema.name;

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
        
    Cinema *cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:at];
    detailController.movieId = cinema.movieIdArray[pressed];
    detailController.cinemaId = at;
    
    [self.navigationController pushViewController:detailController animated:true];
}


@end
