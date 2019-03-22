//
//  ServiceLocationNoteViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 6/19/15.
//
//

#import "ServiceLocationNoteViewController.h"

@interface ServiceLocationNoteViewController ()

@end

@implementation ServiceLocationNoteViewController

@synthesize txtView=_txtView;
+ (ServiceLocationNoteViewController *)initViewController:(Appointment *)appointment{
    ServiceLocationNoteViewController * controller = [[ServiceLocationNoteViewController alloc]initWithNibName:@"ServiceLocationNoteViewController" bundle:nil];
    controller.Appointment = appointment;
    controller.title = @"Service Location Note";
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ServiceLocation *ser_loc = [self.Appointment getServiceLocation];
    
    _txtView.text =ser_loc.notes;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
