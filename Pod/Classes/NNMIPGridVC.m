//
//  NNMIPGridVC.m
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import "NNMIPGridVC.h"
@import Photos;
#import "NNMIPGridCell.h"
#import "NNMIPGridView.h"


@implementation NNMIPGridVC{
	__weak IBOutlet NNMIPGridView* _collectionView;
	__weak IBOutlet UIActivityIndicatorView* _loading_view;
	NSMutableArray<PHAsset*>* _phAssets;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	
	__weak typeof(self) _self = self;
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[_self fetchAssetsForIOS8];
		}];
	}];
}


-(void)fetchAssetsForIOS8{
	_phAssets = [NSMutableArray new];
	/// 写真のみ取得するオプションを定義
	PHFetchOptions *options = [[PHFetchOptions alloc] init];
	options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
	NSOperationQueue* queue = [NSOperationQueue new];
	[queue addOperationWithBlock:^{
		PHFetchResult* assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
		[assetCollections enumerateObjectsUsingBlock:^(PHAssetCollection* assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
			PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
			[assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
				[_phAssets addObject:asset];
			}];
		}];
		NSLog(@"ok count=%@", @(_phAssets.count));
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self onFetchAsetsComplte];
		}];
	}];
}

-(void)onFetchAsetsComplte{
	[_collectionView reloadData];
	
	[UIView animateWithDuration:0 delay:0 options:(7<<16) animations:^{
		_loading_view.alpha = 0;
		_collectionView.alpha = 1;
	} completion:^(BOOL finished) {
		[_loading_view stopAnimating];
	}];
}

















#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _phAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	PHAsset* asset = _phAssets[indexPath.row];
	
    NNMIPGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	[cell configureWithAsset:asset];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
