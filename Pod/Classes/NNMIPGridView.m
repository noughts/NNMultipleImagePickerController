//
//  PhotosGridView.m
//  Picsee2.5Sketch
//
//  Created by noughts on 2015/08/03.
//  Copyright (c) 2015年 dividual. All rights reserved.
//

#import "NNMIPGridView.h"
@import Photos;
@import AssetsLibrary;
#import "NNMIPGridCell.h"


@implementation NNMIPGridView{
	ALAssetsLibrary* _lib;
}



-(void)awakeFromNib{
	[super awakeFromNib];
	
	self.allowsMultipleSelection = YES;
	
	/// セルサイズを決定
	UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
	CGFloat length = ([UIScreen mainScreen].bounds.size.width-3) / 4.0;
	layout.itemSize = CGSizeMake(length, length);
}



#pragma mark - public method

/// セルを選択
-(void)selectCell:(NNMIPGridCell*)cell{
	NSIndexPath* indexPath = [self indexPathForCell:cell];
	[self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


/// 選択中のasset配列取得
-(NSArray<PHAsset*>*)selectedAssets{
	NSMutableSet<PHAsset*>* set = [NSMutableSet new];
	for (NNMIPGridCell* cell in [self selectedCells]) {
		[set addObject:[cell asset]];
	}
	return [set allObjects];
}




/// 選択中のセル配列
-(NSArray*)selectedCells{
	NSArray* ips = [self indexPathsForSelectedItems];
	NSMutableArray* cells = [NSMutableArray new];
	for (NSIndexPath* indexPath in ips) {
		NNMIPGridCell* cell = (NNMIPGridCell*)[self cellForItemAtIndexPath:indexPath];
		if( !cell ){
			cell = (NNMIPGridCell*)[self.dataSource collectionView:self cellForItemAtIndexPath:indexPath];// 表示範囲内にセルがない場合は作成
		}
		[cells addObject:cell];
	}
	return [NSArray arrayWithArray:cells];
}



/// セルセットしたgestureRecognizer.viewからは正確にターゲットcellを取得できないので、座標から取得
-(NNMIPGridCell*)cellForGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer{
	CGPoint p = [gestureRecognizer locationInView:self];
	NSIndexPath *indexPath = [self indexPathForItemAtPoint:p];
	return (NNMIPGridCell*)[self cellForItemAtIndexPath:indexPath];
}







#pragma mark - その他

-(BOOL)checkSelected:(NNMIPGridCell*)cell{
	NSIndexPath* indexPath = [self indexPathForCell:cell];
	return [[self indexPathsForSelectedItems] containsObject:indexPath];
}





@end
