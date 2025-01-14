//
//  InstructionController.m
//  FieldWork
//
//  Created by Samir Khatri on 15/05/2013.
//
//

#import "InstructionController.h"

@interface InstructionController ()

@end

@implementation InstructionController

+ (InstructionController *)initWithAppointment:(Appointment *)app
{  InstructionController * inst;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        inst =[[InstructionController alloc]initWithNibName:@"InstructionView_IPad" bundle:nil];
        
    }else{
        inst =[[InstructionController alloc]initWithNibName:@"InstructionsView" bundle:nil];
        
    }
    inst.Appointment= app;
    inst.title =@"Instructions";
    return inst;
}



- (void)viewDidLoad
{
    
    NSString * instruction= self.Appointment.instructions;
    
    if (instruction.length <= 0) {
        txtview.text=@"No Instruction!";
    }else{
        txtview.text =instruction;

    }
    
       
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
