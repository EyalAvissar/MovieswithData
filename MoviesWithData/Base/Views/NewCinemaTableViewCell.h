//
//  TestTableViewCell.h
//  MoviesWithData
//
//  Created by inmanage on 21/11/2021.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCinemaTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

+(NSString *)identifier;

@property (weak, nonatomic) IBOutlet UICollectionView *localCollectionView;

@property id<MenuProtocol> dataSource;

@property NSString *tableRow;

-(void)updateData;

@end

NS_ASSUME_NONNULL_END
