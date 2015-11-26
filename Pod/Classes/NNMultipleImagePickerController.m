//
//  NNMultipleImagePickerController.m
//  Pods
//
//  Created by noughts on 2015/11/26.
//
//

#import "NNMultipleImagePickerController.h"
#import "NNPodUtils.h"

@implementation NNMultipleImagePickerController

+(instancetype)instantiate{
	NNPodUtils* utils = [[NNPodUtils alloc] initWithPodName:@"NNMultipleImagePickerController"];
	return [utils.storyboard instantiateInitialViewController];
}


@end
