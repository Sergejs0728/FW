// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Evidences.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface EvidencesID : NSManagedObjectID {}
@end

@interface _Evidences : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EvidencesID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _Evidences (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

@end

@interface EvidencesAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
