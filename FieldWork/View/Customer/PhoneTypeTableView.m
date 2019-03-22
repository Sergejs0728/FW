//
//  PhoneTypeTableView.m
//  FieldWork
//
//  Created by Samir Khatri on 3/14/14.
//
//

#import "PhoneTypeTableView.h"

@interface PhoneTypeTableView()

- (void) postNotificationForHeight;
- (CGFloat)tableHeight;

@end

@implementation PhoneTypeTableView

- (void)awakeFromNib {
    self.delegate = self;
    self.dataSource = self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setData:(NSMutableArray *)arr {
    _array = arr;
    if (_array.count == 0) {
        [self btnAddClicked];
    }else{
        [self reloadData];
    }
    [self adjustTableHeight];
}

- (int)rowCount{
    return _array.count;
}

- (void)btnAddClicked {
     //26112015
    PhoneInfo *info = [[PhoneInfo alloc] init];
    [_array addObject:info];
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [self adjustTableHeight];
    [self performSelector:@selector(postNotificationForHeight) withObject:nil afterDelay:0.1];
}

- (void)btnRemoveClicked:(id)sender {
    UIButton *btn = (UIButton*) sender;
    [_array removeObjectAtIndex:btn.tag];
    
    [self adjustTableHeight];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    NSArray *arr = [NSArray arrayWithObjects:path, nil];
    [self deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationLeft];
    
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    [self performSelector:@selector(postNotificationForHeight) withObject:nil afterDelay:0.1];
}

- (void)postNotificationForHeight {
    [[NSNotificationCenter defaultCenter] postNotificationName:kADJUST_FULL_VIEW_HEIGHT object:nil];
}

- (void)adjustTableHeight {
    float height = (_array.count*44) + 15;
    NSLog(@"adjustTableHeight : %f", height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    
    //NSLog(@"Table Height 2: %f", self.frame.size.height);
}

-(CGFloat)tableHeight
{
    UITableView *_targetTable = self;
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
    NSLog(@"Table Height : %f", result);
    return result;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    PhoneTypeCell *cell = (PhoneTypeCell*)[self dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate =self;
    if (cell == nil)
    {
        NSArray *topLevelObject = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"PhoneTypeCell_iPad" owner:self options:nil];
        }else{
            topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"PhoneTypeCell" owner:self options:nil];
        }
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (PhoneTypeCell*) currentObject;
            }
        }
    }
    
    cell.btnRemove.tag =cell.txtPhone.tag =cell.txtExt.tag = cell.txtType.tag= indexPath.row;
    [cell.btnAdd addTarget:self action:@selector(btnAddClicked) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRemove addTarget:self action:@selector(btnRemoveClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (indexPath.row == 0) {
        cell.btnRemove.hidden = YES;
        cell.btnAdd.hidden = NO;
    }else{
        cell.btnRemove.hidden = NO;
        cell.btnAdd.hidden = YES;
    }
    if (indexPath.row == 0) {
        if (_array.count >= 3) {
            cell.btnAdd.hidden = YES;
        }
    }
    cell.txtPhone.keyboardType = cell.txtExt.keyboardType = UIKeyboardTypeNumberPad;
    cell.txtPhone.delegate = self;
    cell.txtExt.delegate = self;

     //26112015
    PhoneInfo *info = [_array objectAtIndex:indexPath.row];
    [cell setData:info];
    __weak __typeof(cell) weakCell = cell;
    cell.actionHandler = ^{
        //TODO: fix me
        [weakCell showPickerInView:self.superview.superview.superview];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHIDE_PICKERVIEW object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    int idx = (int)textField.tag;
    PhoneTypeCell *cell = (PhoneTypeCell*)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    if (cell) {
        PhoneInfo *info = [_array objectAtIndex:idx];
        info.phone = cell.txtPhone.text;
        info.phone_ext = cell.txtExt.text;
        info.phone_kind = cell.txtType.text;
    }
}


@end
