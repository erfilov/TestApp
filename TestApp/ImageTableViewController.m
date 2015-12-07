//
//  ImageTableViewController.m
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//


#import "ImageTableViewController.h"
#import "ImageTableViewCell.h"
#import "ImagePickerViewController.h"

@interface ImageTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIImage *tempImage;
@property (strong, nonatomic) ImagePickerViewController *pickerViewController;

@end

@implementation ImageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerViewController = [ImagePickerViewController new];
    self.pickerViewController.assets = [NSArray new];
    self.pickerViewController.images = [NSMutableArray new];
    self.assets = self.tempAssets;
    self.tableView.editing = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose images"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.tableView.allowsSelection = NO;
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.assets count];
}
 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    PHImageManager *manager = [PHImageManager defaultManager];
    if (cell.tag) {
        [manager cancelImageRequest:(PHImageRequestID)cell.tag];
    }
    ALAsset *asset = self.assets[indexPath.row];
    PHAsset *ass = [self ALAssetToPHAsset:asset];
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    cell.tag = [manager requestImageForAsset:ass
                                  targetSize:CGSizeMake(200, 200)
                                 contentMode:PHImageContentModeAspectFill
                                     options:nil
                               resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                   cell.imgView.image = result;
                                   cell.label.text = [NSString stringWithFormat:@"Image #%ld", indexPath.row + 1];
                                   cell.smallLabel.text = [NSString stringWithFormat:@"(%.f x %.f)", cell.imageView.image.size.width, cell.imageView.image.size.height];
                               }];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PHAsset *obj = [self.assets objectAtIndex:indexPath.row];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.assets];
        [tempArray removeObject:obj];
        self.assets = tempArray;
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        [self.tableView reloadData];
        
    }
}



#pragma mark - Methods
- (PHAsset *)ALAssetToPHAsset:(ALAsset *)asset {
    NSURL *url = [asset valueForProperty:ALAssetPropertyAssetURL];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
    PHAsset *obj = [fetchResult firstObject];
    return obj;
}


#pragma mark - Actions

- (void)actionEdit:(UIBarButtonItem *)sender {
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:YES];
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;

    if (self.tableView.editing) {
        item = UIBarButtonSystemItemDone;
        
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(actionEdit:)];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    });
    
    [self.tableView reloadData];
}


 
- (void)actionBack:(UIBarButtonItem *)sender {
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"chooseImages"
                                                               source:self
                                                          destination:self.pickerViewController
                                                       performHandler:^{}];
    
    self.pickerViewController.images = self.assets;
    self.pickerViewController = segue.destinationViewController;
    [segue perform];
    [self performSegueWithIdentifier:@"chooseImages" sender:self.pickerViewController];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ImagePickerViewController *pickerViewController = segue.destinationViewController;
    self.pickerViewController = sender;
    pickerViewController.images = self.pickerViewController.images;
    
    
    
}


@end
