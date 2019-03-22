//
//  AppointmentCell.m
//  FieldWork
//
//  Created by Samir Kha on 24/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppointmentCell.h"
#import "Location.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AppointmentCell

- (void)awakeFromNib {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblSyncStatusClicked:)];
    [_lblSyncError addGestureRecognizer:gesture];
    _lblSyncError.layer.cornerRadius = 3.0;
    _lblstatus.layer.cornerRadius = 3.0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCustomerData:(Customer*)cust andServiceLocation:(ServiceLocation*)ser_info
{
    if (cust) {
//        if (!_hideCustomerInfo) {
//            _lblTitle.text=ser_info.name;
//            [_lblSubTitle setHidden:YES];
//        }
//        else{
            _lblTitle.text = [cust getDisplayName];
//        }
    } else {
        _lblTitle.text = @"Loading...";
    }
    if (ser_info != nil) {
        
        _lblSubTitle.text = ser_info.name;
    } else {
        _lblSubTitle.text = @"Loading...";
    }
//    if (self.itemLoadedBlock) {
//        self.itemLoadedBlock(nil, nil);
//    }
    [self.contentView setNeedsLayout];
}

//- (void)setCustomer:(Customer *)customer {
//    if (customer) {
//        _lblTitle.text = [customer getDisplayName];
//    } else {
//        _lblTitle.text = @"Loading...";
//    }
//}

- (void)setAppointment:(Appointment *)app {
    _lblSyncError.hidden = app.error_sync_message.length==0;
    __block Customer *cust = [app getCustomer];
    __block ServiceLocation *ser_info = [app getServiceLocation];
    _appointment=app;

//    if (cust == nil) {
//        __weak typeof(self) weakSelf = self;
//        [Customer retriveCustomer:app.customer_id withBlock:^(id result, NSString *error) {
//            ser_info = [app getServiceLocation];
//            cust = result;
//            [weakSelf setCustomerData:cust andServiceLocation:ser_info];
//        }];
//    } else {
        [self setCustomerData:cust andServiceLocation:ser_info];
//    }
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    NSString *first_ser_location = @"";
    
    if (app.line_items != nil && app.line_items.count > 0) {
        LineItem *litem = [[app.line_items array] objectAtIndex:0];
        first_ser_location = litem.name;
    }
    
    _lblFirstServiceLocation.text = first_ser_location;
    _lblstatus.text = app.status;
    _lblstatus.textAlignment = NSTextAlignmentCenter;
    //NSLog(@"Arrival start time %@ and Arrival end time %@",app.arrival_time_start,app.arrival_time_end);
    if (app.arrival_time_start != nil && app.arrival_time_end != nil) {
        lblArrive.text = @"Arrival Window:";
        _lblTimeArrive.text = [NSString stringWithFormat:@"%@ - %@", TRIM(app.arrival_time_start), TRIM(app.arrival_time_end)];
        _lblTimeArrive.frame = CGRectMake(lblArrive.frame.origin.x+lblArrive.frame.size.width+1, _lblTimeArrive.frame.origin.y, _lblTimeArrive.frame.size.width, _lblTimeArrive.frame.size.height);
    }else{
        lblArrive.text = @"Time:";
         _lblTimeArrive.text = [NSString stringWithFormat:@"%@ - %@", TRIM(app.starts_at_time), TRIM(app.ends_at_time)];
         _lblTimeArrive.frame = CGRectMake(lblArrive.frame.origin.x+40, _lblTimeArrive.frame.origin.y, _lblTimeArrive.frame.size.width, _lblTimeArrive.frame.size.height);
    }
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status_name=%@",app.status];
    _statusModel=  [Statuses MR_findFirstWithPredicate:predicate];
    if(!_statusModel){
        predicate = [NSPredicate predicateWithFormat:@"status_value=%@",app.status];
        _statusModel=  [Statuses MR_findFirstWithPredicate:predicate];
    }
    checkMarkImage.hidden = YES;
    UIColor* backgroundColor=[self colorByStatus:_statusModel];
    _lblstatus.backgroundColor=backgroundColor;
    UIColor* textColor=[self fontColorByStatus:_statusModel];
    _lblstatus.textColor=textColor;
    _lblstatus.text=[self labelTextByStatus:_statusModel];

    if (app.confirmedValue == true) {
        checkMarkImage.hidden = NO;
    }else{
        checkMarkImage.hidden = YES;
    }
   _lblFirstServiceLocation.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
   
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSInteger *diff = [Utils timezoneDifferenceInDestinationTimeZone];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:diff]];
    _lblTimeDuration.text = [app getDuration];
}


