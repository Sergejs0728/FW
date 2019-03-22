//
//  SchemeDrawerControllerViewController.h
//  FieldWork
//
//  Created by Alexander on 07.09.16.
//
//

#import <UIKit/UIKit.h>
#import "StageModel.h"

typedef void(^SchemeBlock)();

@interface SchemeDrawerControllerViewController : UIViewController
@property (strong,nonatomic)NSNumber* serviceLocationId;
@property (weak, nonatomic) IBOutlet UITextView *noteView;
@property (strong, nonatomic) NSString* stageTitle;
//@property (nonatomic) BOOL isDirtyAppointment;
//@property (strong, nonatomic) NSString* buildingTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *costraintNote;
@property (strong, nonatomic) StageModel* stageModel;
@property (nonatomic) SchemeBlock block;
@end
