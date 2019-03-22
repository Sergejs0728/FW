// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StageModel.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class ServiceLocation;

@interface StageModelID : NSManagedObjectID {}
@end

@interface _StageModel : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) StageModelID *objectID;

@property (nonatomic, strong, nullable) NSString* building;

@property (nonatomic, strong, nullable) NSNumber* changed;

@property (atomic) BOOL changedValue;
- (BOOL)changedValue;
- (void)setChangedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* deleted;

@property (atomic) BOOL deletedValue;
- (BOOL)deletedValue;
- (void)setDeletedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* filePath;

@property (nonatomic, strong, nullable) NSString* floor;

@property (nonatomic, strong, nullable) NSString* image_url;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSString* updated_at;

@property (nonatomic, strong, nullable) NSString* vg_url;

@property (nonatomic, strong) ServiceLocation *serviceLocation;

@end

@interface _StageModel (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveBuilding;
- (void)setPrimitiveBuilding:(nullable NSString*)value;

- (nullable NSNumber*)primitiveChanged;
- (void)setPrimitiveChanged:(nullable NSNumber*)value;

- (BOOL)primitiveChangedValue;
- (void)setPrimitiveChangedValue:(BOOL)value_;

- (nullable NSNumber*)primitiveDeleted;
- (void)setPrimitiveDeleted:(nullable NSNumber*)value;

- (BOOL)primitiveDeletedValue;
- (void)setPrimitiveDeletedValue:(BOOL)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveFilePath;
- (void)setPrimitiveFilePath:(nullable NSString*)value;

- (nullable NSString*)primitiveFloor;
- (void)setPrimitiveFloor:(nullable NSString*)value;

- (nullable NSString*)primitiveImage_url;
- (void)setPrimitiveImage_url:(nullable NSString*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(nullable NSString*)value;

- (nullable NSString*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSString*)value;

- (nullable NSString*)primitiveVg_url;
- (void)setPrimitiveVg_url:(nullable NSString*)value;

- (ServiceLocation*)primitiveServiceLocation;
- (void)setPrimitiveServiceLocation:(ServiceLocation*)value;

@end

@interface StageModelAttributes: NSObject 
+ (NSString *)building;
+ (NSString *)changed;
+ (NSString *)deleted;
+ (NSString *)entity_id;
+ (NSString *)filePath;
+ (NSString *)floor;
+ (NSString *)image_url;
+ (NSString *)notes;
+ (NSString *)title;
+ (NSString *)updated_at;
+ (NSString *)vg_url;
@end

@interface StageModelRelationships: NSObject
+ (NSString *)serviceLocation;
@end

NS_ASSUME_NONNULL_END
