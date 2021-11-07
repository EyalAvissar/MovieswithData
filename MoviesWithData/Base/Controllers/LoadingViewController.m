//
//  LoadingViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "LoadingViewController.h"
#import "ApplicationManager.h"
#import "BannerViewController.h"
#import "Constants.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
{
    int numOfFinishedCalls;
    int progressDelta;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    progressDelta = 100 / originalNumOfCalls;
    numOfFinishedCalls = 1;
    
    self.view.backgroundColor = [UIColor greenColor];
    [[ApplicationManager sharedInstance].startUpManager start];
    
}

- (void)updateLoaderWithMethodName:(NSString*)strMethodName {
    
    [self isVersionValid];
    numOfFinishedCalls++;
    
    self.percentDone += progressDelta;
    self.percentLabel.text = [NSString stringWithFormat:@"%i%%",(numOfFinishedCalls * progressDelta) ];
    
    if (self.percentDone >= 99.0) {
        self.percentLabel.text = @"98%";
    }

    self.callsProgressBar.progress = self.percentDone / 100.0;
}




#pragma mark - ServerRequestDoneProtocol

- (void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest {
    
    [self updateLoaderWithMethodName:baseRequest.getMethodName];
    
    if (numOfFinishedCalls == originalNumOfCalls) {
        [self loadBannerView];
    }
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
}

-(void)loadBannerView {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BannerViewController *bannerController = [storyBoard instantiateViewControllerWithIdentifier:@"banneView"];

    [bannerController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:bannerController animated:true completion:nil];
}

- (BOOL) isVersionValid {
    if (![ApplicationManager sharedInstance].startUpManager.isValidVersion) {
        
        NSString *alertTitle = @"Your app version  is not up to date";
        
        NSString *alertMessage = @"Please update your app in appStore";
        
        UIAlertController *invalidVersion = [UIAlertController alertControllerWithTitle: alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [invalidVersion addAction:cancel];
        [self presentViewController:invalidVersion animated:true completion:nil];
        
        return false;
    }
    return true;
}

@end
