// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Appointment.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PDFAttachment;
@class InspectionRecord;
@class Invoice;
@class LineItem;
@class MaterialUsage;
@class FWPDFForm;
@class PhotoAttachment;
@class TaxRates;
@class UnitInspection;

@class NSObject;

@class NSObject;

@class NSObject;

@class NSObject;

@interface AppointmentID : NSManagedObjectID {}
@end

@interface _Appointment : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AppointmentID *objectID;

@property (nonatomic, strong, nullable) id appointment_condition_ids;

@property (nonatomic, strong, nullable) NSString* arrival_time_end;

@property (nonatomic, strong, nullable) NSString* arrival_time_start;

@property (nonatomic, strong) NSNumber* auto_generates_invoice;

@property (atomic) BOOL auto_generates_invoiceValue;
- (BOOL)auto_generates_invoiceValue;
- (void)setAuto_generates_invoiceValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* balance_forward;

@property (atomic) float balance_forwardValue;
- (float)balance_forwardValue;
- (void)setBalance_forwardValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* callback;

@property (atomic) BOOL callbackValue;
- (BOOL)callbackValue;
- (void)setCallbackValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* confirmed;

@property (atomic) BOOL confirmedValue;
- (BOOL)confirmedValue;
- (void)setConfirmedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* confirmed_by;

@property (nonatomic, strong, nullable) id corrective_action_ids;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* customer_id;

@property (atomic) int32_t customer_idValue;
- (int32_t)customer_idValue;
- (void)setCustomer_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* customer_signature;

@property (nonatomic, strong, nullable) NSNumber* discount;

@property (atomic) float discountValue;
- (float)discountValue;
- (void)setDiscountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* discount_amount;

@property (atomic) float discount_amountValue;
- (float)discount_amountValue;
- (void)setDiscount_amountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* duration;

@property (atomic) float durationValue;
- (float)durationValue;
- (void)setDurationValue:(float)value_;

@property (nonatomic, strong, nullable) NSDate* ends_at;

@property (nonatomic, strong, nullable) NSString* ends_at_date;

@property (nonatomic, strong, nullable) NSString* ends_at_time;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* error_sync_message;

@property (nonatomic, strong, nullable) NSString* finished_at_time;

@property (nonatomic, strong, nullable) NSNumber* hide_invoice_information;

@property (atomic) BOOL hide_invoice_informationValue;
- (BOOL)hide_invoice_informationValue;
- (void)setHide_invoice_informationValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* instructions;

@property (nonatomic, strong, nullable) NSNumber* is_editing_now;

@property (atomic) BOOL is_editing_nowValue;
- (BOOL)is_editing_nowValue;
- (void)setIs_editing_nowValue:(BOOL)value_;

@property (nonatomic, strong) NSNumber* is_sync;

@property (atomic) BOOL is_syncValue;
- (BOOL)is_syncValue;
- (void)setIs_syncValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSDate* last_sync_date;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* private_notes;

@property (nonatomic, strong, nullable) NSString* purchase_order_no;

@property (nonatomic, strong, nullable) id recommendation_ids;

@property (nonatomic, strong, nullable) NSNumber* report_number;

@property (atomic) int32_t report_numberValue;
- (int32_t)report_numberValue;
- (void)setReport_numberValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* service_location_id;

@property (atomic) int32_t service_location_idValue;
- (int32_t)service_location_idValue;
- (void)setService_location_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) id service_route_ids;

@property (nonatomic, strong, nullable) NSNumber* specific;

@property (atomic) BOOL specificValue;
- (BOOL)specificValue;
- (void)setSpecificValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* square_feet;

@property (nonatomic, strong, nullable) NSString* started_at_time;

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

@property (nonatomic, strong, nullable) NSString* technician_signature;

@property (nonatomic, strong, nullable) NSString* technician_signature_name;

@property (nonatomic, strong, nullable) NSString* temperature;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) NSString* wind_direction;

@property (nonatomic, strong, nullable) NSString* wind_speed;

@property (nonatomic, strong, nullable) NSNumber* worker_lat;

@property (atomic) double worker_latValue;
- (double)worker_latValue;
- (void)setWorker_latValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* worker_lng;

@property (atomic) double worker_lngValue;
- (double)worker_lngValue;
- (void)setWorker_lngValue:(double)value_;

@property (nonatomic, strong, nullable) NSSet<PDFAttachment*> *attachments;
- (nullable NSMutableSet<PDFAttachment*>*)attachmentsSet;

@property (nonatomic, strong, nullable) NSSet<InspectionRecord*> *inspection_records;
- (nullable NSMutableSet<InspectionRecord*>*)inspection_recordsSet;

@property (nonatomic, strong, nullable) Invoice *invoice;

