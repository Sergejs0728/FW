    //
    //  LoginController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 05/01/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "LoginController.h"

@implementation LoginController
@synthesize delegate = _delegate;
@synthesize txtEmail = _txtEmail;
@synthesize txtPass = _txtPass;
@synthesize borderEmail = _borderEmail;
@synthesize borderPass = _borderPass;
@synthesize tapRecognizer;
@synthesize viewLogin;


+ (LoginController *)loginViewControllerWithUsername:(NSString *)username {
    LoginController *login;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        login = [[LoginController alloc] initWithNibName:@"LoginController_IPad" bundle:nil];
//    }else{
//        
        login = [[LoginController alloc] initWithNibName:@"NewLoginViewController" bundle:nil];
//    }
    login.username = username;
    return login;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setPlaceholderColor];
    if (![[ActivityIndicator currentIndicator] ishidden]) {
        [[ActivityIndicator currentIndicator] displayCompleted];

    }

    self.navigationController.navigationBarHidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

   // [self.view setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
        // Release any cached data, images, etc that aren't in use.
}

-(void)setPlaceholderColor{
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.txtPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.txtEmail.floatLabelActiveColor =  [UIColor whiteColor];
    self.txtPass.floatLabelActiveColor = [UIColor whiteColor];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    if(textField.text.length==0){
//        [self setPlaceholderColor];
//    }
//    
//    if(textField == self.txtEmail){
//        [self.txtPass becomeFirstResponder];
//    }else{
//        [textField resignFirstResponder];
//    }
    [textField resignFirstResponder];
        return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.txtEmail.isFirstResponder && !isColored) {
        self.borderEmail.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:76.0/256.0 blue:58.0/256.0 alpha:1.0];
        self.borderPass.backgroundColor =  [UIColor whiteColor];
    }else{
        self.borderPass.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:76.0/256.0 blue:58.0/256.0 alpha:1.0];
        self.borderEmail.backgroundColor = [UIColor whiteColor];
    }
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.txtEmail.text = self.username;
//             _txtEmail.text =@"samcom.technobrains@gmail.com";
//              _txtPass.text =@"password";
//    _txtEmail.text =@"sconner@connerpestmanagement.com";
//    _txtPass.text =@"Scott";
//    _txtEmail.text =@"mihail.mihailichenko@gmail.com";
//    _txtPass.text =@"pest321";
//    _txtEmail.text =@"beau@anstarproducts.com";
//    _txtPass.text =@"pest321";
//        _txtEmail.text =@"douglas.boots@thebugmaster.com";
//        _txtPass.text =@"thebugmaster";
//    _txtEmail.text = @"akotenko@modernsoftware.org";
//    _txtPass.text = @"8XVhtaIB";
//        _txtEmail.text = @"rodahnbailey@gmail.com";
//        _txtPass.text = @"pest";
//    _txtEmail.text =@"devonee@bugsbg.com";
//    _txtPass.text =@"Smacker28";
//        _txtEmail.text =@"adam@anstarproducts.com";
//        _txtPass.text =@"adam";
//          _txtEmail.text = @"chris@bigfootpestcontrol.com";
//           _txtPass.text = @"pest";
//    _txtEmail.text =@"bob@centralmichiganpest.com";
//    _txtPass.text =@"mipest";
    
//        _txtEmail.text =@"edwin@pest2kill.com";
//        _txtPass.text =@"Chutes2clean2017";
//            _txtEmail.text =@"mlaverty@fieldworkhq.com";
//            _txtPass.text =@"pest123";
//                _txtEmail.text =@"david@arborpestmgt.com";
//                _txtPass.text =@"greg0527";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(handleTap:)];
    
    tapRecognizer.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapRecognizer];
    [_txtEmail setReturnKeyType:UIReturnKeyDone];
    [_txtPass setReturnKeyType:UIReturnKeyDone];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)handleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded){
        [_txtPass resignFirstResponder];
        [_txtEmail resignFirstResponder];
    }
}

- (void)login:(id)sender {
    uname = self.txtEmail.text;
    password = self.txtPass.text;
    FieldWorkAccount *account = [[FieldWorkAccount alloc] init];
    if (uname.length <= 0 || password.length <= 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"Please enter valid information to login!"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([[AppDelegate appDelegate] isReachable]) {
        [[ActivityIndicator currentIndicator] displayActivity:@"Logging In..."];
        [account authenticatedWithUserName:uname andPassword:password withDelegate:self];
    }
}


- (void)agjustContentSize:(BOOL)grow notification:(NSNotification *)n {
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    CGSize size = _scrollView.contentSize;
    if (grow) {
        size.height += keyboardSize.height;
    } else {
        size.height -= keyboardSize.height;
    }
    _scrollView.contentSize = size;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)n
{
//    [self agjustContentSize:NO notification:n];
}

- (void)keyboardWillShow:(NSNotification *)n
{
//    [self agjustContentSize:YES notification:n];
}


#pragma AccountAuthenticateDelegate

- (void)accountAuthenticatedWithAccount:(FieldWorkAccount *)account {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:account.userName forKey:@"UserName"];
    [[ActivityIndicator currentIndicator] displayCompleted];
    [self.delegate userDidLoginWithAccount:account];
}

- (void)accountDidFailAuthentication:(NSError *)error {
    [[ActivityIndicator currentIndicator] displayCompleted];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@""
                                                     message:@"Your username or password are incorrect."
                                                    delegate:nil
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
    [alert show];
}

@end
