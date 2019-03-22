//
//  NoteController.h
//  FieldWork
//
//  Created by Samir Khatri on 29/04/2013.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "Recommendations.h"
#import "DataTableViewController.h"
#import "AppointmentDelegate.h"

@interface NoteController : CommonAppointmentViewController<UITextViewDelegate,UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, DataSelectionDelegate>
{
   
    IBOutlet UITextView * _noteTextView;
    IBOutlet UITextView *_txtPrivateNote;
    IBOutlet UILabel * _characterlbl;
    IBOutlet UILabel *_lblPrivateCount;
    IBOutlet UIView * noteview;
    IBOutlet UIButton * _saveBtn;
    IBOutlet UIScrollView *_noteScrollView;
    
    BOOL _shouldAskForUnsavedData;
    
    IBOutlet UITableView *_tblView;
    
    NSMutableArray *_selectedRecommendations;
    NSMutableArray *_selectedConditions;
    
    UIBarButtonItem *_btnHeaderSave;
}
@property (nonatomic ,retain)IBOutlet UIView * noteRoundView;
@property (nonatomic ,retain) UITextView * noteTextView;
@property (nonatomic, retain) UITextView *txtPrivateNote;
@property (nonatomic ,retain) UILabel * characterlbl;
@property (nonatomic ,retain) UIButton * saveBtn;
@property (nonatomic ,retain)UIScrollView *noteScrollView;

+ (NoteController *)initWithAppointment:(Appointment *)app;

- (void) manageTableHeight;

- (IBAction)NoteSave:(id)sender;
- (IBAction)keyboard:(id)sender;

@end
