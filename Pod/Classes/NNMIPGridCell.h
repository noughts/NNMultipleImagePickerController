//
//  NNMIPGridCell.h
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import <UIKit/UIKit.h>
@import Photos;

@interface NNMIPGridCell : UICollectionViewCell

-(void)configureWithAsset:(PHAsset*)asset;
-(PHAsset*)asset;

@end
