//
//  BannerViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 27/10/2021.
//

#import "BannerViewController.h"
#import "ApplicationManager.h"

@interface BannerViewController ()
{
    NSTimer *bannerTimer;
}
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *bannerUrlStr = [[ApplicationManager sharedInstance].appGD bannerImageUrl];
    
    [[[ApplicationManager sharedInstance] imageRequestManager] imageRequest:bannerUrlStr onCompletion:^(NSData * _Nonnull data) {
        
        UIImage *bannerImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bannerImageView.image = bannerImage;
        });
    }];
    
    bannerTimer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:false block:^(NSTimer * _Nonnull timer) {
        [self presentMovies];
    }];
}


- (void)presentMovies {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigator = [storyboard instantiateViewControllerWithIdentifier:@"navigator"];
    
    [navigator setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:navigator animated:true completion:nil];
}

- (IBAction)skipBanner:(id)sender {
    if (bannerTimer) {
        [bannerTimer invalidate];
        NSLog(@"timer invalidated");
    }
    
    [self presentMovies];
}

@end
