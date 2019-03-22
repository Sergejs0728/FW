// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Payment.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PaymentID : NSManagedObjectID {}
@end

@interface _Payment : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PaymentID *objectID;

@property (nonatomic, strong, nullable) NSNumber* amount;

@property (atomic) float amountValue;
- (float)amountValue;
- (void)setAmountValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* check_number;

@property (nonatomic, strong, nullable) NSNumber* created_from_mobile;

@property (atomic) BOOL created_from_mobileValue;
- (BOOL)created_from_mobileValue;
- (void)setCreated_from_mobileValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSDate* payment_date;

@property (nonatomic, strong, nullable) NSString* payment_method;

@end

@interface _Payment (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAmount;
- (void)setPrimitiveAmount:(nullable NSNumber*)value;

- (float)primitiveAmountValue;
- (void)setPrimitiveAmountValue:(float)value_;

- (nullable NSString*)primitiveCheck_number;
- (void)setPrimitiveCheck_number:(nullable NSString*)value;

- (nullable NSNumber*)primitiveCreated_from_mobile;
- (void)setPrimitiveCreated_from_mobile:(nullable NSNumber*)value;

- (BOOL)primitiveCreated_from_mobileValue;
- (void)setPrimitiveCreated_from_mobileValue:(BOOL)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSDate*)primitivePayment_date;
- (void)setPrimitivePayment_date:(nullable NSDate*)value;

- (nullable NSString*)primitivePayment_method;
- (void)setPrimitivePayment_method:(nullable NSString*)value;

@end

@interface PaymentAttributes: NSObject 
+ (NSString *)amount;
+ (NSString *)check_number;
+ (NSString *)created_from_mobile;
+ (NSString *)entity_id;
+ (NSString *)payment_date;
+ (NSString *)payment_method;
@end

NS_ASSUME_NONNULL_END
