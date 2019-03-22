//
//  LoginController.h
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginControllerDelegate.h"
#import "FieldWorkAccount.h"
#import "AccountManager.h"
#import "AccountAuthenticateDelegate.h"
#import "ActivityIndicator.h"
#import "CustomTableCell.h"
#import "LoginCell.h"
#import "BaseViewController.h"
#import "Customer/NewCustomerViewController.h"
#import "UIFloatLabelTextField.h"

@interface LoginController : BaseViewController < AccountAuthenticateDelegate,UITableViewDelegate,UITextFieldDelegate>
{

    NSString *uname;
    NSString *password;
    id<LoginControllerDelegate> _delegate;
    IBOutlet UIButton * _Loginbtn;
    BOOL isColored;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain)IBOutlet UILabel *borderEmail;
@property (nonatomic, retain)IBOutlet UILabel *borderPass;
@property (nonatomic, retain)IBOutlet UIFloatLabelTextField *txtEmail;
@property (nonatomic, retain)IBOutlet UIFloatLabelTextField *txtPass;
@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic, retain, readwrite) id<LoginControllerDelegate> delegate;
@property (nonatomic, retain, readwrite) NSString *username;

+ (LoginController*) loginViewControllerWithUsername:(NSString*) username;

- (IBAction)login:(id)sender;


@end


    //armv7 armv7s
