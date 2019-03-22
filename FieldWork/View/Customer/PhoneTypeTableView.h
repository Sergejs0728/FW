//
//  PhoneTypeTableView.h
//  FieldWork
//
//  Created by Samir Khatri on 3/14/14.
//
//

#import <UIKit/UIKit.h>
#import "PhoneTypeCell.h"
#import "PhoneInfo.h"

#define kADJUST_FULL_VIEW_HEIGHT @"kADJUST_FULL_VIEW_HEIGHT"

@interface PhoneTypeTableView : UITableView <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    //PhoneInfo Array
    NSMutableArray *_array;
}

@property (nonatomic, retain, readwrite) NSMutableArray *array;


- (void)btnAddClicked;
- (void)btnRemoveClicked:(id)sender;
- (void)setData:(NSMutableArray*) arr;

- (int) rowCount;
- (void) adjustTableHeight;

@end
