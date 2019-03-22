#import "Estimate.h"
#import "LineItem.h"
#import "FWPDFForm.h"
#import "CDHelper.h"
#import "PhotoAttachment.h"
#import "NSManagedObject+Mapping.h"
#import "NSDictionary+Extension.h"
#import "SyncManager.h"
#import "TaxRates.h"

#define ADD_NEW_ESTIMATE_TAG @"ADD_NEW_ESTIMATE_TAG"

@interface Estimate ()
@end

@implementation Estimate
{
    EstimateSavedBlock _saved_block;
    ItemSavedBlock _itemSavedBlock;
}
+ (NSMutableArray*) getEstimates
{
    return [[Estimate MR_findAll] mutableCopy];
//    [[Estimate MR_findByAttribute:@"specific" withValue:[NSNumber numberWithBool:YES]] mutableCopy];
}

+(BOOL)isFoundDirty{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entity_status == %@",c_EDITED];
    NSArray *arr = [Estimate MR_findAllWithPredicate:predicate];
    if (arr.count == 0) {
        return false;
    }
    return true;
}

+ (NSMutableArray*) getEstimatesForDate:(NSDate*) date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay) fromDate:[date changeTimeZoneToUtc]];
    //create a date with these components
    NSDate *startDate = [calendar dateFromComponents:components];
    [components setDay:1];
    [components setMonth:0];
    [components setYear:0];
    NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"starts_at >= %@ AND starts_at < %@ ", [startDate changeTimeZoneToLocal], [endDate changeTimeZoneToLocal]];
    NSMutableArray *arr = [[Estimate MR_findAllWithPredicate:predicate] mutableCopy];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"starts_at" ascending:YES];
    [arr sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
    return arr;
}

- (void) saveEstimateOnServerWithBlock:(EstimateSavedBlock)save_block
{
//    self.is_sync=@(YES);
//    [self setStarts_at_date:[Utils dateFormatMMddyyyy:[[NSDate date] changeTimeZoneToLocal]]];
    _saved_block = save_block;
    NSMutableDictionary *json = [self buildJson];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    RequestMethod method = PUT;
    NSString *url = [NSString stringWithFormat:API_ESTIMATE, self.entity_id];
    NSDictionary *main = @{@"estimate":json};
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:main
                                                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                          error:nil];
    
    NSString *jsonString2 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    FWRequest *request = [[FWRequest alloc] initWithUrl:url andDelegate:self andMethod:method];
    request.Tag = API_ESTIMATE;
    [request setPostParameters:[main mutableCopy]];
    [request startRequest];
    [[SyncManager Instance] syncPlans];
    [[SyncManager Instance] syncPhotos];
    [[SyncManager Instance] syncPDFAttachments];
    [[SyncManager Instance] startSync];
}

