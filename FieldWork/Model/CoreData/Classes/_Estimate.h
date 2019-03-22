// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Estimate.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PDFAttachment;
@class LineItem;
@class FWPDFForm;
@class PhotoAttachment;

@class NSObject;

@interface EstimateID : NSManagedObjectID {}
@end

@interface _Estimate : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EstimateID *objectID;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* customer_id;

@property (atomic) int32_t customer_idValue;
- (int32_t)customer_idValue;
- (void)setCustomer_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* discount;

@property (atomic) float discountValue;
- (float)discountValue;
- (void)setDiscountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* duration;

@property (atomic) int32_t durationValue;
- (int32_t)durationValue;
- (void)setDurationValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* estimate_number;

@property (atomic) int32_t estimate_numberValue;
- (int32_t)estimate_numberValue;
- (void)setEstimate_numberValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* expires_on;

@property (nonatomic, strong, nullable) NSDate* issued_on;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSNumber* price;

@property (atomic) float priceValue;
- (float)priceValue;
- (void)setPriceValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* purchase_order_number;

@property (atomic) int32_t purchase_order_numberValue;
- (int32_t)purchase_order_numberValue;
- (void)setPurchase_order_numberValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* service_location_id;

@property (atomic) int32_t service_location_idValue;
- (int32_t)service_location_idValue;
- (void)setService_location_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) id service_route_ids;

@property (nonatomic, strong, nullable) NSDate* starts_at;

@property (nonatomic, strong, nullable) NSString* starts_at_date;

@property (nonatomic, strong, nullable) NSString* starts_at_time;

@property (nonatomic, strong, nullable) NSString* status;

@property (nonatomic, strong, nullable) NSNumber* tax_amount;

@property (atomic) float tax_amountValue;
- (float)tax_amountValue;
- (void)setTax_amountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* tax_rate_id;

@property (atomic) int32_t tax_rate_idValue;
- (int32_t)tax_rate_idValue;
- (void)setTax_rate_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* total;

@property (atomic) float totalValue;
- (float)totalValue;
- (void)setTotalValue:(float)value_;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) NSSet<PDFAttachment*> *attachments;
- (nullable NSMutableSet<PDFAttachment*>*)attachmentsSet;

@property (nonatomic, strong, nullable) NSOrderedSet<LineItem*> *line_items;
- (nullable NSMutableOrderedSet<LineItem*>*)line_itemsSet;

@property (nonatomic, strong, nullable) NSSet<FWPDFForm*> *pdf_forms;
- (nullable NSMutableSet<FWPDFForm*>*)pdf_formsSet;

@property (nonatomic, strong, nullable) NSSet<PhotoAttachment*> *photo_attachments;
- (nullable NSMutableSet<PhotoAttachment*>*)photo_attachmentsSet;

@end

@interface _Estimate (AttachmentsCoreDataGeneratedAccessors)
- (void)addAttachments:(NSSet<PDFAttachment*>*)value_;
- (void)removeAttachments:(NSSet<PDFAttachment*>*)value_;
- (void)addAttachmentsObject:(PDFAttachment*)value_;
- (void)removeAttachmentsObject:(PDFAttachment*)value_;

@end

@interface _Estimate (Line_itemsCoreDataGeneratedAccessors)
- (void)addLine_items:(NSOrderedSet<LineItem*>*)value_;
- (void)removeLine_items:(NSOrderedSet<LineItem*>*)value_;
- (void)addLine_itemsObject:(LineItem*)value_;
- (void)removeLine_itemsObject:(LineItem*)value_;

- (void)insertObject:(LineItem*)value inLine_itemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLine_itemsAtIndex:(NSUInteger)idx;
- (void)insertLine_items:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLine_itemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLine_itemsAtIndex:(NSUInteger)idx withObject:(LineItem*)value;
- (void)replaceLine_itemsAtIndexes:(NSIndexSet *)indexes withLine_items:(NSArray *)values;

@end

@interface _Estimate (Pdf_formsCoreDataGeneratedAccessors)
- (void)addPdf_forms:(NSSet<FWPDFForm*>*)value_;
- (void)removePdf_forms:(NSSet<FWPDFForm*>*)value_;
- (void)addPdf_formsObject:(FWPDFForm*)value_;
- (void)removePdf_formsObject:(FWPDFForm*)value_;

@end

@interface _Estimate (Photo_attachmentsCoreDataGeneratedAccessors)
- (void)addPhoto_attachments:(NSSet<PhotoAttachment*>*)value_;
- (void)removePhoto_attachments:(NSSet<PhotoAttachment*>*)value_;
- (void)addPhoto_attachmentsObject:(PhotoAttachment*)value_;
- (void)removePhoto_attachmentsObject:(PhotoAttachment*)value_;

