//
//  HeaderView.h
//  FieldWork
//
//  Created by SamirMAC on 12/14/15.
//
//

#import <UIKit/UIKit.h>

@class UIExpandableTableView;


@protocol HeaderViewProtocol <NSObject>

- (void)headerViewOpen:(NSInteger)section;

- (void)headerViewClose:(NSInteger)section;

@end


#define FONT_SIZE       13.0f

@interface HeaderView : UIView
{
    id<HeaderViewProtocol> _headerViewDelegate;
    NSInteger _section;
    UIExpandableTableView *_tableView;
    NSString *_title;
}
@property(nonatomic,assign)BOOL isPaid;
@property (nonnull, strong) void (^headerOpenBlock)(NSInteger section);
@property (nonnull, strong) void (^headerCloseBlock)(NSInteger section);
- (instancetype)initWithTableView:(UIExpandableTableView*)tableView andSection:(NSInteger)section andTitle:(NSString*)title;
- (instancetype)initWithTableView:(UIExpandableTableView *)tableView andSection:(NSInteger)section andTitle:(NSString *)title isPaid:(BOOL)status;
- (void) addRightButtonWithTitle:(NSString*)title andBlock:(void(^)())block;

@end
