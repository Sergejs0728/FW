//
//  CustomerServiceLocationListControllerViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import "ServiceLocation.h"
#import "Customer.h"
#import "BaseViewController.h"
#import "ServiceLocationDetailViewController.h"
#import "NewWorkOrderViewController.h"
#import "CustomerListDelegate.h"

@interface CustomerServiceLocationListControllerViewController : BaseViewController<UISearchDisplayDelegate, UISearchBarDelegate, CustomerListDelegate>
{
    IBOutlet UITableView *_servicelocation_tble;
    Customer *_customer;
    NSMutableArray *_service_locations;
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


@property (nonatomic, retain, readwrite) UITableView *servicelocation_tble;
@property (nonatomic, retain, readwrite) Customer *cusotmer;
@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain, readonly) NSArray *sectionedListContent;
@property (nonatomic, assign) BOOL LoadAll;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@property (nonatomic, retain, readwrite) id<NewWorkOrderDelegate> workOrderDelegate;

+(CustomerServiceLocationListControllerViewController*)initViewControllerWiithCustomer:(Customer*)customer;

+(CustomerServiceLocationListControllerViewController*)initViewControllerWiithCustomer:(Customer*)customer withWorkOrderDelegate:(id<NewWorkOrderDelegate>) del;

@end

