//
//  NNMultipleImagePickerController.h
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import <UIKit/UIKit.h>
@protocol NNMultipleImagePickerControllerDelegate;


@interface NNMultipleImagePickerController : UINavigationController

/// storyboardを使った初期化
+(instancetype)instantiate;
@property(nonatomic,weak)id <NNMultipleImagePickerControllerDelegate> pickerDelegate;

@end









#pragma mark - delegate定義

@protocol NNMultipleImagePickerControllerDelegate<NSObject>

-(void)imagePickerController:(NNMultipleImagePickerController*)picker didFinishPickingAssets:(NSArray*)photos;
-(void)imagePickerControllerDidCancel:(NNMultipleImagePickerController*)picker;
@end



