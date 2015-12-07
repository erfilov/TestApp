//
//  ImagePickerViewController.m
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//

#import "ImageTableViewController.h"
#import "ImagePickerViewController.h"



@interface ImagePickerViewController () <QBImagePickerControllerDelegate>
@property (strong, nonatomic) ImageTableViewController *tableView;
@property (strong, nonatomic) QBImagePickerController *pickerController;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) PHImageManager *imageManager;
@property (assign, nonatomic) BOOL newChoice;


- (IBAction)selectImageAction:(UIButton *)sender;
@end

@implementation ImagePickerViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.navigationItem.title = @"Choose images";
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show Table"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(showTableAction:)];
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    self.pickerController = [QBImagePickerController new];
    self.pickerController.delegate = self;
    self.pickerController.allowsMultipleSelection = YES;
    self.pickerController.minimumNumberOfSelection = 1;
    self.pickerController.maximumNumberOfSelection = 3;
    self.pickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    self.pickerController.showsNumberOfSelectedAssets = YES;
    self.tableView = [ImageTableViewController new];
    self.tableView.tempAssets = [NSMutableArray new];
    self.tableView.assets = [NSMutableArray new];
    self.newChoice = NO;
    
    
   
}


#pragma mark - Actions


- (IBAction)selectImageAction:(UIButton *)sender {
    if (self.newChoice) {
        self.pickerController = [QBImagePickerController new];
        self.pickerController.delegate = self;
        self.pickerController.allowsMultipleSelection = YES;
        self.pickerController.minimumNumberOfSelection = 1;
        self.pickerController.maximumNumberOfSelection = 3;
        self.pickerController.filterType = QBImagePickerControllerFilterTypePhotos;
        self.pickerController.showsNumberOfSelectedAssets = YES;
        
    }
    [self presentViewController:self.pickerController animated:YES completion:nil];
    
}

- (void)showTableAction:(UIBarButtonItem *)sender {
    if (self.images != nil) {
        self.tableView.tempAssets = self.images;
    }
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"showTable"
                                                               source:self
                                                          destination:self.tableView
                                                       performHandler:^{}];

    self.tableView = segue.destinationViewController;
    [segue perform];
    [self performSegueWithIdentifier:@"showTable" sender:self.tableView];
}


#pragma mark - QBImagePickerControllerDelegate


- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.newChoice = YES;
    [self.tableView.tempAssets addObjectsFromArray:assets];
    [self.tableView.tempAssets addObjectsFromArray:self.images];
    
    UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@"showTable"
                                                                source:self
                                                           destination:self.tableView
                                                        performHandler:^{}];
    
    self.tableView = segue.destinationViewController;
    [segue perform];
    [self performSegueWithIdentifier:@"showTable" sender:self.tableView];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ImageTableViewController *imageTableViewController = segue.destinationViewController;
    self.tableView = sender;
    imageTableViewController.tempAssets = self.tableView.tempAssets;
}





@end