@property (nonatomic, strong, nullable) NSOrderedSet<LineItem*> *line_items;
- (nullable NSMutableOrderedSet<LineItem*>*)line_itemsSet;

@property (nonatomic, strong, nullable) NSSet<MaterialUsage*> *material_usages;
- (nullable NSMutableSet<MaterialUsage*>*)material_usagesSet;

@property (nonatomic, strong, nullable) NSSet<FWPDFForm*> *pdf_forms;
- (nullable NSMutableSet<FWPDFForm*>*)pdf_formsSet;

@property (nonatomic, strong, nullable) NSSet<PhotoAttachment*> *photo_attachments;
- (nullable NSMutableSet<PhotoAttachment*>*)photo_attachmentsSet;

@property (nonatomic, strong, nullable) TaxRates *tax_rate;

@property (nonatomic, strong, nullable) NSSet<UnitInspection*> *unit_records;
- (nullable NSMutableSet<UnitInspection*>*)unit_recordsSet;

@end

@interface _Appointment (AttachmentsCoreDataGeneratedAccessors)
- (void)addAttachments:(NSSet<PDFAttachment*>*)value_;
- (void)removeAttachments:(NSSet<PDFAttachment*>*)value_;
- (void)addAttachmentsObject:(PDFAttachment*)value_;
- (void)removeAttachmentsObject:(PDFAttachment*)value_;

@end

@interface _Appointment (Inspection_recordsCoreDataGeneratedAccessors)
- (void)addInspection_records:(NSSet<InspectionRecord*>*)value_;
- (void)removeInspection_records:(NSSet<InspectionRecord*>*)value_;
- (void)addInspection_recordsObject:(InspectionRecord*)value_;
- (void)removeInspection_recordsObject:(InspectionRecord*)value_;

@end

@interface _Appointment (Line_itemsCoreDataGeneratedAccessors)
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

@interface _Appointment (Material_usagesCoreDataGeneratedAccessors)
- (void)addMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)removeMaterial_usages:(NSSet<MaterialUsage*>*)value_;
- (void)addMaterial_usagesObject:(MaterialUsage*)value_;
- (void)removeMaterial_usagesObject:(MaterialUsage*)value_;

@end

@interface _Appointment (Pdf_formsCoreDataGeneratedAccessors)
- (void)addPdf_forms:(NSSet<FWPDFForm*>*)value_;
- (void)removePdf_forms:(NSSet<FWPDFForm*>*)value_;
- (void)addPdf_formsObject:(FWPDFForm*)value_;
- (void)removePdf_formsObject:(FWPDFForm*)value_;

@end

@interface _Appointment (Photo_attachmentsCoreDataGeneratedAccessors)
- (void)addPhoto_attachments:(NSSet<PhotoAttachment*>*)value_;
- (void)removePhoto_attachments:(NSSet<PhotoAttachment*>*)value_;
- (void)addPhoto_attachmentsObject:(PhotoAttachment*)value_;
- (void)removePhoto_attachmentsObject:(PhotoAttachment*)value_;

@end

@interface _Appointment (Unit_recordsCoreDataGeneratedAccessors)
- (void)addUnit_records:(NSSet<UnitInspection*>*)value_;
- (void)removeUnit_records:(NSSet<UnitInspection*>*)value_;
- (void)addUnit_recordsObject:(UnitInspection*)value_;
- (void)removeUnit_recordsObject:(UnitInspection*)value_;

@end

@interface _Appointment (CoreDataGeneratedPrimitiveAccessors)

- (nullable id)primitiveAppointment_condition_ids;
- (void)setPrimitiveAppointment_condition_ids:(nullable id)value;

- (nullable NSString*)primitiveArrival_time_end;
- (void)setPrimitiveArrival_time_end:(nullable NSString*)value;

- (nullable NSString*)primitiveArrival_time_start;
- (void)setPrimitiveArrival_time_start:(nullable NSString*)value;

- (NSNumber*)primitiveAuto_generates_invoice;
- (void)setPrimitiveAuto_generates_invoice:(NSNumber*)value;

- (BOOL)primitiveAuto_generates_invoiceValue;
- (void)setPrimitiveAuto_generates_invoiceValue:(BOOL)value_;

- (nullable NSNumber*)primitiveBalance_forward;
- (void)setPrimitiveBalance_forward:(nullable NSNumber*)value;

- (float)primitiveBalance_forwardValue;
- (void)setPrimitiveBalance_forwardValue:(float)value_;

- (nullable NSNumber*)primitiveCallback;
- (void)setPrimitiveCallback:(nullable NSNumber*)value;

- (BOOL)primitiveCallbackValue;
- (void)setPrimitiveCallbackValue:(BOOL)value_;

- (nullable NSNumber*)primitiveConfirmed;
- (void)setPrimitiveConfirmed:(nullable NSNumber*)value;

