//
//  TableExpanderView.h
//  TopBlip
//
//  Created by Avantar Developer on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Expands a table view so it is as long as the tables content is.
 The targetTable should be a child view of the TableExpanderView
 and the origin of the table view should be at 0,0 relative to the
 TableExpanderView
 */
@interface TableExpanderView : UIView
{
    UITableView *_targetTable;
}

@property (nonatomic, readwrite, retain) IBOutlet UITableView *targetTable;

/// resize the table view and self to contain the table
-(void)expand;

@end
