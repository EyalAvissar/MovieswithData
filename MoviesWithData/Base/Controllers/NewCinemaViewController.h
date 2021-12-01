//
//  TestViewController.h
//  MoviesWithData
//
//  Created by inmanage on 21/11/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCinemaViewController : UIViewController <MenuProtocol, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *localTableView;

@property NSString *tableRow;

@end

NS_ASSUME_NONNULL_END
