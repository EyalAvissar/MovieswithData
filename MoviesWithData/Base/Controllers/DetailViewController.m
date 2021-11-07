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

@interface DetailViewController ()
{
    NSString *moviePosterUrl;
    NSString *currentBaseUrl;
    NSDictionary *moviesDictionary;
    Movie *movie;
}

@end

@implementation DetailViewController

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
    
    [self movieDescription];
    
}

-(void)movieDescription {
    FullMovieRequest *fullMoviesRequest = [[FullMovieRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:fullMoviesRequest];
}


- (void)setReceivedMovieFields {
    NSLog(@"");
    
    self.descriptionTextView.text = movie.movieDescription;
    
    moviePosterUrl = movie.imageUrl;
    
    [self.promoURL setTitle:movie.promoUrl forState:UIControlStateNormal];
    
    [[[ApplicationManager sharedInstance] imageRequestManger] imageRequest:moviePosterUrl onCompletion:^(NSData * _Nonnull data) {
        
        UIImage *posterImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *rating = [self->movie.rating description];
            self.ratingLabel.text = rating;
            self->movie.moviePoster = posterImage;
            self.movieImageView.image = posterImage;
        });
    }];
    
    
}

#pragma mark - ServerRequestDoneProtocol Methods

- (void)serverRequestSucceed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
    [self setReceivedMovieFields];
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
    
}

#pragma mark - IBAActions

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

@end
