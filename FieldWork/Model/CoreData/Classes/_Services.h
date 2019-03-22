// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Services.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ServicesID : NSManagedObjectID {}
@end

@interface _Services : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ServicesID *objectID;

@property (nonatomic, strong, nullable) NSNumber* account_id;

@property (atomic) int32_t account_idValue;
- (int32_t)account_idValue;
- (void)setAccount_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* color;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* frequency;

@property (nonatomic, strong, nullable) NSDecimalNumber* price;

@property (nonatomic, strong, nullable) NSString* service_description;

@end

@interface _Services (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAccount_id;
- (void)setPrimitiveAccount_id:(nullable NSNumber*)value;

- (int32_t)primitiveAccount_idValue;
- (void)setPrimitiveAccount_idValue:(int32_t)value_;

- (nullable NSString*)primitiveColor;
- (void)setPrimitiveColor:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveFrequency;
- (void)setPrimitiveFrequency:(nullable NSString*)value;

- (nullable NSDecimalNumber*)primitivePrice;
- (void)setPrimitivePrice:(nullable NSDecimalNumber*)value;

- (nullable NSString*)primitiveService_description;
- (void)setPrimitiveService_description:(nullable NSString*)value;

@end

@interface ServicesAttributes: NSObject 
+ (NSString *)account_id;
+ (NSString *)color;
+ (NSString *)entity_id;
+ (NSString *)frequency;
+ (NSString *)price;
+ (NSString *)service_description;
@end

NS_ASSUME_NONNULL_END
