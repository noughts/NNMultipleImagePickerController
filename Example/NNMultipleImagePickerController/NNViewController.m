//
//  NNViewController.m
//  NNMultipleImagePickerController
//
//  Created by Koichi Yamamoto on 11/26/2015.
//  Copyright (c) 2015 Koichi Yamamoto. All rights reserved.
//

#import "NNViewController.h"
#import <NNMultipleImagePickerController.h>

@implementation NNViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	

}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self onButtonTap:nil];
}

-(IBAction)onButtonTap:(id)sender{
	NNMultipleImagePickerController* ipc = [NNMultipleImagePickerController instantiate];
	[self presentViewController:ipc animated:YES completion:nil];
}
@end
