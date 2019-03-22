//
//  PrintSettingsViewController.h
//  BMSPrinterKit
//
//  Created by BMS on 8/8/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//
//  The PrintSettingsViewController class is the SUPERCLASS of each of the
//  model-specific view controller classes.
//
//  You should NEVER instantiate an object of this superclass. Instead, instantiate
//  an object of the model-specific subclass, e.g. PJ673PrintSettingsViewController.

#import <UIKit/UIKit.h>
#import "PrintSettings.h"


//*********************************************************************
// PrintSettingsResponder PROTOCOL
// NOTE: Perhaps a better way to implement this would be using NSNotificationCenter.
// But, for now we will use with this approach.
/*
 A class that uses a PrintSettingsViewController is a PrintSettingsResponder.

 You are required to do 2 things if you implement this protocol:
 --------------------------------------------------------------
 1. Set the "printSettingsDelegate" property in the PrintSettingsViewController class
 object in order to receive the printSettingsDidChange notification. Since
 each PrintSettingsViewController implements the PrintSettingsSetter protocol, each
 of the model-specific ViewControllers will have this property.
 
 2. Implement the printSettingsDidChange function.
 
 SDK Users:
 ---------
 You should implement this protocol if you choose to display any of the
 model-specific PrintSettingsViewControllers built-in to the SDK, but only if you 
 care to be notified when any of the settings are changed by the controller. 
 
 For example, you can allow the view controller to change the print settings,
 and you can pass the new settings to the BMSPrinterDriver when you need to
 use them. In this case, you do not need to implement this protocol.
 
 However, you may want to "savePreferences" when any of the settings change, 
 as the SDK will not do this automatically. In this case, you do need to
 implement this protocol to call the savePreferences API in your implementation
 of the printSettingsDidChange API.
 */
//*********************************************************************
@protocol PrintSettingsResponder
- (void)printSettingsDidChange;
@end


//*********************************************************************
// PrintSettingsSetter PROTOCOL
/*
 A ViewController that modifies print settings is a PrintSettingsSetter.
 It will call the printSettingsDidChange function that will be implemented by the
 object class specified in the printSettingsDelegate property, which is a 
 PrintSettingsResponder. 
 NOTE: It is OK to set this to "nil" if your class does not want to
 be notified when the settings change.
 
 This protocol is for SDK Designers only. 
 SDK Users do NOT need to implement this protocol.
 */
//*********************************************************************
@protocol PrintSettingsSetter
@property (assign, nonatomic) id <PrintSettingsResponder> printSettingsDelegate;
@end


//*********************************************************************
// PrintSettingsViewControllerDelegate PROTOCOL
//
// SDK Designers:
// --------------
// All model-specific PrintSettingsViewControllers must implement the following protocol,
// including all the other specified protocols (i.e. PrintSettingsSetter/Responder).
// Each of the model-specific controllers must be a subclass of the
// PrintSettingsViewController class.
// 
// SDK Users:
// ----------
// You do not need to implement this protocol. But, you will want to know about
// the properties defined in this protocol that you can use to modify the behavior
// of the model-specific view controllers.
//
// You should ALWAYS instantiate a model-specific ViewController (e.g.
// PJ673PrintSettingsViewController). But, you can use a generic variable of the
// PrintSettingsViewController class to contain the reference to the instantiation,
// and this reference which will have access to the properties/methods via this
// protocol.
//*********************************************************************
@protocol PrintSettingsViewControllerDelegate <PrintSettingsSetter, PrintSettingsResponder>

// NOTE: Each of the view controllers will be a UITableViewController.
// So, you MUST init them using "initWithStyle". So, let's add this to the protocol.
// "style" MUST be set to UITableViewStyleGrouped!!
-(id)initWithStyle:(UITableViewStyle)style;

// This is necessary so that a generic PrintSettingsViewController in the APP
// will be able to set the printSettings for the model-specific subclass.
@property (nonatomic, retain) PrintSettings *printSettings;

// used to modify properties of the TableView if SDK user wants to modify
// the defaults.
@property (nonatomic, assign) CGSize popoverSize;
@property (nonatomic, assign) int rowHeight;
@property (nonatomic, assign) int fontSize;
//*** These 2 properties allow customizing the IPAddressHelpViewController.
// * showIPAddressHelpButton is passed through to the IPAddressViewController to decide
// whether to show the Help Button at all.
// * IPAddressHelpFileName is passed thru to the IPAddressHelpViewController.
// This allows SDK User to change the Help File displayed.
// The file MUST be a "pdf" file (with lower-case file extension in the actual file),
// and you MUST omit the ".pdf" from the filename specified in this property.
@property (nonatomic, assign) BOOL showIPAddressHelpButton;
@property (nonatomic, retain) NSString *IPAddressHelpFileName;

// PrintSettingsSetter Protocol requires this delegate property.
// It is used to send notifications to SDK user when printsettings change.
// It can be set to nil if notifications are not desired.
@property (assign, nonatomic) id <PrintSettingsResponder> printSettingsDelegate;

// PrintSettingsResponder Protocol requires this method.
- (void)printSettingsDidChange;

@end

//*********************************************************************
// PrintSettingsViewController INTERFACE
// DO NOT INSTANTIATE an object of this class.
// Instead, instantiate a model-specific object, e.g. PJ673PrintSettingsViewController.
// This is essentially an ABSTRACT class that does nothing on its own.
//*********************************************************************
@interface PrintSettingsViewController : UITableViewController <PrintSettingsViewControllerDelegate>


//*** PrintSettingsSetter protocol
@property (assign, nonatomic) id <PrintSettingsResponder> printSettingsDelegate;

//*** PrintSettingsResponder protocol
- (void)printSettingsDidChange;

//*** PrintSettingsViewControllerDelegate protocol
@property (nonatomic, retain) PrintSettings *printSettings;

// Allows SDK User to modify the default tableview properties
@property (nonatomic, assign) CGSize popoverSize;
@property (nonatomic, assign) int rowHeight;
@property (nonatomic, assign) int fontSize;
//*** These 2 properties allow customizing the IPAddressHelpViewController.
// * showIPAddressHelpButton is passed through to the IPAddressViewController to decide
// whether to show the Help Button at all.
// * IPAddressHelpFileName is passed thru to the IPAddressHelpViewController.
// This allows SDK User to change the Help File displayed, if desired.
// The file MUST be a "pdf" file (with lower-case file extension in the actual file),
// and you MUST omit the ".pdf" from the filename specified in this property.
@property (nonatomic, assign) BOOL showIPAddressHelpButton;
@property (nonatomic, retain) NSString *IPAddressHelpFileName;

@end

