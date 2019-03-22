//
//  HeaderView.m
//  FieldWork
//
//  Created by SamirMAC on 12/14/15.
//
//

#import "HeaderView.h"
#import "Appointment.h"
#import "Payment.h"
#import "UIExpandableTableView.h"
#import "UIButton+Block.h"
#import "CustomLabel.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTableView:(UIExpandableTableView *)tableView andSection:(NSInteger)section andTitle:(NSString *)title{
    float height = [_tableView.delegate tableView:_tableView heightForHeaderInSection:section];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height);
    
    if (self = [super initWithFrame:frame]){
        _tableView = tableView;
        _section = section;
        _title = title;
        _isPaid = false;
        _headerViewDelegate = (id<HeaderViewProtocol>)tableView;
        [self setBackgroundColor:[UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1.0f]];
    }
    return self;
}
- (instancetype)initWithTableView:(UIExpandableTableView *)tableView andSection:(NSInteger)section andTitle:(NSString *)title isPaid:(BOOL)status{
    float height = [_tableView.delegate tableView:_tableView heightForHeaderInSection:section];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), height);
    
    if (self = [super initWithFrame:frame]){
        _tableView = tableView;
        _section = section;
        _title = title;
        _isPaid = status;
        _headerViewDelegate = (id<HeaderViewProtocol>)tableView;
        [self setBackgroundColor:[UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1.0f]];
    }
    return self;
}

- (void)layoutSubviews {
    
    float height = [_tableView.delegate tableView:_tableView heightForHeaderInSection:_section];
    UILabel *lbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
    [lbl setText:_title];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [self addSubview:lbl];
    if (_section == 2) {
        if (_isPaid) {
            [self addPaidButtononView];
        }
    }

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setAction:kUIButtonBlockTouchUpInside withBlock:^{
        if(_tableView.sectionOpen != _section){
            if (_headerOpenBlock) {
                _headerOpenBlock(_section);
            }
//            [_tableView headerViewOpen:_section];
        } else if (_tableView.sectionOpen != NSNotFound) {
            if (_headerCloseBlock) {
                _headerCloseBlock(_section);
            }
//            [_tableView headerViewClose:_section];
        }
    }];
    [self addSubview:btn];
    [self sendSubviewToBack:btn];
}
-(void)addPaidButtononView{
    UIImageView *paidImgView = [[UIImageView alloc]initWithFrame:CGRectMake(70,3, 60, self.frame.size.height-5)];
    paidImgView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"paid_red.png"];
    [paidImgView setImage:image];
    [self addSubview:paidImgView];
    [self bringSubviewToFront:paidImgView];
}

- (void)addRightButtonWithTitle:(NSString *)title andBlock:(void (^)())block {
    float btn_width = 100;
    float height = [_tableView.delegate tableView:_tableView heightForHeaderInSection:_section];
    CGRect btn_frame = CGRectMake(self.frame.size.width - btn_width, 0, btn_width, height);
    UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [btn setBackgroundColor:[UIColor colorWithRed:94.0/255.0 green:94.0/255.0 blue:94.0/255.0 alpha:1.0]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (block) {
        [btn setAction:kUIButtonBlockTouchUpInside withBlock:block];
    }
    [self addSubview:btn];
    [self bringSubviewToFront:btn];
}

@end
