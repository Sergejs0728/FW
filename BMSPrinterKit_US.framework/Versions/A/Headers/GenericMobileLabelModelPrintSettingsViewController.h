//
//  GenericMobileLabelModelPrintSettingsViewController.h
//  BMSPrinterKit
//
//  Created by BMS on 9/27/13.
//  Copyright (c) 2013 Brother Mobile Solutions. All rights reserved.
//

#import "PrintSettingsViewController.h"
#import "GenericMobileLabelModelPrintSettings.h"



//*********************************************************************
// GenericMobileLabelModelPrintSettingsViewController INTERFACE
//
//*** IMPORTANT: *** DO NOT INSTANTIATE AN OBJECT OF THIS CLASS!!!!! ***
// The GenericMobileLabelModelPrintSettingsViewController class is essentially an
// ABSTRACT class.
// Instead, you should instantiate the model-specific class,
// e.g. RJ4040PrintSettingsViewController.
//*********************************************************************


@interface GenericMobileLabelModelPrintSettingsViewController : PrintSettingsViewController <PrintSettingsViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
}
// SDK Designers: The subclasses MUST set these properties in their init method.
// SDK Users: Do not use these properties.
@property (nonatomic, retain) NSString *mainTitle;
@property (nonatomic, retain) NSString *section1Title;

//*** PrintSettingsViewControllerDelegate protocol
// "style" MUST be set to UITableViewStyleGrouped!!
-(id)initWithStyle:(UITableViewStyle)style;

// SDK Designers: The PrintSettingsViewController superclass handles these properties:
//   printSettings, popoverSize, rowHeight, fontSize, and printSettingsDelegate,
// and also showIPAddressHelpButton and IPAddressHelpFileName.
// So, they are not defined in here.
//
// SDK Users: You need to be familiar with these properties so you can set
// them accordingly, in particular the printSettingsDelegate (which handles
// the PrintSettingsResponder protocol).


@end


