//
//  Appointment+Mapping.m
//  FWModel
//
//  Created by SamirMAC on 11/16/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "Appointment+Mapping.h"
#import "CDHelper.h"
#import "NSManagedObject+Mapping.h"
#import "FWPDFForm.h"
#import "PDFAttachment.h"
#import "PhotoAttachment.h"
#import "InspectionRecord.h"
#import "InspectionPest.h"
#import "Invoice.h"
#import "Payment.h"
#import "NSDate+Extentsion.h"
#import "UnitInspection.h"

@implementation Appointment (Mapping)

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Appointment entityName]];
    NSMutableDictionary *appt_mapping_dict = [[CDHelper mappingForClass:[Appointment class]] mutableCopy];
    
    [appt_mapping_dict removeObjectForKey:@"balance_forward"];
    [appt_mapping_dict removeObjectForKey:@"tax_amount"];
    [appt_mapping_dict removeObjectForKey:@"discount"];
    [appt_mapping_dict removeObjectForKey:@"discount_amount"];
    [appt_mapping_dict removeObjectForKey:@"confirmed"];
    [appt_mapping_dict removeObjectForKey:@"starts_at"];
    [appt_mapping_dict removeObjectForKey:@"ends_at"];
//    [appt_mapping_dict removeObjectForKey:@"starts_at_time"];
//    [appt_mapping_dict removeObjectForKey:@"ends_at_time"];
    [appt_mapping_dict removeObjectForKey:@"worker_lng"];
    [appt_mapping_dict removeObjectForKey:@"worker_lat"];
    
    
    [appt_mapping_dict setValue:@"entity_status" forKey:@"entity_status"];
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
    [mapping addToManyRelationshipMapping:[LineItem defaultMapping] forProperty:@"line_items" keyPath:@"line_items"];
    [mapping addToManyRelationshipMapping:[MaterialUsage defaultMapping] forProperty:@"material_usages" keyPath:@"material_usages"];
    [mapping addToManyRelationshipMapping:[FWPDFForm defaultMapping] forProperty:@"pdf_forms" keyPath:@"pdf_forms"];
    [mapping addToManyRelationshipMapping:[PDFAttachment defaultMapping] forProperty:@"attachments" keyPath:@"attachments"];
    [mapping addToManyRelationshipMapping:[PhotoAttachment defaultMapping] forProperty:@"photo_attachments" keyPath:@"photo_attachments"];
    [mapping addToManyRelationshipMapping:[InspectionRecord defaultMapping] forProperty:@"inspection_records" keyPath:@"inspection_records"];
    [mapping addToManyRelationshipMapping:[UnitInspection defaultMapping] forProperty:@"unit_records" keyPath:@"unit_records"];
    [mapping addRelationshipMapping:[Invoice defaultMapping] forProperty:@"invoice" keyPath:@"invoice"];
    [mapping addRelationshipMapping:[TaxRates defaultMapping] forProperty:@"tax_rate" keyPath:@"tax_rate"];
    [mapping addToManyRelationshipMapping:[Unit defaultMapping] forProperty:@"flats" keyPath:@"flats"];

    [mapping addAttribute:[Appointment floatAttributeFor:@"balance_forward" andKeyPath:@"balance_forward"]];
    [mapping addAttribute:[Appointment floatAttributeFor:@"tax_amount" andKeyPath:@"tax_amount"]];
    [mapping addAttribute:[Appointment floatAttributeFor:@"discount" andKeyPath:@"discount"]];
    [mapping addAttribute:[Appointment floatAttributeFor:@"discount_amount" andKeyPath:@"discount_amount"]];
    [mapping addAttribute:[Appointment boolAttributeFor:@"confirmed" andKeyPath:@"confirmed"]];
    [mapping addAttribute:[Appointment dateTimeAttributeFor:@"starts_at" andKeyPath:@"starts_at"]];
    [mapping addAttribute:[Appointment dateTimeAttributeFor:@"ends_at" andKeyPath:@"ends_at"]];
//    [mapping addAttribute:[Appointment timeAttributeFor:@"starts_at_time" andKeyPath:@"starts_at_time"]];
//    [mapping addAttribute:[Appointment timeAttributeFor:@"ends_at_time" andKeyPath:@"ends_at_time"]];
    [mapping addAttribute:[Appointment doubleAttributeFor:@"worker_lng" andKeyPath:@"worker_lng"]];
    [mapping addAttribute:[Appointment doubleAttributeFor:@"worker_lat" andKeyPath:@"worker_lat"]];
    
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (FEMMapping *) reverseMappingNewWorkOrder
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Appointment entityName]];
    NSDictionary *appt_mapping_dict = @{@"status":@"status",
                                        @"service_location_id":@"service_location_id",
                                        @"customer_id":@"customer_id",
                                        @"starts_at_date":@"starts_at_date",
                                        @"starts_at_time":@"starts_at_time",
                                        @"ends_at_time":@"ends_at_time",
                                        @"duration":@"duration",
                                        @"discount":@"discount",
                                        @"tax_amount":@"tax_amount",
                                        @"purchase_order_no":@"purchase_order_no",
                                        @"instructions":@"instructions",
                                        @"service_route_ids":@"service_route_ids"
                                        };
    
    

    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
    return mapping;
    
}

+ (FEMMapping *)reverseMappingWorkOrder {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Appointment entityName]];
    NSDictionary *appt_mapping_dict = @{@"worker_lat":@"worker_lat",
                                        @"worker_lng":@"worker_lng",
                                        @"status":@"status",
                                        @"starts_at_date":@"starts_at_date",
                                        @"started_at_time":@"started_at_time",
                                        @"starts_at_time":@"starts_at_time",
                                        @"ends_at_time":@"ends_at_time",
                                        @"finished_at_time":@"finished_at_time",
                                        @"customer_signature":@"customer_signature",
                                        @"technician_signature":@"technician_signature",
                                        @"square_feet":@"square_feet",
                                        @"wind_direction":@"wind_direction",
                                        @"wind_speed":@"wind_speed",
                                        @"temperature":@"temperature",
                                        @"discount":@"discount",
                                        @"tax_amount":@"tax_amount",
                                        @"notes":@"notes",
                                        @"private_notes":@"private_notes",
                                        @"recommendation_ids":@"recommendation_ids",
                                        @"appointment_condition_ids":@"appointment_condition_ids",
                                        @"specific":@"specific",
                                        @"tax_rate_id":@"tax_rate_id",
                                        @"instructions":@"instructions"
                                        };
    
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
    return mapping;
}

+ (FEMMapping *)reverseMappingInvoice{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Invoice entityName]];
    NSDictionary *appt_mapping_dict = @{};
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
    return mapping;
}

+ (FEMMapping *)reverseMappingPayment {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[Payment entityName]];
    NSDictionary *appt_mapping_dict = @{@"entity_id":@"id",
                                        @"amount":@"amount",
                                        @"created_from_mobile":@"created_from_mobile",
                                        @"payment_method":@"payment_method",
                                        @"check_number":@"check_number"
//                                        @"payments_attributes":@"payments_attributes",
                                        };
    
    
    [mapping addAttributesFromDictionary:appt_mapping_dict];
    
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"payment_date" toKeyPath:@"payment_date" dateFormat:@"MM/dd/yyyy"]];
    
    return mapping;
}


+ (FEMMapping *)reverseMappingLineItems{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[LineItem entityName]];
    NSDictionary *appt_mapping_dict = @{@"entity_id":@"id",
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

@end
