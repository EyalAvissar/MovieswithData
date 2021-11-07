//
//  LoadingViewController.h
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import <UIKit/UIKit.h>
#import "IMAbstractViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadingViewController : IMAbstractViewController

@property (strong, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *callsProgressBar;


@property (assign, nonatomic) int percentDone;

@end

NS_ASSUME_NONNULL_END
