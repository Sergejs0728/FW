// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ServiceLocation.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Contact;
@class Customer;
@class CustomerDevice;
@class Unit;
@class StageModel;

@class NSObject;

@class NSObject;

@class NSObject;

@interface ServiceLocationID : NSManagedObjectID {}
@end

@interface _ServiceLocation : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ServiceLocationID *objectID;

@property (nonatomic, strong, nullable) NSString* attention;

@property (nonatomic, strong, nullable) NSString* city;

@property (nonatomic, strong, nullable) NSString* contact_name;

@property (nonatomic, strong, nullable) NSString* country;

@property (nonatomic, strong, nullable) NSString* county;

@property (nonatomic, strong, nullable) NSNumber* customer_id;

@property (atomic) int32_t customer_idValue;
- (int32_t)customer_idValue;
- (void)setCustomer_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* email;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* hide_balance;

@property (atomic) BOOL hide_balanceValue;
- (BOOL)hide_balanceValue;
- (void)setHide_balanceValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* lat;

@property (atomic) double latValue;
- (double)latValue;
- (void)setLatValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* lng;

@property (atomic) double lngValue;
- (double)lngValue;
- (void)setLngValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* location_type_id;

@property (atomic) int32_t location_type_idValue;
- (int32_t)location_type_idValue;
- (void)setLocation_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* phone;

@property (nonatomic, strong, nullable) NSString* phone_ext;

@property (nonatomic, strong, nullable) NSString* phone_kind;

@property (nonatomic, strong, nullable) id phones;

@property (nonatomic, strong, nullable) id phones_exts;

@property (nonatomic, strong, nullable) id phones_kinds;

@property (nonatomic, strong, nullable) NSNumber* service_route_id;

@property (atomic) int32_t service_route_idValue;
- (int32_t)service_route_idValue;
- (void)setService_route_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* state;

@property (nonatomic, strong, nullable) NSString* street;

@property (nonatomic, strong, nullable) NSString* street2;

@property (nonatomic, strong, nullable) NSString* suite;

@property (nonatomic, strong, nullable) NSNumber* tax_rate_id;

@property (atomic) int32_t tax_rate_idValue;
- (int32_t)tax_rate_idValue;
- (void)setTax_rate_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* zip;

@property (nonatomic, strong, nullable) NSSet<Contact*> *contacts;
- (nullable NSMutableSet<Contact*>*)contactsSet;

@property (nonatomic, strong, nullable) Customer *customer;

@property (nonatomic, strong, nullable) NSSet<CustomerDevice*> *devices;
- (nullable NSMutableSet<CustomerDevice*>*)devicesSet;

@property (nonatomic, strong, nullable) NSSet<Unit*> *flats;
- (nullable NSMutableSet<Unit*>*)flatsSet;

@property (nonatomic, strong, nullable) NSOrderedSet<StageModel*> *floors;
- (nullable NSMutableOrderedSet<StageModel*>*)floorsSet;

@end

@interface _ServiceLocation (ContactsCoreDataGeneratedAccessors)
- (void)addContacts:(NSSet<Contact*>*)value_;
- (void)removeContacts:(NSSet<Contact*>*)value_;
- (void)addContactsObject:(Contact*)value_;
- (void)removeContactsObject:(Contact*)value_;

@end

@interface _ServiceLocation (DevicesCoreDataGeneratedAccessors)
- (void)addDevices:(NSSet<CustomerDevice*>*)value_;
- (void)removeDevices:(NSSet<CustomerDevice*>*)value_;
- (void)addDevicesObject:(CustomerDevice*)value_;
- (void)removeDevicesObject:(CustomerDevice*)value_;

@end

@interface _ServiceLocation (FlatsCoreDataGeneratedAccessors)
- (void)addFlats:(NSSet<Unit*>*)value_;
- (void)removeFlats:(NSSet<Unit*>*)value_;
- (void)addFlatsObject:(Unit*)value_;
- (void)removeFlatsObject:(Unit*)value_;

@end

@interface _ServiceLocation (FloorsCoreDataGeneratedAccessors)
- (void)addFloors:(NSOrderedSet<StageModel*>*)value_;
- (void)removeFloors:(NSOrderedSet<StageModel*>*)value_;
- (void)addFloorsObject:(StageModel*)value_;
- (void)removeFloorsObject:(StageModel*)value_;

- (void)insertObject:(StageModel*)value inFloorsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFloorsAtIndex:(NSUInteger)idx;
- (void)insertFloors:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFloorsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFloorsAtIndex:(NSUInteger)idx withObject:(StageModel*)value;
- (void)replaceFloorsAtIndexes:(NSIndexSet *)indexes withFloors:(NSArray *)values;

