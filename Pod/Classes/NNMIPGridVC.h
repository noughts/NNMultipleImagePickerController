//
//  NNMIPGridVC.h
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import <UIKit/UIKit.h>
@import Photos;

@interface NNMIPGridVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

/// 選択中のAsset配列
-(NSArray<PHAsset*>*)selectedAssets;

@end
