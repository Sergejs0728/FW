//
//  UnitInspectionViewController.h
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import <UIKit/UIKit.h>
#import "Unit.h"
#import "Appointment.h"

typedef enum {
    InsServiceTime = 0,
    InsStatus ,
    InsUnitContition,
    InsNotes
}InspectionRows;
typedef enum {
    InsSecTop = 0,
    InsSecMaterials,
    InsSecPests,
    InsSecSignature
}InspectionSections;

@interface UnitInspectionViewController : UIViewController
@property (strong,nonatomic) Unit* unit;
@property (strong,nonatomic) Appointment* appointment;
+(UnitInspectionViewController *)initWithUnit:(Unit *)unit andAppointment:(Appointment*) appointment;
@end