@end

@interface _Estimate (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveCustomer_id;
- (void)setPrimitiveCustomer_id:(nullable NSNumber*)value;

- (int32_t)primitiveCustomer_idValue;
- (void)setPrimitiveCustomer_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveDiscount;
- (void)setPrimitiveDiscount:(nullable NSNumber*)value;

- (float)primitiveDiscountValue;
- (void)setPrimitiveDiscountValue:(float)value_;

- (nullable NSNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(nullable NSNumber*)value;

- (int32_t)primitiveDurationValue;
- (void)setPrimitiveDurationValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEstimate_number;
- (void)setPrimitiveEstimate_number:(nullable NSNumber*)value;

- (int32_t)primitiveEstimate_numberValue;
- (void)setPrimitiveEstimate_numberValue:(int32_t)value_;

- (nullable NSDate*)primitiveExpires_on;
- (void)setPrimitiveExpires_on:(nullable NSDate*)value;

- (nullable NSDate*)primitiveIssued_on;
- (void)setPrimitiveIssued_on:(nullable NSDate*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(nullable NSNumber*)value;

- (float)primitivePriceValue;
- (void)setPrimitivePriceValue:(float)value_;

- (nullable NSNumber*)primitivePurchase_order_number;
- (void)setPrimitivePurchase_order_number:(nullable NSNumber*)value;

- (int32_t)primitivePurchase_order_numberValue;
- (void)setPrimitivePurchase_order_numberValue:(int32_t)value_;

- (nullable NSNumber*)primitiveService_location_id;
- (void)setPrimitiveService_location_id:(nullable NSNumber*)value;

- (int32_t)primitiveService_location_idValue;
- (void)setPrimitiveService_location_idValue:(int32_t)value_;

- (nullable id)primitiveService_route_ids;
- (void)setPrimitiveService_route_ids:(nullable id)value;

- (nullable NSDate*)primitiveStarts_at;
- (void)setPrimitiveStarts_at:(nullable NSDate*)value;

- (nullable NSString*)primitiveStarts_at_date;
- (void)setPrimitiveStarts_at_date:(nullable NSString*)value;

- (nullable NSString*)primitiveStarts_at_time;
- (void)setPrimitiveStarts_at_time:(nullable NSString*)value;

- (nullable NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(nullable NSString*)value;

- (nullable NSNumber*)primitiveTax_amount;
- (void)setPrimitiveTax_amount:(nullable NSNumber*)value;

- (float)primitiveTax_amountValue;
- (void)setPrimitiveTax_amountValue:(float)value_;

- (nullable NSNumber*)primitiveTax_rate_id;
- (void)setPrimitiveTax_rate_id:(nullable NSNumber*)value;

- (int32_t)primitiveTax_rate_idValue;
- (void)setPrimitiveTax_rate_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTotal;
- (void)setPrimitiveTotal:(nullable NSNumber*)value;

- (float)primitiveTotalValue;
- (void)setPrimitiveTotalValue:(float)value_;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (NSMutableSet<PDFAttachment*>*)primitiveAttachments;
- (void)setPrimitiveAttachments:(NSMutableSet<PDFAttachment*>*)value;

- (NSMutableOrderedSet<LineItem*>*)primitiveLine_items;
- (void)setPrimitiveLine_items:(NSMutableOrderedSet<LineItem*>*)value;

- (NSMutableSet<FWPDFForm*>*)primitivePdf_forms;
- (void)setPrimitivePdf_forms:(NSMutableSet<FWPDFForm*>*)value;

- (NSMutableSet<PhotoAttachment*>*)primitivePhoto_attachments;
- (void)setPrimitivePhoto_attachments:(NSMutableSet<PhotoAttachment*>*)value;

@end

@interface EstimateAttributes: NSObject 
+ (NSString *)created_at;
+ (NSString *)customer_id;
+ (NSString *)discount;
+ (NSString *)duration;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)estimate_number;
+ (NSString *)expires_on;
+ (NSString *)issued_on;
+ (NSString *)notes;
+ (NSString *)price;
+ (NSString *)purchase_order_number;
+ (NSString *)service_location_id;
+ (NSString *)service_route_ids;
+ (NSString *)starts_at;
+ (NSString *)starts_at_date;
+ (NSString *)starts_at_time;
+ (NSString *)status;
+ (NSString *)tax_amount;
+ (NSString *)tax_rate_id;
+ (NSString *)total;
+ (NSString *)updated_at;
@end

@interface EstimateRelationships: NSObject
+ (NSString *)attachments;
+ (NSString *)line_items;
+ (NSString *)pdf_forms;
+ (NSString *)photo_attachments;
@end

NS_ASSUME_NONNULL_END
