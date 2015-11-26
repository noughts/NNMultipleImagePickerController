//
//  NNMultipleImagePickerController.m
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import "NNMultipleImagePickerController.h"
#import "NNPodUtils.h"
#import "NNMIPGridVC.h"
#import "NBULogStub.h"

@implementation NNMultipleImagePickerController

+(instancetype)instantiate{
	NNPodUtils* utils = [[NNPodUtils alloc] initWithPodName:@"NNMultipleImagePickerController"];
	return [utils.storyboard instantiateInitialViewController];
}


-(void)onGridCancelButtonTap:(id)sender{
	[_pickerDelegate imagePickerControllerDidCancel:self];
}

-(void)onGridDoneButtonTap:(NNMIPGridVC*)gridVC{
	[_pickerDelegate imagePickerController:self didFinishPickingAssets:[gridVC selectedAssets]];
}

@end








