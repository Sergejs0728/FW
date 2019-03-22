//
//  ContactDetailViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Contact.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ContactDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UILabel *_lblContactName;
    IBOutlet UILabel *_lblDescription;
    __weak IBOutlet UITableView *tableView;
    
    NSMutableDictionary *_phoneKindList;
    NSMutableArray *phone_array;
    
    Contact *_contact;
}

@property (nonatomic, retain, readwrite) Contact *contact;


+ (ContactDetailViewController*) viewControllerWithContact:(Contact*) con;

@end
