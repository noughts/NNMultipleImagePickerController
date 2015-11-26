//
//  NNMIPGridCell.m
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import "NNMIPGridCell.h"
@import Photos;
#import "UIScreen+NNUtils.h"
#import "NBULogStub.h"

@implementation NNMIPGridCell{
	__weak IBOutlet UIImageView* _thumb_iv;
	__weak IBOutlet UIImageView* _check_iv;
	PHAsset* _asset;
}


-(void)awakeFromNib{
	[super awakeFromNib];
	self.layer.contentsGravity = @"resizeAspectFill";
	_check_iv.hidden = YES;
}


-(void)setSelected:(BOOL)selected{
	[super setSelected:selected];
	_check_iv.hidden = !selected;
	if( selected ){
		_thumb_iv.alpha = 0.8;
	} else {
		_thumb_iv.alpha = 1;
	}
}

-(void)setHighlighted:(BOOL)highlighted{
	[super setHighlighted:highlighted];
	if( highlighted ){
		self.alpha = 0.5;
	} else {
		self.alpha = 1;
	}
}





-(PHAsset*)asset{
	return _asset;
}


-(void)configureWithAsset:(PHAsset*)asset{
	_asset = asset;
	NSInteger size = [UIScreen mainScreen].nativeBounds.size.width / 8;
	[[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(size,size) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
		_thumb_iv.image = result;
	}];
}

@end
