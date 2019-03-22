//
//  CustomerListViewController.h
//  FieldWork
//
//  Created by Samir Kha on 06/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerListDelegate.h"
//#import "CustomerList.h"
#import "NSMutableArray+SSArrayOfArrays.h"
#import "CustomerDetailViewController.h"
#import "CommonAppointmentViewController.h"
#import "NewCustomerViewController.h"
#import "NewWorkOrderViewController.h"
#import "CustomerManager.h"

@interface CustomerListViewController :CommonAppointmentViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSArray			*listContent;			// The master content.
	NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.
    NSArray         *sectionedListContent;  // The content filtered into alphabetical sections.
	
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    NSMutableArray *sections;
    BOOL LoadAll;
    
    id<NewWorkOrderDelegate> _workOrderDelegate;
    
}

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain, readonly) NSArray *sectionedListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@property (nonatomic, assign) BOOL LoadAll;

@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, retain, readwrite) id<NewWorkOrderDelegate> workOrderDelegate;

- (void)addNewCustomerClicked;

+ (CustomerListViewController*) init;

+ (CustomerListViewController*) initWithNewWorkOrderDelegate:(id<NewWorkOrderDelegate>) del;



@end
