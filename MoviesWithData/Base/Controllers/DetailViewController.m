//
//  DetailViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import "DetailViewController.h"
#import "FullMovieRequest.h"
#import "MovieImageRequest.h"
#import "ApplicationManager.h"
#import "CinemaCollectionViewCell.h"
#import <CoreData/CoreData.h>
#import "CinemasViewController.h"
#import "MoviesViewController.h"

@interface DetailViewController ()
{
    NSString *moviePosterUrl;
    NSString *currentBaseUrl;
    NSDictionary *moviesDictionary;
    Movie *movie;
    MenuViewController *menuController;
}

@end

@implementation DetailViewController

- (void)setMovieEntity:(NSData *)data {
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl:@"moviesList"];
    UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    [document openWithCompletionHandler:^(BOOL success) {
        
        if (success) {
            if (document.documentState == UIDocumentStateNormal) {
                NSManagedObjectContext *context = document.managedObjectContext;
                NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MovieEntity"];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"movieId == %@", self->movie.movieId];
                
                [request setPredicate:predicate];
                
                NSArray *results = [context executeFetchRequest:request error:nil];
                                
                NSManagedObject* movies = [results objectAtIndex:0];
                
                [movies setValue:self->movie.rating forKey:@"rating"];
                [movies setValue:self->movie.movieDescription forKey:@"movieDescription"];
                [movies setValue:self->movie.promoUrl forKey:@"promoUrl"];
                [movies setValue:data forKey:@"moviePoster"];
                [movies setValue:self->movie.imageUrl forKey:@"imageUrl"];
                
            }
            
        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cinemasCollectionView.dataSource = self;
    [self.cinemasCollectionView registerNib:[UINib nibWithNibName:@"CinemaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[CinemaCollectionViewCell identifier]];
    
    moviesDictionary = [[ApplicationManager sharedInstance] movieManager].moviesDictionary;
    
    movie = moviesDictionary[self.movieId];
    NSLog(@"%@", [movie movieDescription]);
    
    self.nameLabel.text = movie.name;
    self.yearLabel.text = [NSString stringWithFormat:@"year: %@", movie.year];
    self.categoryLabel.text = movie.category;
    
    if (![movie moviePoster]) {
        [self movieDescription];
    }
    else {
        self.movieImageView.image = movie.moviePoster;
        [self partialFieldsSet];
    }
}

-(void)movieDescription {
    FullMovieRequest *fullMoviesRequest = [[FullMovieRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:fullMoviesRequest];
}

- (void)partialFieldsSet {
    self.descriptionTextView.text = movie.movieDescription;
    self.ratingLabel.text = movie.rating;
    [self.promoURL setTitle:movie.promoUrl forState:UIControlStateNormal];
}

- (void)setReceivedMovieFields {
    NSLog(@"");
    
    [self partialFieldsSet];
    
    [[[ApplicationManager sharedInstance] imageRequestManager] imageRequest:movie.imageUrl onCompletion:^(NSData * _Nonnull data) {

        UIImage *posterImage = [UIImage imageWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{
            self->movie.moviePoster = posterImage;
            self.movieImageView.image = posterImage;
            [self setMovieEntity:data];
        });

    }];
}

#pragma mark - ServerRequestDoneProtocol Methods

- (void)serverRequestSucceed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
    
    [self setReceivedMovieFields];
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
    [self setReceivedMovieFields];

}


#pragma mark - IBAActions

- (IBAction)menuButtonTapped:(id)sender {
    menuController = [[ApplicationManager sharedInstance].movieManager menu];
    
    menuController.dataSource = self;
    menuController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [MoviesManager setPresentationStyle];
    
    [self presentViewController:menuController animated:true completion:nil];
    
//    [[self navigationController] pushViewController:menuController animated:true];
}

- (IBAction)showPromo:(UIButton *)sender {
    NSString *urlString = self.promoURL.currentTitle;
    NSURL *promoURL = [NSURL URLWithString: urlString];
    [[UIApplication sharedApplication] openURL:promoURL options:@{} completionHandler:nil];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return movie.cinemasId.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CinemaCollectionViewCell identifier] forIndexPath:indexPath];
    
    NSString *cinemaId = [NSString stringWithFormat:@"%@", [movie cinemasId][indexPath.row]];
    [cell configure: cinemaId];
    
    return cell;
}

- (void)didPressNumber:(long)pressed {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSLog(@"pressed %lu", pressed);
    if (pressed == 0) {
        MoviesViewController *moviesVC = [storyBoard instantiateViewControllerWithIdentifier:@"Movies"];
        [[self navigationController] pushViewController:moviesVC animated:true];
    }
    
    if (pressed == 1) {
        CinemasViewController *cinemasVC = [storyBoard instantiateViewControllerWithIdentifier:@"Cinemas"];
        [[self navigationController] pushViewController:cinemasVC animated:true];
    }
    
//    [menuController dismissViewControllerAnimated:true completion:nil];
    
//    [[[self navigationController].viewControllers objectAtIndex:[[self navigationController].viewControllers count] - 2] dismissViewControllerAnimated:true completion:nil];
    
}

@end
