//
//  UIExpandableTableView.m
//  FieldWork
//
//  Created by SamirMAC on 12/14/15.
//
//

#import "UIExpandableTableView.h"

@implementation UIExpandableTableView

@synthesize sectionOpen = _sectionOpen;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    _sectionOpen = NSNotFound;
}

- (void)headerViewOpen:(NSInteger)section {
    if (_sectionOpen != NSNotFound) {
        [self headerViewClose:_sectionOpen];
    }
    
    _sectionOpen = section;
    NSInteger numberOfRows = [self.dataSource tableView:self numberOfRowsInSection:section];
    NSMutableArray *indexPathToInserts = [[NSMutableArray alloc] init];
    for (int i = 0; i < numberOfRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        [indexPathToInserts addObject:indexPath];
    }
    if (indexPathToInserts.count > 0) {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:indexPathToInserts withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];
//        CGRect lastRowRect = [self rectForRowAtIndexPath:[indexPathToInserts lastObject]];
//        NSIndexPath *indexPath = [indexPathToInserts lastObject];
//        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        [self scrollRectToVisible:lastRowRect animated:YES];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger number_of_sections = [self.dataSource numberOfSectionsInTableView:self];
        if (section == number_of_sections - 1) {
            [self scrollToBottom];
        }
    });
    
    
}

- (void)scrollToBottom
{
    CGFloat yOffset = 0;
    
    if (self.contentSize.height > self.bounds.size.height) {
        yOffset = self.contentSize.height - self.bounds.size.height;
    }
    
    [self setContentOffset:CGPointMake(0, yOffset) animated:YES];
}

- (void)headerViewClose:(NSInteger)section {
     NSInteger numberOfRows = [self.dataSource tableView:self numberOfRowsInSection:section];
    NSMutableArray *indexPathToDelete = [[NSMutableArray alloc] init];
    _sectionOpen = NSNotFound;
    for (int i = 0; i < numberOfRows; i++) {
        [indexPathToDelete addObject:[NSIndexPath indexPathForItem:i inSection:section]];
    }
    if (indexPathToDelete.count > 0) {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:indexPathToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
        [self endUpdates];
    }
    
}

@end
