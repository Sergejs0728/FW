//
//  BaseViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 10/11/13.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
        self.edgesForExtendedLayout = UIRectEdgeNone;
            //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
        
        }else{
         
        }
#endif
    
	// Do any additional setup after loading the view.
}
#define UITABLE_VIEW_DISCLOSER_BUTTON
    //
-(NSString *)uitableViewDiscloserButton{
    NSString * uitableViewCellStyle = @"";
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
        uitableViewCellStyle= @"UITableViewCellAccessoryDisclosureIndicator";
        
        }else{
             uitableViewCellStyle= @"UITableViewCellAccessoryDetailDisclosureButton";
        }
#endif
    return uitableViewCellStyle;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        //[self.view setAlpha:1];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
        // [self.view setAlpha:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate


@end