- (void)setEstimate:(Estimate *)est {
    _lblSyncError.hidden = YES;
    __block Customer *cust = [est getCustomer];
    __block ServiceLocation *ser_info = [est getServiceLocation];
    _estimate=est;
    //    if (cust == nil) {
    //        __weak typeof(self) weakSelf = self;
    //        [Customer retriveCustomer:app.customer_id withBlock:^(id result, NSString *error) {
    //            ser_info = [app getServiceLocation];
    //            cust = result;
    //            [weakSelf setCustomerData:cust andServiceLocation:ser_info];
    //        }];
    //    } else {
    [self setCustomerData:cust andServiceLocation:ser_info];
    //    }
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
    
    NSString *first_ser_location = @"";
    
    if (est.line_items != nil && est.line_items.count > 0) {
        LineItem *litem = [[est.line_items array] objectAtIndex:0];
        first_ser_location = litem.name;
    }
    
    _lblFirstServiceLocation.text = first_ser_location;
    _lblstatus.text = est.status;
    _lblstatus.textAlignment = NSTextAlignmentCenter;
    //NSLog(@"Arrival start time %@ and Arrival end time %@",app.arrival_time_start,app.arrival_time_end);
    if ((est.starts_at != nil) && ([est getEndTime] != nil)) {
        lblArrive.text = @"Arrival Window:";
        _lblTimeArrive.text = [NSString stringWithFormat:@"%@ - %@", TRIM([est startsAtString]), TRIM([est endTimeString])];
        _lblTimeArrive.frame = CGRectMake(lblArrive.frame.origin.x+lblArrive.frame.size.width+1, _lblTimeArrive.frame.origin.y, _lblTimeArrive.frame.size.width, _lblTimeArrive.frame.size.height);
    }
    else{
        lblArrive.text = @"Time:";
        _lblTimeArrive.text = [NSString stringWithFormat:@"%@ - %@", TRIM([est startsAtString]), TRIM([est endTimeString])];
        _lblTimeArrive.frame = CGRectMake(lblArrive.frame.origin.x+40, _lblTimeArrive.frame.origin.y, _lblTimeArrive.frame.size.width, _lblTimeArrive.frame.size.height);
    }
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status_name=%@",est.status];
    _statusModel=  [Statuses MR_findFirstWithPredicate:predicate];
    if(!_statusModel){
        predicate = [NSPredicate predicateWithFormat:@"status_value=%@",est.status];
        _statusModel=  [Statuses MR_findFirstWithPredicate:predicate];
    }
    checkMarkImage.hidden = YES;
    UIColor* backgroundColor=[self colorByStatus:_statusModel];
    _lblstatus.backgroundColor=backgroundColor;
    UIColor* textColor=[self fontColorByStatus:_statusModel];
    _lblstatus.textColor=textColor;
    _lblstatus.text=[self labelTextByStatus:_statusModel];
    
//    if (est.confirmedValue == true) {
//        checkMarkImage.hidden = NO;
//    }else{
//        checkMarkImage.hidden = YES;
//    }
    _lblFirstServiceLocation.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSInteger *diff = [Utils timezoneDifferenceInDestinationTimeZone];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:diff]];
    _lblTimeDuration.text = [est getDurationString];

//    _lblTimeDuration.text = [est getDuration];
    
}

