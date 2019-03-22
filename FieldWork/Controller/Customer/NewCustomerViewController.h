//
//  NewCustomerViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 3/1/14.
//
//

#import <UIKit/UIKit.h>
#import "BillingTerms.h"
#import "FlowView.h"
#import "PhoneTypeTableView.h"
#import "SamcomActionSheet.h"
#import "ServiceLocation.h"
#import "Customer.h"
#import "CustomerDelegate.h"
#import "SamcomActionSheet_iPad.h"
#import "ServiceRoutes.h"

#define PICKER_BILLING_TERMS_TAG 10001
#define PICKER_LOCATION_TYPE_TAG 10002
#define PICKER_TAX_RATE_TAG 10003
#define PICKER_SERVICE_ROUTES_TAG 10004
#define PICKER_SR_NAME 10005


@interface NewCustomerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate, SamcomActionSheetDelegate, CustomerDelegate,iPadSamcomActionSheetDelegate>
{
    IBOutlet UIView *_segmentView1;
    IBOutlet UIView *_segmentView2;
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIView *_containerView;
    IBOutlet UISegmentedControl *_segmentCon;
    IBOutlet UITextField *_txt_commercial;
    IBOutlet UITextField *_txt_srname;
    IBOutlet UITextField *_txt_fname;
    IBOutlet UITextField *_txt_lname;
    IBOutlet UITextField *_txt_billing_name;
    IBOutlet UITextField *_txt_Address1;
    IBOutlet UITextField *_txt_Address2;
    IBOutlet UITextField *_txt_city;
    IBOutlet UITextField *_txt_state;
    IBOutlet UITextField *_txt_zip;
    IBOutlet UITextField *_txt_billing_terms;
    IBOutlet UITextField *_txt_service_email;
    IBOutlet UITextField *_txt_location_type;
    IBOutlet UITextField *_txt_tax_rate;
    
    
    //Bottom View
    
    IBOutlet UISwitch *_swtch;
    IBOutlet UITextField *_txt_service_routes;
    IBOutlet UIView *_serviceAddressView;
    IBOutlet PhoneTypeTableView *_phoneTypeTableView;
    IBOutlet PhoneTypeTableView *_phoneTypeTableViewSer;
    IBOutlet UIView *_switchView;
    
    IBOutlet UITextField *_txt_ser_name;
    IBOutlet UITextField *_txt_ser_address1;
    IBOutlet UITextField *_txt_ser_address2;
    IBOutlet UITextField *_txt_ser_city;
    IBOutlet UITextField *_txt_ser_state;
    IBOutlet UITextField *_txt_ser_zip;
    
    //action sheet
    
    __weak IBOutlet NSLayoutConstraint *constraintPhoneTypeTableViewHeight;
    __weak IBOutlet NSLayoutConstraint *constraintServiceAddressViewHeight;
    __weak IBOutlet NSLayoutConstraint *constraintPhoneTypeTableViewSerHeight;
    __weak IBOutlet NSLayoutConstraint *constraintBottomViewHeight;
    
    
    // Mainviews
    
    IBOutlet UIView *_topView;
    IBOutlet UIView *_bottomView;
    IBOutlet UIView *_mostBottomView;
    IBOutlet FlowView *_mainFlowView;
    
    // Data
    NSMutableArray *_phoneTypeArr;
    NSMutableArray *_phoneTypeArrSer;
    NSMutableArray *_billing_termsarray;
    NSMutableArray *_serviceRoutesArr;
    NSMutableArray *_arrLocationTypes;
    NSMutableArray *_arrTaxRates;
    NSMutableArray *_srNames;
    
    // PickerViews
    UIPickerView *_pickerBillingTerms;
    UIPickerView *_pickerPhoneType;
    UIPickerView *_pickerLocationType;
    UIPickerView *_pickerTaxRates;
    UIPickerView *_pickerServiceRoutes;
    UIPickerView *_pickerSrNames;
    
    IBOutlet UIButton *btnSave;
    
    
    Customer *_currentCustomer;
    ServiceLocation *_currentServiceLocation;
    
    BOOL _IS_EDIT;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UIView *containerView;
@property(nonatomic,retain) UISegmentedControl *segmentCon;
@property(nonatomic,retain) UITextField *txt_srname;
@property(nonatomic,retain) UITextField *txt_fname;
@property(nonatomic,retain) UITextField *txt_lname;
@property(nonatomic,retain) UITextField *txt_billing_name;
@property(nonatomic,retain) UITextField *txt_Address1;
@property(nonatomic,retain) UITextField *txt_Address2;
@property(nonatomic,retain) UITextField *txt_city;
@property(nonatomic,retain) UITextField *txt_state;
@property(nonatomic,retain) UITextField *txt_zip;
@property(nonatomic,retain) UITextField *txt_billing_terms;
@property(nonatomic,retain) UITextField *txt_service_email;

@property(nonatomic,retain)UIView *bottomView;
@property(nonatomic,retain)UISwitch *swtch;
@property(nonatomic,retain)UITextField *txt_propertylst;
@property(nonatomic,retain)UITextField *txt_commercial;

@property(nonatomic,retain)UIActionSheet *pickerContainerActionSheet;
@property(nonatomic,retain)UIView *pickerContainerView;
@property(nonatomic,retain)UIPickerView *pickerView;
@property(nonatomic,retain)NSMutableArray *billing_termsarray;

@property(nonatomic,retain)UIView *segmentView1;
@property(nonatomic,retain)UIView *segmentView2;

@property (nonatomic, retain, readwrite) Customer *currentCustomer;

+(NewCustomerViewController*)viewController;

+(NewCustomerViewController*)viewControllerWithCustomer:(Customer*)customer;



- (IBAction)billingTermsClicked:(id)sender;
- (IBAction)btnLocationTypeClicked:(id)sender;
- (IBAction)btnTaxRateClicked:(id)sender;
- (IBAction)btnServiceRoutesClicked:(id)sender;
- (IBAction)btnSrNameClicked:(id)sender;

- (IBAction)save:(id)sender;

-(IBAction)segmentValueChanged:(id)sender;
-(IBAction)switchValueChanged:(id)sender;

- (void)setInitialData;
- (void) adjustViewHeight;
- (void) openPickerViewWithTag:(int) tag andTitle:(NSString*) title forPickerView:(UIPickerView*) picker;

@end
