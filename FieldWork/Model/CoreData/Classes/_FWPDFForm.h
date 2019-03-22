// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FWPDFForm.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class PDFAttachment;
@class Estimate;
@class PDFField;

@interface FWPDFFormID : NSManagedObjectID {}
@end

@interface _FWPDFForm : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FWPDFFormID *objectID;

@property (nonatomic, strong, nullable) NSNumber* appointment_id;

@property (atomic) int32_t appointment_idValue;
- (int32_t)appointment_idValue;
- (void)setAppointment_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* document_content_type;

@property (nonatomic, strong, nullable) NSString* document_file_name;

@property (nonatomic, strong, nullable) NSNumber* document_file_size;

@property (atomic) int64_t document_file_sizeValue;
- (int64_t)document_file_sizeValue;
- (void)setDocument_file_sizeValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* document_url;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* use_acrobat;

@property (atomic) BOOL use_acrobatValue;
- (BOOL)use_acrobatValue;
- (void)setUse_acrobatValue:(BOOL)value_;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) NSSet<PDFAttachment*> *attachment;
- (nullable NSMutableSet<PDFAttachment*>*)attachmentSet;

@property (nonatomic, strong, nullable) Estimate *estimate;

@property (nonatomic, strong, nullable) NSOrderedSet<PDFField*> *fields;
- (nullable NSMutableOrderedSet<PDFField*>*)fieldsSet;

@end

@interface _FWPDFForm (AttachmentCoreDataGeneratedAccessors)
- (void)addAttachment:(NSSet<PDFAttachment*>*)value_;
- (void)removeAttachment:(NSSet<PDFAttachment*>*)value_;
- (void)addAttachmentObject:(PDFAttachment*)value_;
- (void)removeAttachmentObject:(PDFAttachment*)value_;

@end

@interface _FWPDFForm (FieldsCoreDataGeneratedAccessors)
- (void)addFields:(NSOrderedSet<PDFField*>*)value_;
- (void)removeFields:(NSOrderedSet<PDFField*>*)value_;
- (void)addFieldsObject:(PDFField*)value_;
- (void)removeFieldsObject:(PDFField*)value_;

- (void)insertObject:(PDFField*)value inFieldsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFieldsAtIndex:(NSUInteger)idx;
- (void)insertFields:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFieldsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFieldsAtIndex:(NSUInteger)idx withObject:(PDFField*)value;
- (void)replaceFieldsAtIndexes:(NSIndexSet *)indexes withFields:(NSArray *)values;

@end

@interface _FWPDFForm (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAppointment_id;
- (void)setPrimitiveAppointment_id:(nullable NSNumber*)value;

- (int32_t)primitiveAppointment_idValue;
- (void)setPrimitiveAppointment_idValue:(int32_t)value_;

- (nullable NSString*)primitiveDocument_content_type;
- (void)setPrimitiveDocument_content_type:(nullable NSString*)value;

- (nullable NSString*)primitiveDocument_file_name;
- (void)setPrimitiveDocument_file_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDocument_file_size;
- (void)setPrimitiveDocument_file_size:(nullable NSNumber*)value;

- (int64_t)primitiveDocument_file_sizeValue;
- (void)setPrimitiveDocument_file_sizeValue:(int64_t)value_;

- (nullable NSString*)primitiveDocument_url;
- (void)setPrimitiveDocument_url:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitiveUse_acrobat;
- (void)setPrimitiveUse_acrobat:(nullable NSNumber*)value;

- (BOOL)primitiveUse_acrobatValue;
- (void)setPrimitiveUse_acrobatValue:(BOOL)value_;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (NSMutableSet<PDFAttachment*>*)primitiveAttachment;
- (void)setPrimitiveAttachment:(NSMutableSet<PDFAttachment*>*)value;

- (Estimate*)primitiveEstimate;
- (void)setPrimitiveEstimate:(Estimate*)value;

- (NSMutableOrderedSet<PDFField*>*)primitiveFields;
- (void)setPrimitiveFields:(NSMutableOrderedSet<PDFField*>*)value;

@end

@interface FWPDFFormAttributes: NSObject 
+ (NSString *)appointment_id;
+ (NSString *)document_content_type;
+ (NSString *)document_file_name;
+ (NSString *)document_file_size;
+ (NSString *)document_url;
+ (NSString *)entity_id;
+ (NSString *)name;
+ (NSString *)use_acrobat;
@end

@interface FWPDFFormRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)attachment;
+ (NSString *)estimate;
+ (NSString *)fields;
@end

NS_ASSUME_NONNULL_END
