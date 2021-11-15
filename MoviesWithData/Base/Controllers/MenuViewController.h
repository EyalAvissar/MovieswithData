//
//  MenuViewController.h
//  MoviesWithData
//
//  Created by inmanage on 15/11/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN



@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property id<MenuProtocol> dataSource;

@end

NS_ASSUME_NONNULL_END
