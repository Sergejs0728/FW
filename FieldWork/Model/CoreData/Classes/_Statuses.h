// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Statuses.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface StatusesID : NSManagedObjectID {}
@end

@interface _Statuses : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) StatusesID *objectID;

@property (nonatomic, strong, nullable) NSString* color;

@property (nonatomic, strong, nullable) NSString* font_color;

@property (nonatomic, strong, nullable) NSString* status_name;

@property (nonatomic, strong, nullable) NSString* status_value;

@end

@interface _Statuses (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveColor;
- (void)setPrimitiveColor:(nullable NSString*)value;

- (nullable NSString*)primitiveFont_color;
- (void)setPrimitiveFont_color:(nullable NSString*)value;

- (nullable NSString*)primitiveStatus_name;
- (void)setPrimitiveStatus_name:(nullable NSString*)value;

- (nullable NSString*)primitiveStatus_value;
- (void)setPrimitiveStatus_value:(nullable NSString*)value;

@end

@interface StatusesAttributes: NSObject 
+ (NSString *)color;
+ (NSString *)font_color;
+ (NSString *)status_name;
+ (NSString *)status_value;
@end

NS_ASSUME_NONNULL_END
