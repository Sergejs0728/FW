//
//  Appointment+Helper.m
//  FWModel
//
//  Created by SamirMAC on 11/19/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "Appointment+Helper.h"
#import "Appointment+Mapping.h"
#import "NSDictionary+Extension.h"

#import "InspectionRecord.h"
#import "Invoice.h"
#import "Payment.h"
#import "PhotoAttachment.h"
#import "PDFAttachment.h"
#import "FWPDFForm.h"
#import "FWRequestKit.h"
#import "UnitInspection.h"

@implementation Appointment (Helper)

- (NSMutableDictionary *)newWordOrderJson {
    NSMutableDictionary *work_order_json = [[FEMSerializer serializeObject:self usingMapping:[Appointment reverseMappingNewWorkOrder]] mutableCopy];
    
    // Line Items
    if (self.line_items.count > 0) {
        NSMutableArray *line_items = [[NSMutableArray alloc] init];
        for (LineItem *l_item in self.line_items) {
            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Appointment reverseMappingLineItems]];
                if ([l_item.entity_status isEqualToNumber: c_ADDED]) {
                    l_item_dict = [l_item_dict dictionaryByRemovingId];
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
                
                if((int)(price*10000)%10<49){
                    price = (int)(price*10000) - (int)(price*10000)%100;
                }else{
                    price = (int)(price*10000) - (int)(price*10000)%100 + 100;
                }
                
                float total = [line_items[i][@"total"] floatValue];
                
                if((int)(total*1000)%100<49){
                    total = (int)(total*10000) - (int)(total*1000)%100;
                }else{
                    total = (int)(total*10000) - (int)(total*1000)%100 + 100;
                }
                
                NSString *ttotal = [NSString stringWithFormat:@"%.2f",total/10000];
                NSString *pprice = [NSString stringWithFormat:@"%.2f",price/10000];
                
                
                NSDictionary *line_items_attributes_dic = @{@"name":line_items[i][@"name"],@"payable_id":line_items[i][@"payable_id"],@"payable_type" : line_items[i][@"payable_type"],@"price" : pprice,@"quantity":line_items[i][@"quantity"],@"taxable":line_items[i][@"taxable"], @"total" : ttotal,@"type" : line_items[i][@"type"]};

                [line_items_dic insertObject:line_items_attributes_dic atIndex:i];
                
                
                
                //            [work_order_json setValue:line_items forKey:@"line_items_attributes"];
                
            }
            [work_order_json setValue:line_items_dic forKey:@"line_items_attributes"];
        }
    }
    
    [work_order_json setValue:[NSNumber numberWithBool:NO] forKey:@"callback"];
    [work_order_json setValue:[NSNumber numberWithBool:NO] forKey:@"hide_invoice_information"];
    [work_order_json removeObjectForKey:@"started_at_time"];
    [work_order_json removeObjectForKey:@"finished_at_time"];
    return work_order_json;
}

- (NSMutableDictionary *)workPoolWordOrderJson {
    NSMutableDictionary *work_order_json = [[FEMSerializer serializeObject:self usingMapping:[Appointment reverseMappingWorkOrder]] mutableCopy];
    
    // Line Items
    if (self.line_items.count > 0) {
        NSMutableArray *line_items = [[NSMutableArray alloc] init];
        for (LineItem *l_item in self.line_items) {
            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Appointment reverseMappingLineItems]];
                if ([l_item.entity_status isEqualToNumber: c_ADDED]) {
                    l_item_dict = [l_item_dict dictionaryByRemovingId];
                }
                if (l_item_dict) [line_items addObject:l_item_dict];
            }
        }
        if (line_items.count > 0) {
            [work_order_json setValue:line_items forKey:@"line_items_attributes"];
        }
    }
    
    [work_order_json setValue:[NSNumber numberWithBool:NO] forKey:@"callback"];
    [work_order_json setValue:[NSNumber numberWithBool:NO] forKey:@"hide_invoice_information"];
    [work_order_json setValue:[NSNumber numberWithBool:YES] forKey:@"specific"];
    [work_order_json removeObjectForKey:@"started_at_time"];
    [work_order_json removeObjectForKey:@"finished_at_time"];
    return work_order_json;
}

