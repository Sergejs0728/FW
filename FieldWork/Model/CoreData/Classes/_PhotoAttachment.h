// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PhotoAttachment.h instead.

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

@interface PhotoAttachmentID : NSManagedObjectID {}
@end

@interface _PhotoAttachment : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PhotoAttachmentID *objectID;

@property (nonatomic, strong, nullable) NSNumber* appointment_occurrence_id;

@property (atomic) int32_t appointment_occurrence_idValue;
- (int32_t)appointment_occurrence_idValue;
- (void)setAppointment_occurrence_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* attachment_content_type;

@property (nonatomic, strong, nullable) NSString* attachment_file_name;

@property (nonatomic, strong, nullable) NSNumber* attachment_file_size;

@property (atomic) int64_t attachment_file_sizeValue;
- (int64_t)attachment_file_sizeValue;
- (void)setAttachment_file_sizeValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* comments;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* sync_status;

@property (atomic) int32_t sync_statusValue;
- (int32_t)sync_statusValue;
- (void)setSync_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) Estimate *estimate;

@end

@interface _PhotoAttachment (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAppointment_occurrence_id;
- (void)setPrimitiveAppointment_occurrence_id:(nullable NSNumber*)value;

- (int32_t)primitiveAppointment_occurrence_idValue;
- (void)setPrimitiveAppointment_occurrence_idValue:(int32_t)value_;

- (nullable NSString*)primitiveAttachment_content_type;
- (void)setPrimitiveAttachment_content_type:(nullable NSString*)value;

- (nullable NSString*)primitiveAttachment_file_name;
- (void)setPrimitiveAttachment_file_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveAttachment_file_size;
- (void)setPrimitiveAttachment_file_size:(nullable NSNumber*)value;

- (int64_t)primitiveAttachment_file_sizeValue;
- (void)setPrimitiveAttachment_file_sizeValue:(int64_t)value_;

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

- (nullable NSNumber*)primitiveSync_status;
- (void)setPrimitiveSync_status:(nullable NSNumber*)value;

- (int32_t)primitiveSync_statusValue;
- (void)setPrimitiveSync_statusValue:(int32_t)value_;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (Estimate*)primitiveEstimate;
- (void)setPrimitiveEstimate:(Estimate*)value;

@end

@interface PhotoAttachmentAttributes: NSObject 
+ (NSString *)appointment_occurrence_id;
+ (NSString *)attachment_content_type;
+ (NSString *)attachment_file_name;
+ (NSString *)attachment_file_size;
+ (NSString *)comments;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)sync_status;
+ (NSString *)updated_at;
@end

@interface PhotoAttachmentRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)estimate;
@end

NS_ASSUME_NONNULL_END
