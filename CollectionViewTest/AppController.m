//
//  AppController.m
//  Pinto
//
//  Created by Alejandro Padovan on 16/05/14.
//  Copyright (c) 2014 Mimay Inc. All rights reserved.
//

#import "AppController.h"
#import "ImageCell.h"
#import "NHLinearPartition.h"
#import "UIImage+Decompression.h"
#import "NHBalancedFlowLayout.h"

#define kTagCellIdentifier @"ImageCell"

#define NUMBER_OF_IMAGES 24

@interface AppController() <NHBalancedFlowLayoutDelegate>
@property (nonatomic, strong) NSArray *images;
@end

@implementation AppController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 1; i <= NUMBER_OF_IMAGES; i++) {
            NSString *imageName = [NSString stringWithFormat:@"photo-%02d.jpg", i];
            [images addObject:[UIImage imageNamed:imageName]];
        }
        _images = [images copy];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NHBalancedFlowLayout *layout = (NHBalancedFlowLayout *)self.collectionViewLayout;
//    layout.headerReferenceSize = CGSizeMake(HEADER_SIZE, HEADER_SIZE);
//    layout.footerReferenceSize = CGSizeMake(FOOTER_SIZE, FOOTER_SIZE);
    
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"ImageCell"];
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(NHBalancedFlowLayout *)collectionViewLayout preferredSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.images objectAtIndex:indexPath.item] size];
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image = nil;
    
    /**
     * Decompress image on background thread before displaying it to prevent lag
     */
    NSInteger rowIndex = indexPath.row;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [UIImage decodedImageWithImage:[self.images objectAtIndex:indexPath.item]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *currentIndexPathForCell = [collectionView indexPathForCell:cell];
            if (currentIndexPathForCell.row == rowIndex) {
                cell.imageView.image = image;
            }
        });
    });
    
    return cell;
}

@end