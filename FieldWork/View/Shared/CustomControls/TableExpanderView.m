//
//  TableExpanderView.m
//  TopBlip
//
//  Created by Avantar Developer on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableExpanderView.h"

@implementation TableExpanderView

-(void)dealloc
{
    self.targetTable = nil;
    
    [super dealloc];
}

@synthesize targetTable = _targetTable;

-(CGFloat)tableHeight
{
    id<UITableViewDataSource> dataSource = _targetTable.dataSource;
    id<UITableViewDelegate> delegate = _targetTable.delegate;
    
    NSUInteger sectionCount;
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
        sectionCount = [dataSource numberOfSectionsInTableView:_targetTable];
    else
        sectionCount = 1;
    
    CGFloat result = 0;
    
    for (NSUInteger i = 0; i < sectionCount; ++i)
    {
        NSUInteger rowCount = [dataSource tableView:_targetTable numberOfRowsInSection:i];
        
        if ([delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
            result += [delegate tableView:_targetTable heightForHeaderInSection:i];
        
        if ([delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
            result += [delegate tableView:_targetTable heightForFooterInSection:i];
        
        for (NSUInteger j = 0; j < rowCount; ++j)
        {
            result += [delegate tableView:_targetTable heightForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
        }
    }
    
    if(result == 910){
        NSLog(@"%f",result);
    }
    return result;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self expand];
}

-(void)expand
{  
    CGRect tableRect = _targetTable.frame;
    tableRect.size.height = [self tableHeight];
    _targetTable.frame = tableRect;
    tableRect.origin = self.frame.origin;
    self.frame = tableRect;
    
}

@end
