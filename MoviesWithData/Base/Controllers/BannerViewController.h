//
//  BannerViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 27/10/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

- (IBAction)skipBanner:(id)sender;


@end

NS_ASSUME_NONNULL_END
