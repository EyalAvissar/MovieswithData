//
//  TestTableViewCell.m
//  MoviesWithData
//
//  Created by inmanage on 21/11/2021.
//

#import "NewCinemaTableViewCell.h"
#import "NewCinemaViewCell.h"
#import "Cinema.h"
#import "Movie.h"
#import "ApplicationManager.h"
#import "DetailViewController.h"

@implementation NewCinemaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.localCollectionView registerNib:[UINib nibWithNibName:@"TestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[NewCinemaViewCell identifier]];
    
    self.localCollectionView.delegate = self;
    self.localCollectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsZero];
    [self.localCollectionView setCollectionViewLayout:flowLayout animated:false completion:nil];
}

+ (NSString *)identifier {
    return @"TestTableCell";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewCinemaViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NewCinemaViewCell identifier] forIndexPath:indexPath];

    Cinema *cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:self.tableRow];
    
    NSString *movieId = cinema.movieIdArray[indexPath.row];
    
    Movie *movie = [[[ApplicationManager sharedInstance].movieManager moviesDictionary] objectForKey:movieId];
//
    cell.label.text = movie.name;
    
    return cell;
}

-(void)updateData {
    [self.localCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"collectionView numberOfItemsInSection tableRow: %@", self.tableRow);
    
    Cinema *cinema = [[[ApplicationManager sharedInstance].movieManager cinemasDictionary] objectForKey:self.tableRow];
    
    return [cinema.movieIdArray count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cell in row %@, number %lu",self.tableRow ,indexPath.row);
    
    [self.dataSource didPressMovie:indexPath.row :self.tableRow];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(self.contentView.frame.size.width / 3, self.contentView.bounds.size.height);
}

@end