@end

@interface _ServiceLocation (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveAttention;
- (void)setPrimitiveAttention:(nullable NSString*)value;

- (nullable NSString*)primitiveCity;
- (void)setPrimitiveCity:(nullable NSString*)value;

- (nullable NSString*)primitiveContact_name;
- (void)setPrimitiveContact_name:(nullable NSString*)value;

- (nullable NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(nullable NSString*)value;

- (nullable NSString*)primitiveCounty;
- (void)setPrimitiveCounty:(nullable NSString*)value;

- (nullable NSNumber*)primitiveCustomer_id;
- (void)setPrimitiveCustomer_id:(nullable NSNumber*)value;

- (int32_t)primitiveCustomer_idValue;
- (void)setPrimitiveCustomer_idValue:(int32_t)value_;

- (nullable NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveHide_balance;
- (void)setPrimitiveHide_balance:(nullable NSNumber*)value;

- (BOOL)primitiveHide_balanceValue;
- (void)setPrimitiveHide_balanceValue:(BOOL)value_;

- (nullable NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(nullable NSNumber*)value;

- (double)primitiveLatValue;
- (void)setPrimitiveLatValue:(double)value_;

- (nullable NSNumber*)primitiveLng;
- (void)setPrimitiveLng:(nullable NSNumber*)value;

- (double)primitiveLngValue;
- (void)setPrimitiveLngValue:(double)value_;

- (nullable NSNumber*)primitiveLocation_type_id;
- (void)setPrimitiveLocation_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveLocation_type_idValue;
- (void)setPrimitiveLocation_type_idValue:(int32_t)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

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

- (nullable NSNumber*)primitiveService_route_id;
- (void)setPrimitiveService_route_id:(nullable NSNumber*)value;

- (int32_t)primitiveService_route_idValue;
- (void)setPrimitiveService_route_idValue:(int32_t)value_;

- (nullable NSString*)primitiveState;
- (void)setPrimitiveState:(nullable NSString*)value;

- (nullable NSString*)primitiveStreet;
- (void)setPrimitiveStreet:(nullable NSString*)value;

- (nullable NSString*)primitiveStreet2;
- (void)setPrimitiveStreet2:(nullable NSString*)value;

- (nullable NSString*)primitiveSuite;
- (void)setPrimitiveSuite:(nullable NSString*)value;

- (nullable NSNumber*)primitiveTax_rate_id;
- (void)setPrimitiveTax_rate_id:(nullable NSNumber*)value;

- (int32_t)primitiveTax_rate_idValue;
- (void)setPrimitiveTax_rate_idValue:(int32_t)value_;

- (nullable NSString*)primitiveZip;
- (void)setPrimitiveZip:(nullable NSString*)value;

- (NSMutableSet<Contact*>*)primitiveContacts;
- (void)setPrimitiveContacts:(NSMutableSet<Contact*>*)value;

- (Customer*)primitiveCustomer;
- (void)setPrimitiveCustomer:(Customer*)value;

- (NSMutableSet<CustomerDevice*>*)primitiveDevices;
- (void)setPrimitiveDevices:(NSMutableSet<CustomerDevice*>*)value;

- (NSMutableSet<Unit*>*)primitiveFlats;
- (void)setPrimitiveFlats:(NSMutableSet<Unit*>*)value;

- (NSMutableOrderedSet<StageModel*>*)primitiveFloors;
- (void)setPrimitiveFloors:(NSMutableOrderedSet<StageModel*>*)value;

@end

@interface ServiceLocationAttributes: NSObject 
+ (NSString *)attention;
+ (NSString *)city;
+ (NSString *)contact_name;
+ (NSString *)country;
+ (NSString *)county;
+ (NSString *)customer_id;
+ (NSString *)email;
+ (NSString *)entity_id;
+ (NSString *)hide_balance;
+ (NSString *)lat;
+ (NSString *)lng;
+ (NSString *)location_type_id;
+ (NSString *)name;
+ (NSString *)notes;
+ (NSString *)phone;
+ (NSString *)phone_ext;
+ (NSString *)phone_kind;
+ (NSString *)phones;
+ (NSString *)phones_exts;
+ (NSString *)phones_kinds;
+ (NSString *)service_route_id;
+ (NSString *)state;
+ (NSString *)street;
+ (NSString *)street2;
+ (NSString *)suite;
+ (NSString *)tax_rate_id;
+ (NSString *)zip;
@end

@interface ServiceLocationRelationships: NSObject
+ (NSString *)contacts;
+ (NSString *)customer;
+ (NSString *)devices;
+ (NSString *)flats;
+ (NSString *)floors;
@end

NS_ASSUME_NONNULL_END