- (NSMutableDictionary *)buildJson {
    NSMutableDictionary *work_order_json = [[FEMSerializer serializeObject:self usingMapping:[Appointment reverseMappingWorkOrder]] mutableCopy];
    
    // Material Usages
    if(self.material_usages.count > 0){
        NSMutableArray *mat_array = [[NSMutableArray alloc] init];
        mat_array = [MaterialUsage buildJson:self.material_usages];
        if(mat_array.count > 0)
            [work_order_json setValue:mat_array forKey:@"material_usages_attributes"];
    }
    
    // Line Items
    if (self.line_items.count > 0) {
        NSMutableArray *line_items = [[NSMutableArray alloc] init];
        for (LineItem *l_item in self.line_items) {
            if (![l_item.entity_status isEqualToNumber: c_UNCHANGED]) {
                
                NSDictionary *l_item_dict = [FEMSerializer serializeObject:l_item usingMapping:[Appointment reverseMappingLineItems]];
                
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
                
                if((int)(price*10000)%10<49){
                    price = (int)(price*10000) - (int)(price*10000)%100;
                }else{
                    price = (int)(price*10000) - (int)(price*10000)%100 + 100;
                }
                
                float total = [line_items[i][@"total"] floatValue];
                
                if((int)(total*10000)%100<49){
                    total = (int)(total*10000) - (int)(total*1000)%100;
                }else{
                    total = (int)(total*10000) - (int)(total*1000)%100 + 100;
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
    
    // Inspection Records
    if (self.inspection_records.count > 0) {
        NSMutableArray *ins_array = [[NSMutableArray alloc] init];
        for (InspectionRecord *ir in self.inspection_records) {
            NSMutableDictionary *ir_dict = [ir buildJson];
            CustomerDevice *device = [CustomerDevice deviceByBarcode:ir.barcode andService_location:self.service_location_id];
            if ([device.entity_status isEqualToNumber:c_UNCHANGED]) {
                ir_dict[@"trap_id"] = device.entity_id;
            }
            if (ir_dict) [ins_array addObject:ir_dict];
        }
        if(ins_array.count > 0)
            [work_order_json setValue:ins_array forKey:@"inspection_records_attributes"];
        
//        NSMutableArray *ins_array = [[NSMutableArray alloc] init];
//        for (InspectionRecord *ir in self.inspection_records) {
//            if (![ir.entity_status isEqualToNumber: c_UNCHANGED]) {
//                NSDictionary *ir_dict = [FEMSerializer serializeObject:ir usingMapping:[Appointment reverseMappingInspectionRecords]];
//                if ([ir.entity_status isEqualToNumber: c_ADDED]) {
//                    // Remove all ids from all nested disctionary because we are adding new record
//                    ir_dict = [ir_dict dictionaryByRemovingId];
//                } else if ([ir.entity_status isEqualToNumber: c_DELETED]) {
//                    // deleteing the record from server
//                    ir_dict = [[NSMutableDictionary alloc] init];
//                    [ir_dict setValue:ir.entity_id forKey:@"id"];
//                    [ir_dict setValue:[NSNumber numberWithBool:YES] forKey:@"_destroy"];
//                } else {
//                    // Edit record - Only sending changed records will not work as it has many nested objects. So we will keep the old method to delete existing
//                    if (ir.entity_idValue > 0) {
//                        ir_dict = [ir_dict dictionaryByRemovingId];
//                        NSMutableDictionary *delete_existing = [[[NSDictionary alloc] initWithDestroy:ir.entity_id] mutableCopy];
//                        [delete_existing setValue:ir.barcode forKey:@"barcode"];
//                        if (delete_existing) [ins_array addObject:delete_existing];
//                    }
//                }
//                
//                CustomerDevice *device = [CustomerDevice deviceByBarcode:ir.barcode andService_location:[self.service_location_id intValue]];
//                if ([device.entity_status isEqualToNumber:c_UNCHANGED]) {
//                    NSMutableDictionary *temp = [ir_dict mutableCopy];
//                    [temp setValue:device.entity_id forKey:@"trap_id"];
//                    ir_dict = [NSDictionary dictionaryWithDictionary:temp];
//                }
//                if (ir_dict) [ins_array addObject:ir_dict];
//            }
//        }
//        if(ins_array.count > 0)
//            [work_order_json setValue:ins_array forKey:@"inspection_records_attributes"];
    }
    
    // Devices
    
    //        if ([device.entity_status isEqualToNumber:c_ADDED]) {
    //                            [device saveCustomerDeviceToServer:^(id item, BOOL is_success, NSString *error) {
    //
    //                            }];
    //                        }
    
    // Unit Inspection Records
    if (self.unit_records.count > 0) {
        NSMutableArray *ins_array = [[NSMutableArray alloc] init];
        for (UnitInspection *ir in self.unit_records) {
            NSMutableDictionary *ir_dict = [ir buildJson];
            if (ir_dict) [ins_array addObject:ir_dict];
        }
        if(ins_array.count > 0)
            [work_order_json setValue:ins_array forKey:@"unit_records_attributes"];
    }

    
    // Invoice
    // The if condition is commented because there is a bug where if user dont change the work order to completed and sync the payment is deleted. So we sync payment all the time.
    //if([self.status isEqualToString:wo_STATUS_COMPLETE]){
        NSDictionary *inv_dict = [FEMSerializer serializeObject:self.invoice usingMapping:[Appointment reverseMappingInvoice]];
        if (self.invoice && self.invoice.payments) {
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"created_from_mobile == %@", [NSNumber numberWithBool:YES]];
            NSSet *filtered_payments = [self.invoice.payments filteredSetUsingPredicate:pre];
            if (filtered_payments && filtered_payments.count > 0) {
                Payment *payment = [[filtered_payments objectEnumerator] nextObject];
                NSDictionary *payment_dict = [FEMSerializer serializeObject:payment usingMapping:[Appointment reverseMappingPayment]];
                if ([payment.entity_id intValue] <= 0) {
                    payment_dict = [payment_dict dictionaryByRemovingId];
                }
                [inv_dict setValue:@[payment_dict] forKey:@"payments_attributes"];
                [work_order_json setValue:inv_dict forKey:@"invoice_attributes"];
            }
        }
    
    //}
    
    // Upload Photos , Upload pdf attachments
    // Delete photos
    if (self.photo_attachments) {
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"entity_status == %@", c_DELETED];
        NSSet *filtered = [self.photo_attachments filteredSetUsingPredicate:pre];
        if (filtered && filtered.count > 0) {
            NSMutableArray *deleted_photos = [[NSMutableArray alloc] init];
            for (PhotoAttachment *pa in filtered) {
                NSDictionary *photo_dict = [[NSDictionary alloc] initWithDestroy:pa.entity_id];
                if (photo_dict) [deleted_photos addObject:photo_dict];
            }
            [work_order_json setValue:deleted_photos forKey:@"photo_attachments_attributes"];
        }
        /*
        NSSet *added = [self.photo_attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            PhotoAttachment *pa = (PhotoAttachment*) evaluatedObject;
            if ([pa.entity_status isEqualToNumber:c_ADDED] || [pa.entity_status isEqualToNumber:c_EDITED]) {
                return YES;
            }
            return NO;
        }]];
        if (added && added.count > 0) {
            for (PhotoAttachment *pa in added) {
                [pa upload];
            }
        }
         */
    }
    // PDF Attachment are syncing separatly from appointment
    /*
    // PDF Attachment - We dont need to filter for delete as app does not allow user to delete any PDF Attachment
    if (self.attachments) {
        NSSet *added = [self.attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            PDFAttachment *pa = (PDFAttachment*) evaluatedObject;
            if ([pa.entity_status isEqualToNumber:c_ADDED] || [pa.entity_status isEqualToNumber:c_EDITED]) {
                return YES;
            }
            return NO;
        }]];
        if (added && added.count > 0) {
            for (PDFAttachment *pa in added) {
                NSNumber* pdfFormId = pa.pdf_form_id;
                NSSet* forms=[self.pdf_forms filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                    FWPDFForm *pdfForm = (FWPDFForm*) evaluatedObject;
                    if ([pdfForm.entity_id isEqual:pdfFormId]){
                        return YES;
                    }
                    return NO;
                }]];
                if(forms){
                    if (forms.count>0) {
                        FWPDFForm *pdfForm=[[forms allObjects] objectAtIndex:0];
                        if (pdfForm) {
                            if (pdfForm.use_acrobatValue) {
                                [pa uploadWithPDFid:[NSString stringWithFormat:@"%@", pdfForm.entity_id]];
                            }
                        }
                    }
                    
                }
            }
        }
    }
    */
    
    return work_order_json;
}

- (void) downloadServiceReportWithBlock:(TaskCompleted)block
{
    //NSString *url = [NSString stringWithFormat:@"%@work_orders/%d/service_report.pdf?api_key=%@",FIELD_WORK_URL_BASE,self.Id ,[AccountManager Instance].activeAccount.api_key];
    
    NSString *url_part = [NSString stringWithFormat:API_SERVICE_REPORT, self.entity_id];
    NSString *file_to_save = [Appointment ServiceReportPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:file_to_save] && [[NSFileManager defaultManager] isDeletableFileAtPath:file_to_save]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:file_to_save error:&error];
        if (error) {
            NSLog(@"Error deleting service report : %@", error);
        }
    }
    [FWRequest downloadFile:url_part saveToFilePath:file_to_save withCompletionBlock:^(FWRequest *request) {
        if (request.IsSuccess) {
            if (block) {
                block(file_to_save, YES);
            }
        } else {
            if (block) {
                block(nil, NO);
            }
        }
    }];
}

@end
