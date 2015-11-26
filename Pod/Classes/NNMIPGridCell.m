//
//  NNMIPGridCell.m
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import "NNMIPGridCell.h"
@import Photos;
#import <UIScreen+NNUtils.h>

@implementation NNMIPGridCell{
	__weak IBOutlet UIView* _selected_view;
	__weak IBOutlet UIImageView* _check_iv;
	PHAsset* _asset;
}


-(void)awakeFromNib{
	[super awakeFromNib];
	self.layer.contentsGravity = @"resizeAspectFill";
	_check_iv.hidden = YES;
	_selected_view.hidden = YES;
}


-(void)setSelected:(BOOL)selected{
	[super setSelected:selected];
	_check_iv.hidden = !selected;
	_selected_view.hidden = !selected;
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
	NSInteger size = [UIScreen mainScreen].pixelWidth / 4;
	[[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(size,size) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
		self.layer.contents = (__bridge id _Nullable)(result.CGImage);
	}];
}

@end
