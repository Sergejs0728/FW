// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PDFField.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class PDFAttachment;
@class FWPDFForm;

@class NSObject;

@class NSObject;

@interface PDFFieldID : NSManagedObjectID {}
@end

@interface _PDFField : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PDFFieldID *objectID;

@property (nonatomic, strong, nullable) NSString* default_value;

@property (nonatomic, strong, nullable) NSString* field_type;

@property (nonatomic, strong, nullable) NSString* field_value;

@property (nonatomic, strong, nullable) NSNumber* hidden;

@property (atomic) BOOL hiddenValue;
- (BOOL)hiddenValue;
- (void)setHiddenValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* label;

@property (nonatomic, strong, nullable) NSNumber* max_length;

@property (atomic) int32_t max_lengthValue;
- (int32_t)max_lengthValue;
- (void)setMax_lengthValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) id options;

@property (nonatomic, strong, nullable) NSString* pdf_name;

@property (nonatomic, strong, nullable) NSNumber* required;

@property (atomic) BOOL requiredValue;
- (BOOL)requiredValue;
- (void)setRequiredValue:(BOOL)value_;

@property (nonatomic, strong, nullable) id selected_options;

@property (nonatomic, strong, nullable) PDFAttachment *pdf_attachment;

@property (nonatomic, strong, nullable) FWPDFForm *pdf_form;

@end

@interface _PDFField (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveDefault_value;
- (void)setPrimitiveDefault_value:(nullable NSString*)value;

- (nullable NSString*)primitiveField_type;
- (void)setPrimitiveField_type:(nullable NSString*)value;

- (nullable NSString*)primitiveField_value;
- (void)setPrimitiveField_value:(nullable NSString*)value;

- (nullable NSNumber*)primitiveHidden;
- (void)setPrimitiveHidden:(nullable NSNumber*)value;

- (BOOL)primitiveHiddenValue;
- (void)setPrimitiveHiddenValue:(BOOL)value_;

- (nullable NSString*)primitiveLabel;
- (void)setPrimitiveLabel:(nullable NSString*)value;

- (nullable NSNumber*)primitiveMax_length;
- (void)setPrimitiveMax_length:(nullable NSNumber*)value;

- (int32_t)primitiveMax_lengthValue;
- (void)setPrimitiveMax_lengthValue:(int32_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable id)primitiveOptions;
- (void)setPrimitiveOptions:(nullable id)value;

- (nullable NSString*)primitivePdf_name;
- (void)setPrimitivePdf_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveRequired;
- (void)setPrimitiveRequired:(nullable NSNumber*)value;

- (BOOL)primitiveRequiredValue;
- (void)setPrimitiveRequiredValue:(BOOL)value_;

- (nullable id)primitiveSelected_options;
- (void)setPrimitiveSelected_options:(nullable id)value;

- (PDFAttachment*)primitivePdf_attachment;
- (void)setPrimitivePdf_attachment:(PDFAttachment*)value;

- (FWPDFForm*)primitivePdf_form;
- (void)setPrimitivePdf_form:(FWPDFForm*)value;

@end

@interface PDFFieldAttributes: NSObject 
+ (NSString *)default_value;
+ (NSString *)field_type;
+ (NSString *)field_value;
+ (NSString *)hidden;
+ (NSString *)label;
+ (NSString *)max_length;
+ (NSString *)name;
+ (NSString *)options;
+ (NSString *)pdf_name;
+ (NSString *)required;
+ (NSString *)selected_options;
@end

@interface PDFFieldRelationships: NSObject
+ (NSString *)pdf_attachment;
+ (NSString *)pdf_form;
@end

NS_ASSUME_NONNULL_END
