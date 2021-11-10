//
//  DetailViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "ServerRequestDoneProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController <ServerRequestDoneProtocol, UICollectionViewDataSource>

@property NSString *movieId;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIButton *promoURL;

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *cinemasCollectionView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
- (IBAction)showPromo:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