- (void) saveEstimateOnLocal
{
    [self setEntity_status:c_EDITED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}

- (NSMutableDictionary *)buildJson {
    NSMutableDictionary *work_order_json = [[FEMSerializer serializeObject:self usingMapping:[Estimate reverseMappingEstimate]] mutableCopy];
    NSArray* allKeys=[work_order_json allKeys];
    for (NSString* key in allKeys) {
        id value=[work_order_json valueForKey:key];
        if ([value isKindOfClass:[NSDate class]]) {
            NSDate* valueDate=value;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
            NSString* valueString=[dateFormatter stringFromDate:valueDate];
            [work_order_json setObject:valueString forKey:key];
        }
    }
    /*
    // Line Items
    
    if (self.line_items.count > 0) {
        NSMutableArray *line_items = [[NSMutableArray alloc] init];
        for (LineItem *l_item in self.line_items) {
            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
                l_item.price = @5;
                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Estimate reverseMappingLineItems]];
                if ([l_item.entity_status isEqualToNumber: c_ADDED]) {
                    l_item_dict = [l_item_dict dictionaryByRemovingId];
                }
                if ([l_item.entity_status isEqualToNumber: c_DELETED]) {
                    l_item_dict = [[NSDictionary alloc] initWithDestroy:l_item.entity_id];
                }
                if (l_item_dict) [line_items addObject:l_item_dict];
            }
        }
        if (line_items.count > 0) {
            [work_order_json setValue:line_items forKey:@"line_items_attributes"];
        }
    }
    */

    // Line Items
    if (self.line_items.count > 0) {
        NSMutableArray *line_items = [[NSMutableArray alloc] init];
        for (LineItem *l_item in self.line_items) {
            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
                
                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Estimate reverseMappingLineItems]];
                
                if ([l_item.entity_status isEqualToNumber: c_ADDED]) {
                    l_item_dict = [l_item_dict dictionaryByRemovingId];
                }
                if ([l_item.entity_status isEqualToNumber: c_DELETED]) {
                    l_item_dict = [[NSDictionary alloc] initWithDestroy:l_item.entity_id];
                }
                if (l_item_dict) [line_items addObject:l_item_dict];
            }
        }

        
        NSMutableArray *line_items_dic = [[NSMutableArray alloc] init];
        if (line_items.count > 0) {
            for (int i = 0; i < line_items.count; i++)
            {
                //remove 0.000001 issue
                float price = [line_items[i][@"price"] floatValue];
                
                if((int)(price*10000)%100<49){
                    price = (int)(price*10000) - (int)(price*10000)%100;
                }else{
                    price = (int)(price*10000) - (int)(price*10000)%100 + 100;
                }
                
                float total = [line_items[i][@"total"] floatValue];
                
                if((int)(total*10000)%100<49){
                    total = (int)(total*10000) - (int)(total*10000)%100;
                }else{
                    total = (int)(total*10000) - (int)(total*10000)%100 + 100;
                }
                
                NSString *ttotal = [NSString stringWithFormat:@"%.2f",total/10000];
                NSString *pprice = [NSString stringWithFormat:@"%.2f",price/10000];
                
                NSDictionary *line_items_attributes_dic = @{@"id":line_items[i][@"id"],@"name":line_items[i][@"name"],@"payable_id":line_items[i][@"payable_id"],@"payable_type" : line_items[i][@"payable_type"],@"price" : pprice,@"quantity":line_items[i][@"quantity"],@"taxable":line_items[i][@"taxable"], @"total" : ttotal,@"type" : line_items[i][@"type"]};
                
                [line_items_dic insertObject:line_items_attributes_dic atIndex:i];
                
                
                
                //            [work_order_json setValue:line_items forKey:@"line_items_attributes"];
                
            }
            [work_order_json setValue:line_items_dic forKey:@"line_items_attributes"];
        }
    }
    
//    if (self.line_items.count > 0) {
//        NSMutableArray *line_items = [[NSMutableArray alloc] init];
//        for (LineItem *l_item in self.line_items) {
//            NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Estimate reverseMappingLineItems]];
//            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
//                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Estimate reverseMappingLineItems]];
//                if ([l_item.entity_status isEqualToNumber: c_ADDED]) {
//                    l_item_dict = [l_item_dict dictionaryByRemovingId];
//                }
//                if ([l_item.entity_status isEqualToNumber: c_DELETED]) {
//                    l_item_dict = [[NSDictionary alloc] initWithDestroy:l_item.entity_id];
//                }
//                if (l_item_dict) [line_items addObject:l_item_dict];
//            }
//        }
//        if (line_items.count > 0) {
//            NSArray* not_mutable_line_items=[NSArray arrayWithArray:line_items];
//            [work_order_json setValue:not_mutable_line_items forKey:@"line_items_attributes"];
//        }
//    }
    NSSet* photos= self.photo_attachments;
    if (photos) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"entity_status == %@", c_DELETED];
        NSSet *filtered = [photos filteredSetUsingPredicate:pre];
        if (filtered && filtered.count > 0) {
            NSMutableArray *deleted_photos = [[NSMutableArray alloc] init];
            for (PhotoAttachment *pa in filtered) {
                NSDictionary *photo_dict = [[NSDictionary alloc] initWithDestroy:pa.entity_id];
                if (photo_dict) [deleted_photos addObject:photo_dict];
            }
            [work_order_json setValue:deleted_photos forKey:@"photo_attachments_attributes"];
        }
