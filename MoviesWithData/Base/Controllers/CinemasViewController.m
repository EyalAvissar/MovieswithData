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

@interface CinemasViewController ()

@end

@implementation CinemasViewController
{
    MenuViewController *menuController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 80)];
//
//    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"Back"];

//    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTapped)];
//
//    [[self navigationItem] setRightBarButtonItem:menu];
//    navItem.rightBarButtonItem = menu;

//    [navbar setItems:@[navItem]];
//    [self.view addSubview:navbar];
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

@end
