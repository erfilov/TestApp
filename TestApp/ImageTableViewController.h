//
//  ImageTableViewController.h
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//

@import Photos;
#import <UIKit/UIKit.h>
#import <QBImagePickerController/QBImagePickerController.h>


@interface ImageTableViewController : UITableViewController 
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) NSMutableArray<ALAsset *> *tempAssets;

@end
