// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PDFAttachment.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class Estimate;
@class PDFField;
@class FWPDFForm;

@interface PDFAttachmentID : NSManagedObjectID {}
@end

@interface _PDFAttachment : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PDFAttachmentID *objectID;

@property (nonatomic, strong, nullable) NSNumber* appointment_occurrence_id;

@property (atomic) int32_t appointment_occurrence_idValue;
- (int32_t)appointment_occurrence_idValue;
- (void)setAppointment_occurrence_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* attached_pdf_form_content_type;

@property (nonatomic, strong, nullable) NSString* attached_pdf_form_file_name;

@property (nonatomic, strong, nullable) NSNumber* attached_pdf_form_file_size;

@property (atomic) int32_t attached_pdf_form_file_sizeValue;
- (int32_t)attached_pdf_form_file_sizeValue;
- (void)setAttached_pdf_form_file_sizeValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* attachment_content_type;

@property (nonatomic, strong, nullable) NSString* attachment_file_name;

@property (nonatomic, strong, nullable) NSNumber* attachment_file_size;

@property (atomic) int32_t attachment_file_sizeValue;
- (int32_t)attachment_file_sizeValue;
- (void)setAttachment_file_sizeValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* comments;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* pdf_file_name;

@property (nonatomic, strong, nullable) NSNumber* pdf_form_id;

@property (atomic) int32_t pdf_form_idValue;
- (int32_t)pdf_form_idValue;
- (void)setPdf_form_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) Estimate *estimate;

@property (nonatomic, strong, nullable) NSOrderedSet<PDFField*> *field_values;
- (nullable NSMutableOrderedSet<PDFField*>*)field_valuesSet;

@property (nonatomic, strong, nullable) FWPDFForm *pdf_form;

@end

@interface _PDFAttachment (Field_valuesCoreDataGeneratedAccessors)
- (void)addField_values:(NSOrderedSet<PDFField*>*)value_;
- (void)removeField_values:(NSOrderedSet<PDFField*>*)value_;
- (void)addField_valuesObject:(PDFField*)value_;
- (void)removeField_valuesObject:(PDFField*)value_;

- (void)insertObject:(PDFField*)value inField_valuesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromField_valuesAtIndex:(NSUInteger)idx;
- (void)insertField_values:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeField_valuesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInField_valuesAtIndex:(NSUInteger)idx withObject:(PDFField*)value;
- (void)replaceField_valuesAtIndexes:(NSIndexSet *)indexes withField_values:(NSArray *)values;

@end

@interface _PDFAttachment (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAppointment_occurrence_id;
- (void)setPrimitiveAppointment_occurrence_id:(nullable NSNumber*)value;

- (int32_t)primitiveAppointment_occurrence_idValue;
- (void)setPrimitiveAppointment_occurrence_idValue:(int32_t)value_;

- (nullable NSString*)primitiveAttached_pdf_form_content_type;
- (void)setPrimitiveAttached_pdf_form_content_type:(nullable NSString*)value;

- (nullable NSString*)primitiveAttached_pdf_form_file_name;
- (void)setPrimitiveAttached_pdf_form_file_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveAttached_pdf_form_file_size;
- (void)setPrimitiveAttached_pdf_form_file_size:(nullable NSNumber*)value;

- (int32_t)primitiveAttached_pdf_form_file_sizeValue;
- (void)setPrimitiveAttached_pdf_form_file_sizeValue:(int32_t)value_;

- (nullable NSString*)primitiveAttachment_content_type;
- (void)setPrimitiveAttachment_content_type:(nullable NSString*)value;

- (nullable NSString*)primitiveAttachment_file_name;
- (void)setPrimitiveAttachment_file_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveAttachment_file_size;
- (void)setPrimitiveAttachment_file_size:(nullable NSNumber*)value;

- (int32_t)primitiveAttachment_file_sizeValue;
- (void)setPrimitiveAttachment_file_sizeValue:(int32_t)value_;

- (nullable NSString*)primitiveComments;
- (void)setPrimitiveComments:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitivePdf_file_name;
- (void)setPrimitivePdf_file_name:(nullable NSString*)value;

- (nullable NSNumber*)primitivePdf_form_id;
- (void)setPrimitivePdf_form_id:(nullable NSNumber*)value;

- (int32_t)primitivePdf_form_idValue;
- (void)setPrimitivePdf_form_idValue:(int32_t)value_;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (Estimate*)primitiveEstimate;
- (void)setPrimitiveEstimate:(Estimate*)value;

- (NSMutableOrderedSet<PDFField*>*)primitiveField_values;
- (void)setPrimitiveField_values:(NSMutableOrderedSet<PDFField*>*)value;

- (FWPDFForm*)primitivePdf_form;
- (void)setPrimitivePdf_form:(FWPDFForm*)value;

@end

@interface PDFAttachmentAttributes: NSObject 
+ (NSString *)appointment_occurrence_id;
+ (NSString *)attached_pdf_form_content_type;
+ (NSString *)attached_pdf_form_file_name;
+ (NSString *)attached_pdf_form_file_size;
+ (NSString *)attachment_content_type;
+ (NSString *)attachment_file_name;
+ (NSString *)attachment_file_size;
+ (NSString *)comments;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)pdf_file_name;
+ (NSString *)pdf_form_id;
+ (NSString *)updated_at;
@end

@interface PDFAttachmentRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)estimate;
+ (NSString *)field_values;
+ (NSString *)pdf_form;
@end

NS_ASSUME_NONNULL_END
