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
	[self updateTitle];
	
	[UIView animateWithDuration:0 delay:0 options:(7<<16) animations:^{
		_loading_view.alpha = 0;
		_collectionView.alpha = 1;
	} completion:^(BOOL finished) {
		[_loading_view stopAnimating];
	}];
}




#pragma mark - public method

/// 選択中のAsset配列
-(NSArray<PHAsset*>*)selectedAssets{
	return [_collectionView selectedAssets];
}






#pragma mark - ボタン系

-(IBAction)onCancelButtonTap:(id)sender{
	[[UIApplication sharedApplication] sendAction:@selector(onGridCancelButtonTap:) to:nil from:self forEvent:nil];
}

-(IBAction)onDoneButtonTap:(id)sender{
	[[UIApplication sharedApplication] sendAction:@selector(onGridDoneButtonTap:) to:nil from:self forEvent:nil];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self updateTitle];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self updateTitle];
}



#pragma mark - その他

-(void)updateTitle{
	NSUInteger count = [_collectionView indexPathsForSelectedItems].count;
	if( count == 0 ){
		self.navigationItem.title = @"写真を選択";
	} else {
		self.navigationItem.title = [NSString stringWithFormat:@"選択中の写真: %@枚", @(count)];
	}
	
}








@end
