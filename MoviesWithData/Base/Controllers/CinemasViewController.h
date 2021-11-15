//
//  CinemasViewController.h
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CinemasViewController : UIViewController <MenuProtocol>

@property (weak, nonatomic) IBOutlet UITableView *cinemasTble;

@end

NS_ASSUME_NONNULL_END