//        NSSet *added = [self.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//            PhotoAttachment *pa = (PhotoAttachment*) evaluatedObject;
//            if ([pa.entity_status isEqualToNumber:c_ADDED] || [pa.entity_status isEqualToNumber:c_EDITED]) {
//                return YES;
//            }
//            return NO;
//        }]];
//        if (added && added.count > 0) {
//            for (PhotoAttachment *pa in added) {
//                [pa upload];
//            }
//        }
    }
    NSSet* attachments= self.attachments;
    
    // PDF Attachment - We dont need to filter for delete as app does not allow user to delete any PDF Attachment
    if (attachments) {
        NSSet *added = [attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            PDFAttachment *pa = (PDFAttachment*) evaluatedObject;
            if ([pa.entity_status isEqualToNumber:c_ADDED] || [pa.entity_status isEqualToNumber:c_EDITED]) {
                return YES;
            }
            return NO;
        }]];
        if (added && added.count > 0) {
            for (PDFAttachment *pa in added) {
                NSString* pdfName=pa.attachment_file_name;
                NSSet* forms=[self.pdf_forms filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    FWPDFForm *pdfForm = (FWPDFForm*) evaluatedObject;
                    if ([pdfForm.name isEqualToString:pdfName]){
                        return YES;
                    }
                    return NO;
                }]];
                if(forms){
                    if (forms.count>0) {
                        FWPDFForm *pdfForm=[[forms allObjects] objectAtIndex:0];
                        [pa uploadWithPDFid:[NSString stringWithFormat:@"%@", pdfForm.entity_id]];
                    }
                    
                }
            }
        }
    }
    return work_order_json;
}

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Estimate entityName]];
    [mapping addAttribute:[Estimate dateTimeAttributeFor:@"starts_at" andKeyPath:@"starts_at"]];
    [mapping addAttribute:[Estimate dateTimeAttributeFor:@"expires_on" andKeyPath:@"expires_on"]];
    [mapping addAttribute:[Estimate dateTimeAttributeFor:@"created_at" andKeyPath:@"created_at"]];
    [mapping addAttribute:[Estimate dateTimeAttributeFor:@"issued_on" andKeyPath:@"issued_on"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"customer_id" andKeyPath:@"customer_id"]];
    [mapping addAttribute:[Estimate stringAttributeFor:@"notes" andKeyPath:@"notes"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"service_location_id" andKeyPath:@"service_location_id"]];
    [mapping addAttribute:[Estimate stringAttributeFor:@"status" andKeyPath:@"status"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"tax_rate_id" andKeyPath:@"tax_rate_id"]];
    [mapping addAttribute:[Estimate dateTimeAttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"duration" andKeyPath:@"duration"]];
    [mapping addAttribute:[Estimate stringAttributeFor:@"starts_at_date" andKeyPath:@"starts_at_date"]];
    [mapping addAttribute:[Estimate stringAttributeFor:@"starts_at_time" andKeyPath:@"starts_at_time"]];
    [mapping addAttribute:[Estimate floatAttributeFor:@"discount" andKeyPath:@"discount"]];
    [mapping addAttribute:[Estimate floatAttributeFor:@"price" andKeyPath:@"price"]];
    [mapping addAttribute:[Estimate floatAttributeFor:@"tax_amount" andKeyPath:@"tax_amount"]];
    [mapping addAttribute:[Estimate floatAttributeFor:@"total" andKeyPath:@"total"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"entity_id" andKeyPath:@"id"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"estimate_number" andKeyPath:@"estimate_number"]];
    [mapping addAttribute:[Estimate intAttributeFor:@"purchase_order_number" andKeyPath:@"purchase_order_number"]];
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"service_route_ids" toKeyPath:@"service_route_ids" map:^id(id value) {
        if ( [value isKindOfClass:NSArray.class]) {
            return (NSArray*)value;
        }
        return value;
    } reverseMap:nil]];
    [mapping addToManyRelationshipMapping:[LineItem defaultMapping] forProperty:@"line_items" keyPath:@"line_items"];
    [mapping addToManyRelationshipMapping:[FWPDFForm defaultMapping] forProperty:@"pdf_forms" keyPath:@"pdf_forms"];
    [mapping addToManyRelationshipMapping:[PDFAttachment defaultMapping] forProperty:@"attachments" keyPath:@"attachments"];
    [mapping addToManyRelationshipMapping:[PhotoAttachment defaultMapping] forProperty:@"photo_attachments" keyPath:@"photo_attachments"];
    mapping.primaryKey = @"entity_id";
    return mapping;
}

