//
//  StartViewController.m
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//

#import "StartViewController.h"
#import "ImagePickerViewController.h"

@interface StartViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)enterAction:(id)sender;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.login = [Login new];
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    
}


- (IBAction)enterAction:(id)sender {
    
    if ([self.loginTextField.text isEqualToString:self.login.login] && [self.passwordTextField.text isEqualToString:self.login.password]) {
        [self performSegueWithIdentifier:@"enter" sender:sender];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Incorrect login or password. Please try again."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}








- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1 ) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
    
}

@end
