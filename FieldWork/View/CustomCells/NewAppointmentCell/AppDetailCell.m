//
//  AppDetailCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppDetailCell.h"

@interface AppDetailCell ()

@property (nonatomic) CGFloat constraintValue;

@end

@implementation AppDetailCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _constraintValue = 15.0;
    _constraintAddressLabelTopToSuperview.active = NO;
    _constraintAddressLabelTopToSuperview.constant = _constraintValue;
    _constraintAddressLabelTopToNameLabel.active = YES;
    _constraintAddressLabelTopToNameLabel.constant = _constraintValue;
    [self layoutIfNeeded];
    self.lblCustomerName.preferredMaxLayoutWidth = self.bounds.size.width;
    self.lblAddress.preferredMaxLayoutWidth = self.bounds.size.width - self.lblAddress.frame.origin.x;

//    self.phoneLabel1.preferredMaxLayoutWidth = self.bounds.size.width - self.phoneLabel1.frame.origin.x;
//    self.phoneLabel2.preferredMaxLayoutWidth = self.bounds.size.width - self.phoneLabel2.frame.origin.x;
//    self.phoneLabel3.preferredMaxLayoutWidth = self.bounds.size.width - self.phoneLabel3.frame.origin.x;
}

-(void)setDataWithAppointment:(Appointment *)app
{
    _appointment = app;
    
    _hieght = _btnStartAtTime.frame.size.height;
    
    if (app.arrival_time_start != nil && app.arrival_time_end != nil) {
        self.lblArriveTitle.text = @"Arrival window";
        self.lblArrivalWindow.text = [NSString stringWithFormat:@"%@ - %@", TRIM(_appointment.arrival_time_start), TRIM(_appointment.arrival_time_end)];
    }else{
        self.lblArriveTitle.text = @"Time";
        self.lblArrivalWindow.text = [NSString stringWithFormat:@"%@ - %@", TRIM(_appointment.starts_at_time), TRIM(_appointment.ends_at_time)];
    }
    
    if (_appointment.started_at_time != nil) {
        self.lblStartsAtTime.text =[Utils getNonmilitaryTime:_appointment.started_at_time];
    }
    if (_appointment.finished_at_time != nil) {
        self.lblEndsAtTime.text = [Utils getNonmilitaryTime:_appointment.finished_at_time];
    }

    //self.lblStartTime.text = [Utils getNonmilitaryTime:_appointment.started_at_time];
    
    _constraintAddressLabelTopToSuperview.active = _hideCustomerInfo;
    _constraintAddressLabelTopToNameLabel.active = !_hideCustomerInfo;
    _hieght += _constraintValue;
    
    if (!_hideCustomerInfo) {
        [_lblCustomerName setHidden:NO];
        self.lblCustomerName.text = [[_appointment getCustomer] getDisplayName];
        _hieght += _lblCustomerName.frame.size.height;
        _hieght += _constraintValue;
    }
    else {
        [self.lblCustomerName setHidden:YES];
    }
    
    ServiceLocation *ser_loc = [_appointment getServiceLocation];
    
    NSString *address = [ser_loc getFullAddress];
    
    NSString *loc_name = ser_loc.name;
    NSString *attn = ser_loc.attention;
    
    
    NSString *full_string = [NSString stringWithFormat:@"%@\n", loc_name];
    if (attn && attn.length > 0) {
        full_string = [NSString stringWithFormat:@"%@Attn : %@\n", full_string, attn];
    }
    full_string = [NSString stringWithFormat:@"%@%@", full_string, address];
    
    
    self.lblAddress.text = full_string;
    self.lblAddress.numberOfLines = 0;
    [self.lblAddress sizeToFit];
    
    _topLabel = _lblAddress;
    _hieght += _lblAddress.frame.size.height;
    
    NSString* firstPhone= ser_loc.phone;
    NSString* firstPhoneKind=ser_loc.phone;
    if ((firstPhone.length)&&(firstPhoneKind)) {
        [self buildLabelsAndButtonsForType:@"Phone" withTitle:firstPhone];
        _hieght += 5.0;
        _hieght += _topLabel.frame.size.height;
    }

    for (NSString *phone in ser_loc.phones) {
        [self buildLabelsAndButtonsForType:@"Phone" withTitle:phone];
        _hieght += 5.0;
        _hieght += _topLabel.frame.size.height;
    }
    
    if (ser_loc.email.length) {
        [self buildLabelsAndButtonsForType:@"Email" withTitle:ser_loc.email];
        _hieght += 5.0;
        _hieght += _topLabel.frame.size.height;
    }
    
    if (_topButton) {
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topButton]-15-[bottomHorizontalSeparatorView]" options:0 metrics:nil views:@{@"topButton":_topButton,@"bottomHorizontalSeparatorView":_bottomHorizontalSeparatorView}]];
    } else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLabel]-15-[bottomHorizontalSeparatorView]" options:0 metrics:nil views:@{@"topLabel":_topLabel,@"bottomHorizontalSeparatorView":_bottomHorizontalSeparatorView}]];
    }
    CGFloat addedHeight = 15.0 + 1.0 + _btnMore.frame.size.height + 1.0;
    _hieght += addedHeight;

