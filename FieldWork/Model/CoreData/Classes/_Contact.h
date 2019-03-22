// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class NSObject;

@class NSObject;

@class NSObject;

@interface ContactID : NSManagedObjectID {}
@end

@interface _Contact : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ContactID *objectID;

@property (nonatomic, strong, nullable) NSString* contact_description;

@property (nonatomic, strong, nullable) NSString* email;

@property (nonatomic, strong, nullable) NSNumber* email_invoices;

@property (atomic) BOOL email_invoicesValue;
- (BOOL)email_invoicesValue;
- (void)setEmail_invoicesValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* email_work_orders;

@property (atomic) BOOL email_work_ordersValue;
- (BOOL)email_work_ordersValue;
- (void)setEmail_work_ordersValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* first_name;

@property (nonatomic, strong, nullable) NSString* last_name;

@property (nonatomic, strong, nullable) NSString* phone;

@property (nonatomic, strong, nullable) NSString* phone_ext;

@property (nonatomic, strong, nullable) NSString* phone_kind;

@property (nonatomic, strong, nullable) id phones;

@property (nonatomic, strong, nullable) id phones_exts;

@property (nonatomic, strong, nullable) id phones_kinds;

@property (nonatomic, strong, nullable) NSString* title;

@end

@interface _Contact (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveContact_description;
- (void)setPrimitiveContact_description:(nullable NSString*)value;

- (nullable NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEmail_invoices;
- (void)setPrimitiveEmail_invoices:(nullable NSNumber*)value;

- (BOOL)primitiveEmail_invoicesValue;
- (void)setPrimitiveEmail_invoicesValue:(BOOL)value_;

- (nullable NSNumber*)primitiveEmail_work_orders;
- (void)setPrimitiveEmail_work_orders:(nullable NSNumber*)value;

- (BOOL)primitiveEmail_work_ordersValue;
- (void)setPrimitiveEmail_work_ordersValue:(BOOL)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(nullable NSString*)value;

- (nullable NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(nullable NSString*)value;

- (nullable NSString*)primitivePhone;
- (void)setPrimitivePhone:(nullable NSString*)value;

- (nullable NSString*)primitivePhone_ext;
- (void)setPrimitivePhone_ext:(nullable NSString*)value;

- (nullable NSString*)primitivePhone_kind;
- (void)setPrimitivePhone_kind:(nullable NSString*)value;

- (nullable id)primitivePhones;
- (void)setPrimitivePhones:(nullable id)value;

- (nullable id)primitivePhones_exts;
- (void)setPrimitivePhones_exts:(nullable id)value;

- (nullable id)primitivePhones_kinds;
- (void)setPrimitivePhones_kinds:(nullable id)value;

- (nullable NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(nullable NSString*)value;

@end

@interface ContactAttributes: NSObject 
+ (NSString *)contact_description;
+ (NSString *)email;
+ (NSString *)email_invoices;
+ (NSString *)email_work_orders;
+ (NSString *)entity_id;
+ (NSString *)first_name;
+ (NSString *)last_name;
+ (NSString *)phone;
+ (NSString *)phone_ext;
+ (NSString *)phone_kind;
+ (NSString *)phones;
+ (NSString *)phones_exts;
+ (NSString *)phones_kinds;
+ (NSString *)title;
@end

NS_ASSUME_NONNULL_END