- (BOOL)primitiveConfirmedValue;
- (void)setPrimitiveConfirmedValue:(BOOL)value_;

- (nullable NSString*)primitiveConfirmed_by;
- (void)setPrimitiveConfirmed_by:(nullable NSString*)value;

- (nullable id)primitiveCorrective_action_ids;
- (void)setPrimitiveCorrective_action_ids:(nullable id)value;

- (nullable NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveCustomer_id;
- (void)setPrimitiveCustomer_id:(nullable NSNumber*)value;

- (int32_t)primitiveCustomer_idValue;
- (void)setPrimitiveCustomer_idValue:(int32_t)value_;

- (nullable NSString*)primitiveCustomer_signature;
- (void)setPrimitiveCustomer_signature:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDiscount;
- (void)setPrimitiveDiscount:(nullable NSNumber*)value;

- (float)primitiveDiscountValue;
- (void)setPrimitiveDiscountValue:(float)value_;

- (nullable NSNumber*)primitiveDiscount_amount;
- (void)setPrimitiveDiscount_amount:(nullable NSNumber*)value;

- (float)primitiveDiscount_amountValue;
- (void)setPrimitiveDiscount_amountValue:(float)value_;

- (nullable NSNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(nullable NSNumber*)value;

- (float)primitiveDurationValue;
- (void)setPrimitiveDurationValue:(float)value_;

- (nullable NSDate*)primitiveEnds_at;
- (void)setPrimitiveEnds_at:(nullable NSDate*)value;

- (nullable NSString*)primitiveEnds_at_date;
- (void)setPrimitiveEnds_at_date:(nullable NSString*)value;

- (nullable NSString*)primitiveEnds_at_time;
- (void)setPrimitiveEnds_at_time:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveError_sync_message;
- (void)setPrimitiveError_sync_message:(nullable NSString*)value;

- (nullable NSString*)primitiveFinished_at_time;
- (void)setPrimitiveFinished_at_time:(nullable NSString*)value;

- (nullable NSNumber*)primitiveHide_invoice_information;
- (void)setPrimitiveHide_invoice_information:(nullable NSNumber*)value;

- (BOOL)primitiveHide_invoice_informationValue;
- (void)setPrimitiveHide_invoice_informationValue:(BOOL)value_;

- (nullable NSString*)primitiveInstructions;
- (void)setPrimitiveInstructions:(nullable NSString*)value;

- (nullable NSNumber*)primitiveIs_editing_now;
- (void)setPrimitiveIs_editing_now:(nullable NSNumber*)value;

- (BOOL)primitiveIs_editing_nowValue;
- (void)setPrimitiveIs_editing_nowValue:(BOOL)value_;

- (NSNumber*)primitiveIs_sync;
- (void)setPrimitiveIs_sync:(NSNumber*)value;

- (BOOL)primitiveIs_syncValue;
- (void)setPrimitiveIs_syncValue:(BOOL)value_;

- (nullable NSDate*)primitiveLast_sync_date;
- (void)setPrimitiveLast_sync_date:(nullable NSDate*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSString*)primitivePrivate_notes;
- (void)setPrimitivePrivate_notes:(nullable NSString*)value;

- (nullable NSString*)primitivePurchase_order_no;
- (void)setPrimitivePurchase_order_no:(nullable NSString*)value;

- (nullable id)primitiveRecommendation_ids;
- (void)setPrimitiveRecommendation_ids:(nullable id)value;

- (nullable NSNumber*)primitiveReport_number;
- (void)setPrimitiveReport_number:(nullable NSNumber*)value;

- (int32_t)primitiveReport_numberValue;
- (void)setPrimitiveReport_numberValue:(int32_t)value_;

- (nullable NSNumber*)primitiveService_location_id;
- (void)setPrimitiveService_location_id:(nullable NSNumber*)value;

- (int32_t)primitiveService_location_idValue;
- (void)setPrimitiveService_location_idValue:(int32_t)value_;

- (nullable id)primitiveService_route_ids;
- (void)setPrimitiveService_route_ids:(nullable id)value;

- (nullable NSNumber*)primitiveSpecific;
- (void)setPrimitiveSpecific:(nullable NSNumber*)value;

- (BOOL)primitiveSpecificValue;
- (void)setPrimitiveSpecificValue:(BOOL)value_;

- (nullable NSString*)primitiveSquare_feet;
- (void)setPrimitiveSquare_feet:(nullable NSString*)value;

- (nullable NSString*)primitiveStarted_at_time;
- (void)setPrimitiveStarted_at_time:(nullable NSString*)value;

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

- (nullable NSString*)primitiveTechnician_signature;
- (void)setPrimitiveTechnician_signature:(nullable NSString*)value;

- (nullable NSString*)primitiveTechnician_signature_name;
- (void)setPrimitiveTechnician_signature_name:(nullable NSString*)value;

- (nullable NSString*)primitiveTemperature;
- (void)setPrimitiveTemperature:(nullable NSString*)value;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (nullable NSString*)primitiveWind_direction;
- (void)setPrimitiveWind_direction:(nullable NSString*)value;

- (nullable NSString*)primitiveWind_speed;
- (void)setPrimitiveWind_speed:(nullable NSString*)value;

- (nullable NSNumber*)primitiveWorker_lat;
- (void)setPrimitiveWorker_lat:(nullable NSNumber*)value;

- (double)primitiveWorker_latValue;
- (void)setPrimitiveWorker_latValue:(double)value_;

- (nullable NSNumber*)primitiveWorker_lng;
- (void)setPrimitiveWorker_lng:(nullable NSNumber*)value;

- (double)primitiveWorker_lngValue;
- (void)setPrimitiveWorker_lngValue:(double)value_;

- (NSMutableSet<PDFAttachment*>*)primitiveAttachments;
- (void)setPrimitiveAttachments:(NSMutableSet<PDFAttachment*>*)value;

- (NSMutableSet<InspectionRecord*>*)primitiveInspection_records;
- (void)setPrimitiveInspection_records:(NSMutableSet<InspectionRecord*>*)value;

- (Invoice*)primitiveInvoice;
- (void)setPrimitiveInvoice:(Invoice*)value;

- (NSMutableOrderedSet<LineItem*>*)primitiveLine_items;
- (void)setPrimitiveLine_items:(NSMutableOrderedSet<LineItem*>*)value;

- (NSMutableSet<MaterialUsage*>*)primitiveMaterial_usages;
- (void)setPrimitiveMaterial_usages:(NSMutableSet<MaterialUsage*>*)value;

- (NSMutableSet<FWPDFForm*>*)primitivePdf_forms;
- (void)setPrimitivePdf_forms:(NSMutableSet<FWPDFForm*>*)value;

- (NSMutableSet<PhotoAttachment*>*)primitivePhoto_attachments;
- (void)setPrimitivePhoto_attachments:(NSMutableSet<PhotoAttachment*>*)value;

- (TaxRates*)primitiveTax_rate;
- (void)setPrimitiveTax_rate:(TaxRates*)value;

- (NSMutableSet<UnitInspection*>*)primitiveUnit_records;
- (void)setPrimitiveUnit_records:(NSMutableSet<UnitInspection*>*)value;

@end

@interface AppointmentAttributes: NSObject 
+ (NSString *)appointment_condition_ids;
+ (NSString *)arrival_time_end;
+ (NSString *)arrival_time_start;
+ (NSString *)auto_generates_invoice;
+ (NSString *)balance_forward;
+ (NSString *)callback;
+ (NSString *)confirmed;
+ (NSString *)confirmed_by;
+ (NSString *)corrective_action_ids;
+ (NSString *)created_at;
+ (NSString *)customer_id;
+ (NSString *)customer_signature;
+ (NSString *)discount;
+ (NSString *)discount_amount;
+ (NSString *)duration;
+ (NSString *)ends_at;
+ (NSString *)ends_at_date;
+ (NSString *)ends_at_time;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)error_sync_message;
+ (NSString *)finished_at_time;
+ (NSString *)hide_invoice_information;
+ (NSString *)instructions;
+ (NSString *)is_editing_now;
+ (NSString *)is_sync;
+ (NSString *)last_sync_date;
+ (NSString *)notes;
+ (NSString *)private_notes;
+ (NSString *)purchase_order_no;
+ (NSString *)recommendation_ids;
+ (NSString *)report_number;
+ (NSString *)service_location_id;
+ (NSString *)service_route_ids;
+ (NSString *)specific;
+ (NSString *)square_feet;
+ (NSString *)started_at_time;
+ (NSString *)starts_at;
+ (NSString *)starts_at_date;
+ (NSString *)starts_at_time;
+ (NSString *)status;
+ (NSString *)tax_amount;
+ (NSString *)tax_rate_id;
+ (NSString *)technician_signature;
+ (NSString *)technician_signature_name;
+ (NSString *)temperature;
+ (NSString *)updated_at;
+ (NSString *)wind_direction;
+ (NSString *)wind_speed;
+ (NSString *)worker_lat;
+ (NSString *)worker_lng;
@end

@interface AppointmentRelationships: NSObject
+ (NSString *)attachments;
+ (NSString *)inspection_records;
+ (NSString *)invoice;
+ (NSString *)line_items;
+ (NSString *)material_usages;
+ (NSString *)pdf_forms;
+ (NSString *)photo_attachments;
+ (NSString *)tax_rate;
+ (NSString *)unit_records;
@end

NS_ASSUME_NONNULL_END
