//
//  ContactListViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ContactDetailViewController.h"
@interface ContactListViewController : BaseViewController
{
    NSMutableArray *_contact_list;
    IBOutlet UITableView *_contact_table;
    
    NSArray			*listContent;			// The master content.
    NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.
    NSArray         *sectionedListContent;  // The content filtered into alphabetical sections.
    
    // The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    NSMutableArray *sections;
}



@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain, readonly) NSArray *sectionedListContent;
@property (nonatomic, assign) BOOL LoadAll;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;
@property (nonatomic, retain, readwrite) NSMutableArray *contact_list;
@property(nonatomic,retain)UITableView *contact_table;
+ (ContactListViewController*) viewControllerWithContactArray:(NSMutableArray*) contact_list;

@end
