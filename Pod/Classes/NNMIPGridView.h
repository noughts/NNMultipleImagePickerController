//
//  NNMIPGridView.h
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import <UIKit/UIKit.h>
@import Photos;

@interface NNMIPGridView : UICollectionView

/// 選択中のasset配列取得
-(NSArray<PHAsset*>*)selectedAssets;

-(void)scrollToBottom:(NSUInteger)count;

@end
