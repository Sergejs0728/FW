//
//  PestEvidenceView.h
//  FieldWork
//
//  Created by Samir Kha on 12/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAppointmentViewController.h"

@interface PestEvidenceView : CommonAppointmentViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _PestEvidencetable;
    NSMutableArray * PestEvidencelist;
    IBOutlet UILabel * Pestlabel;
    NSString * _barcode;
    //26112015
//    CustomerTrap *_customerTrap;
    
}
@property (nonatomic, retain) IBOutlet UITableView * PestEvidencetable;
//26112015
//@property (nonatomic, retain) NSString * barcode;
//@property (nonatomic, readwrite, retain) CustomerTrap *customerTrap;

-(IBAction)PestEvidencebtn:(id)sender;

//26112015
//+ (PestEvidenceView*) initWithAppointment:(Appointment*) appt andCustomerTrap:(CustomerTrap*) ctrap;

@end