-(UIColor*)colorByStatus:(Statuses*) statusModel{
    unsigned colorHex = 0;
    if ((statusModel)&&(statusModel.color)&&(statusModel.color.length>0)){
        NSScanner *scanner = [NSScanner scannerWithString:statusModel.color];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&colorHex];
    }
    return UIColorFromRGB(colorHex);
}

-(UIColor*)fontColorByStatus:(Statuses*) statusModel{
    unsigned fontHex = 0;
    if ((statusModel)&&(statusModel.font_color)&&(statusModel.font_color.length>0)){
        NSScanner *scanner = [NSScanner scannerWithString:statusModel.font_color];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&fontHex];
    }
    UIColor* fontColor=UIColorFromRGB(fontHex);
    return fontColor;
}

-(NSString*) labelTextByStatus:(Statuses*) statusModel{
    NSString* statusName=statusModel.status_name;
    if ((statusName)&&(statusName.length>1)) {
        NSRange range=NSMakeRange(0, 1);
        NSString* letter=[statusName substringWithRange:range];
        return letter;
    }
    return @"#";
}
    

-(void)setAppointmentWorkPool:(Appointment *)app{
    checkMarkImage.hidden = YES;
    __block Customer *cust = [app getCustomer];
    __block ServiceLocation *ser_info = [app getServiceLocation];
    if (cust == nil) {
        __weak typeof(self) weakSelf = self;
        [Customer retriveCustomer:app.customer_id withBlock:^(id result, NSString *error) {
            if (error == nil) {
                ser_info = [app getServiceLocation];
                cust = result;
                [weakSelf setCustomerData:cust andServiceLocation:ser_info andAppointment:app];
            }
        }];
    } else {
        [self setCustomerData:cust andServiceLocation:ser_info andAppointment:app];
    }
    
    
    NSString *first_ser_location = @"";
    
    if (app.line_items != nil && app.line_items.count > 0) {
        LineItem *litem = [[app.line_items array] objectAtIndex:0];
        first_ser_location = litem.name;
    }
    
    _lblstatus.hidden = YES;
   
    _lblFirstServiceLocation.text = first_ser_location;
    _lblstatus.text = app.status;
    _lblstatus.textAlignment = NSTextAlignmentCenter;
   // _lblTimeArrive.text = app.starts_at_time;
    lblArrive.hidden = YES;
    lblDuration.hidden = YES;
        //   _imgIsConfirmed.hidden = !app.confirmed;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSInteger *diff = [Utils timezoneDifferenceInDestinationTimeZone];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:diff]];
    
   // _lblTimeDuration.text = [app getDuration];
    
}

- (void) setCustomerData:(Customer*)cust andServiceLocation:(ServiceLocation*)ser_info andAppointment:(Appointment *)app
{
    
    if (_hideCustomerInfo) {
        _lblTitle.text=ser_info.name;
    }
    else{
        _lblTitle.text = [cust getDisplayName];
    }
    if (ser_info != nil) {
        CLLocationCoordinate2D coord = [[Location Instance] getCurrentCoordinates];
        CLLocation *currentlocation = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
        CLLocationDistance distance = [Appointment getDistanceForAppointment:app.entity_id andCurrentLocation:currentlocation];
//        NSString *str1 = [NSString stringWithFormat:@"%@  Distance: %.2f Mi",ser_info.name,(distance / 1609.34)];
        //_lblSubTitle.text = [NSString stringWithFormat:@"%@\n Distance: %.1f Mi",ser_info.name,((distance / 1609.34) / 1000)];
        _lblSubTitle.text = [NSString stringWithFormat:@"%@\nDistance: %.1f Mi",ser_info.name,(distance * 0.000621371)];
        [_lblSubTitle sizeToFit];
    }
    
    [self.contentView setNeedsLayout];
}

- (void) showSyncError:(BOOL)show {
    _lblSyncError.hidden = !show;
}

- (void)lblSyncStatusClicked:(UITapGestureRecognizer*)sender {
    if (self.lblSyncErrorAction != nil) {
        self.lblSyncErrorAction(self.tag);
    }
}

@end