//    [self.lblDuration setText:[app getDuration]];
    
}

-(void)buildLabelsAndButtonsForType:(NSString*)type withTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_labelAddressFieldName.frame), CGRectGetMaxY(_topLabel.frame)+5, CGRectGetWidth(_labelAddressFieldName.frame), CGRectGetHeight(_labelAddressFieldName.frame))];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = _labelAddressFieldName.font;
    label.textColor = _labelAddressFieldName.textColor;
    label.numberOfLines = 1;
    label.text = type;
    [self addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    if ([type isEqualToString:@"Phone"]) {
        [button addTarget:self action:@selector(phoneTapped:) forControlEvents:UIControlEventTouchUpInside];
    } else if ([type isEqualToString:@"Email"]) {
        [button addTarget:self action:@selector(emailTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [self addSubview:button];
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    
    // Button constraint
    NSLayoutConstraint* buttonConstraint = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:_lblAddress attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [self addConstraint:buttonConstraint];
    
    // Label constraints
    NSLayoutConstraint* leftLabelConstraint = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:_labelAddressFieldName attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint* centerLabelConstraint = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:button attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];    
    [self addConstraints:@[leftLabelConstraint, centerLabelConstraint]];

    NSMutableDictionary *binding = [NSMutableDictionary new];
    [binding setObject:label forKey:@"label"];
    [binding setObject:_topLabel forKey:@"topLabel"];
    [binding setObject:button forKey:@"button"];
    if (_topButton) {
        [binding setObject:_topButton forKey:@"topButton"];
    }
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-5-|" options:0 metrics:nil views:binding]];
    if (_topButton) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topButton]-5-[button]" options:0 metrics:nil views:binding]];
        _topLabel = label;
    } else {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLabel]-5-[button]" options:0 metrics:nil views:binding]];
    }
    
    _topButton = button;
}

- (void)btnDrivingDirection:(UIButton*)sender {
    if (_drivingDirectionAction) {
        _drivingDirectionAction(sender.tag);
    }
    
    //    ServiceLocation *ser_loc = [_appointment getServiceLocation];
    //
    //    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake([ser_loc.lat doubleValue], [ser_loc.lng doubleValue]);
    //
    //    Class itemClass = [MKMapItem class];
    //    if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
    //        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:cord addressDictionary:nil] ];
    //        toLocation.name = [[_appointment getCustomer] getDisplayName];
    //        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
    //                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsbtnMoredeDriving, [NSNumber numberWithBool:YES], nil]
    //                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
    //
    //    } else {
    //        NSString* urlStr = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current%%20Location&daddr=%f,%f", cord.latitude, cord.longitude];
    //        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlStr]];
    //    }
}

-(void)btnSelectStartTime:(id)sender{
    
}

-(void)btnSelectEndTime:(id)sender{
    
}

- (IBAction)phoneTapped:(UIButton *)sender {
    if (_phoneAction) {
        _phoneAction(sender.titleLabel.text);
    }
//    NSString* phoneNumber=sender.titleLabel.text;
//    NSString *phoneURL = [@"tel://" stringByAppendingString:phoneNumber];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL]];
}

-(IBAction)emailTapped:(UIButton *)sender {
    if (_emailAction) {
        ServiceLocation *ser_loc = [_appointment getServiceLocation];
        _emailAction(ser_loc.email);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
