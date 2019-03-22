//
//  PJ673PrintSettingsViewController.h
//  BMSPrinterKit
//
//  Created by BMS on 8/8/12.
//  Copyright (c) 2012 Brother Mobile Solutions. All rights reserved.
//

#import "PrintSettingsViewController.h"
#import "PJ673PrintSettings.h"

// This is the DEFAULT popup contentSize for PJ673PrintSettingsViewController.
//
// You can override this by setting the "popoverSize" property (defined in the
// PrintSettingsViewController superclass) to something different
// before showing the ViewController.
//
// The popoverSize setting will be propagated to all of the "child" ViewControllers
// of the main ViewController so all of the detail views will be the SAME size as each other.
//
// NOTE: iPad1 and iPad2 size = 1024 x 768, iPad3 = 2048 x 1536
#define PJ673POPUPCONTENTSIZE CGSizeMake(400,480)
#define PJ673POPUPCONTENTSIZE_IOS7 CGSizeMake(400,588)


@interface PJ673PrintSettingsViewController : PrintSettingsViewController <PrintSettingsViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
}

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


