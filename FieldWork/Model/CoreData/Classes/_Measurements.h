// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Measurements.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MeasurementsID : NSManagedObjectID {}
@end

@interface _Measurements : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MeasurementsID *objectID;

@property (nonatomic, strong, nullable) NSString* measurement;

@end

@interface _Measurements (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveMeasurement;
- (void)setPrimitiveMeasurement:(nullable NSString*)value;

@end

@interface MeasurementsAttributes: NSObject 
+ (NSString *)measurement;
@end

NS_ASSUME_NONNULL_END
