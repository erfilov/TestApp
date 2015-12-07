//
//  ImagePickerViewController.h
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//

@import Photos;

#import <UIKit/UIKit.h>
#import <QBImagePickerController/QBImagePickerController.h>



@interface ImagePickerViewController : UIViewController 
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSArray<ALAsset *> *assets;

@end