+ (FEMMapping *)reverseMappingLineItems{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[LineItem entityName]];
    NSDictionary *appt_mapping_dict = @{
                                        @"entity_id":@"id",
                                        @"payable_id":@"payable_id",
                                        @"payable_type":@"payable_type",
                                        @"lineitem_type":@"type",
                                        @"name":@"name",
                                        @"quantity":@"quantity",
                                        @"price":@"price",
                                        @"total":@"total",
                                        @"taxable":@"taxable",
                                        };
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
}


+ (FEMMapping *)reverseMappingEstimate{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Estimate entityName]];
    NSDictionary *appt_mapping_dict = @{
                                        @"status":@"status",
                                        @"customer_id":@"customer_id",
                                        @"starts_at_date":@"starts_at_date",
                                        @"starts_at_time":@"starts_at_time",
                                        @"notes":@"notes",
                                        @"service_location_id":@"service_location_id",
                                        @"status":@"status",
                                        @"tax_rate_id":@"tax_rate_id",
                                        @"duration":@"duration",
                                        @"price":@"price",
                                        @"tax_amount":@"tax_amount",
                                        @"total":@"total",
                                        @"entity_id":@"id",
                                        @"estimate_number":@"estimate_number",
                                        @"purchase_order_number":@"purchase_order_number",
                                        @"service_route_ids":@"service_route_ids",
                                        };
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    return mapping;
}


- (Customer *)getCustomer {
    return [Customer MR_findFirstByAttribute:@"entity_id" withValue:self.customer_id];
}

- (ServiceLocation*) getServiceLocation
{
    return [ServiceLocation MR_findFirstByAttribute:@"entity_id" withValue:self.service_location_id];
}

- (NSString*)getDurationString
{
    [self getEndTime];
    return [Utils getTimeString:[self.duration intValue]];
}

+ (Estimate*) getById:(NSNumber*)est_id
{
    return [Estimate MR_findFirstByAttribute:@"entity_id" withValue:est_id];
}

-(NSString*)stringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSString* hourComponet=@"hh";
    if (hour<10) {
        hourComponet=@"h";
    }
    NSInteger minute = [components minute];
    NSString* minuteComponet=@":mm";
    if (minute<10) {
        minuteComponet=@":m";
    }
    if (minute==0) {
        minuteComponet=@"";
    }
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"%@%@ a",hourComponet,minuteComponet]];
    return  [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

-(NSString *)startsAtString{

   return  [self stringFromDate:self.starts_at];
}

-(NSString*)endTimeString{
    return  [self stringFromDate:[self getEndTime]];
}

-(NSDate*)getEndTime{
    NSDate *newDate = [self.starts_at dateByAddingTimeInterval:([self.duration integerValue]*60)];
    return newDate;
}

#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    if (request.IsSuccess) {
        if ([request.Tag isEqualToString:API_ESTIMATE] && request.methodType == PUT) {
            NSDictionary *dict = request.serverData;
            if (dict == nil) {
                if (_saved_block) {
                    _saved_block(NO, self.entity_id);
                }
                return;
            }
            NSDictionary *work_order = [dict objectForKey:@"work_order"];
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                Estimate *app = [self MR_inContext:localContext];
//                [localContext MR_deleteObjects:app.line_items];
                [localContext MR_deleteObjects:[app.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    PhotoAttachment *pa = (PhotoAttachment*)evaluatedObject;
                    if ([pa.entity_status isEqualToNumber:c_DELETED]) {
                        return YES;
                    }
                    return NO;
                }]]];
            } completion:^(BOOL contextDidSave, NSError *error) {
                BOOL saved = YES;
                @try {
                    [FEMDeserializer fillObject:self fromRepresentation:work_order mapping:[Estimate defaultMapping]];
                } @catch (NSException *exception) {
                    saved = NO;
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":self.entity_id,
                                                                         @"RequestTag":API_ESTIMATE,
                                                                         @"RequestMethod":@"PUT",
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                } @finally {
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    if (_saved_block) {
                        _saved_block(saved, self.entity_id);
                    }
                }
            }];
        }
        if ([request.Tag isEqualToString:ADD_NEW_ESTIMATE_TAG]) {
            NSDictionary *dict = request.serverData;
            NSDictionary *work_order = [dict objectForKey:@"work_order"];
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                Estimate *app = [self MR_inContext:localContext];
//                [localContext MR_deleteObjects:app.line_items];
                // Delete only deleted object from local database, added and edited records will be updated - see PhotoAttachment class for understanding.
                [localContext MR_deleteObjects:[app.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    PhotoAttachment *pa = (PhotoAttachment*)evaluatedObject;
                    if ([pa.entity_status isEqualToNumber:c_DELETED]) {
                        return YES;
                    }
                    return NO;
                }]]];
            } completion:^(BOOL contextDidSave, NSError *error) {
                BOOL saved = YES;
                @try {
                    [FEMDeserializer fillObject:self fromRepresentation:work_order mapping:[Estimate defaultMapping]];
                } @catch (NSException *exception) {
                    saved = NO;
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":self.entity_id,
                                                                         @"RequestTag":ADD_NEW_ESTIMATE_TAG,
                                                                         @"RequestMethod":@"PUT",
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                } @finally {
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    if (_itemSavedBlock) {
                        _itemSavedBlock(self, saved, nil);
                    }
                }
            }];
        }
    }else{
        if ([request.Tag isEqualToString:API_ESTIMATE] && request.methodType == PUT) {
            if (_saved_block) {
                _saved_block(YES, self.entity_id);
            }
        }
        
        if ([request.Tag isEqualToString:ADD_NEW_ESTIMATE_TAG]) {
            if (_itemSavedBlock) {
                _itemSavedBlock(self, NO, @"Could not save your work order, please try again.");
            }
        }
    }
}

