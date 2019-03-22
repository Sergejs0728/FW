// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Material.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MaterialID : NSManagedObjectID {}
@end

@interface _Material : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MaterialID *objectID;

@property (nonatomic, strong, nullable) NSString* active_ingredient;

@property (nonatomic, strong, nullable) NSString* active_ingredient_percent;

@property (nonatomic, strong, nullable) NSNumber* default_dilution_rate_id;

@property (atomic) int32_t default_dilution_rate_idValue;
- (int32_t)default_dilution_rate_idValue;
- (void)setDefault_dilution_rate_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* epa_number;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSNumber* price;

@property (atomic) float priceValue;
- (float)priceValue;
- (void)setPriceValue:(float)value_;

@end

@interface _Material (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveActive_ingredient;
- (void)setPrimitiveActive_ingredient:(nullable NSString*)value;

- (nullable NSString*)primitiveActive_ingredient_percent;
- (void)setPrimitiveActive_ingredient_percent:(nullable NSString*)value;

- (nullable NSNumber*)primitiveDefault_dilution_rate_id;
- (void)setPrimitiveDefault_dilution_rate_id:(nullable NSNumber*)value;

- (int32_t)primitiveDefault_dilution_rate_idValue;
- (void)setPrimitiveDefault_dilution_rate_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveEpa_number;
- (void)setPrimitiveEpa_number:(nullable NSString*)value;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(nullable NSNumber*)value;

- (float)primitivePriceValue;
- (void)setPrimitivePriceValue:(float)value_;

@end

@interface MaterialAttributes: NSObject 
+ (NSString *)active_ingredient;
+ (NSString *)active_ingredient_percent;
+ (NSString *)default_dilution_rate_id;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)epa_number;
+ (NSString *)name;
+ (NSString *)price;
@end

NS_ASSUME_NONNULL_END
