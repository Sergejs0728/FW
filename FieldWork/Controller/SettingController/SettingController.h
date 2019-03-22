//
//  SettingController.h
//  FieldWork
//
//  Created by Samir Kha on 16/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingController.h"
#import "CustomTableCell.h"
#import "UserSetting.h"
#import "BaseViewController.h"
#import "CustomerManager.h"

@interface SettingController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _table;
    IBOutlet UIButton * btnSave;
    
    BOOL _previous_sync_value;
}

@property (nonatomic, retain) UILabel * printlabel,* iplabel;
@property (nonatomic, retain) IBOutlet UITableView * table;

+ (SettingController*) init;

- (IBAction)settingsaveclicked:(id)sender;

- (IBAction)refreshClicked:(id)sender;

@end