-(void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    if ([request.Tag isEqualToString:API_ESTIMATE] && request.methodType == PUT) {
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        if (_saved_block) {
            _saved_block(NO, self.entity_id);
        }
    }
    if ([request.Tag isEqualToString:ADD_NEW_ESTIMATE_TAG]) {
        if (_itemSavedBlock) {
            _itemSavedBlock(self, NO, @"Could not save your work order, please try again.");
        }
    }
}

-(void)showAlert:(NSString *)error{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

- (float)getTotalServicePrice {
    float total = 0.0;
    if (self.line_items) {
        if (self.line_items.count > 0) {
            for (LineItem *info in self.line_items) {
                if (![info.entity_status isEqualToNumber:c_DELETED]) {
                    total = total + [info.total floatValue];
                }
            }
        }
    }
    return total;
}

- (void) calculateTaxAmount
{
    ServiceLocation *ser_location = [ServiceLocation MR_findFirstByAttribute:c_DATABASE_PRIMARY_KEY_COLUMN_NAME withValue:self.service_location_id];
    if (ser_location.tax_rate_id != 0) {
        TaxRates * trate = [TaxRates MR_findFirstByAttribute:c_DATABASE_PRIMARY_KEY_COLUMN_NAME withValue:ser_location.tax_rate_id];
        if (trate) {
            float totalTax = 0.00;
            float totalDiscount = 0.00;
            for (LineItem * lineItem in self.line_items) {
                if (![lineItem.entity_status isEqualToNumber:c_DELETED])
                {
                    float p = [lineItem.total floatValue];
                    float disc = (p * [self.discount floatValue])/100;
                    totalDiscount = totalDiscount + disc;
                    if ([lineItem.taxable boolValue]) {
                        float tax = ((p-disc) * ([trate.rate floatValue]));
                        totalTax = totalTax + tax;
                    }
                }
            }
            [self setTax_rate_id:trate.entity_id];
            [self setDiscount:[NSNumber numberWithFloat:totalDiscount]];
            [self setTax_amount:[NSNumber numberWithFloat:totalTax]];
            
        }
    }
}

-(float)getTaxableLineItemPrice{
    float total = 0.0;
    if (self.line_items) {
        if (self.line_items.count > 0) {
            for (LineItem *info in self.line_items) {
                if (![info.entity_status isEqualToNumber:c_DELETED]) {
                    if ([info.taxable boolValue]) {
                        total = total + [info.total floatValue];
                    }
                }
            }
        }
    }
    return total;
}

- (float) getFinalTotalDue
{
    ServiceLocation *ser_loc = [self getServiceLocation];
    float total = [self getTotalServicePrice];
    float discount = [self.discount floatValue];

    float discount_amount = ((total * discount) / 100);
    
    float total_due = (total - discount_amount) + self.tax_amountValue;
//    if ([self.specific boolValue] == YES && [ser_loc.hide_balance boolValue] == NO) {
//        total_due = total_due + [self.balance_forward floatValue];
//    }
    return total_due;
}





@end
