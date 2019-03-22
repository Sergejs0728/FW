// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Invoice.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Appointment;
@class Payment;

@interface InvoiceID : NSManagedObjectID {}
@end

@interface _Invoice : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InvoiceID *objectID;

@property (nonatomic, strong, nullable) NSNumber* approved;

@property (atomic) BOOL approvedValue;
- (BOOL)approvedValue;
- (void)setApprovedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* callback;

@property (atomic) BOOL callbackValue;
- (BOOL)callbackValue;
- (void)setCallbackValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* discount;

@property (atomic) float discountValue;
- (float)discountValue;
- (void)setDiscountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* discount_amount;

@property (atomic) float discount_amountValue;
- (float)discount_amountValue;
- (void)setDiscount_amountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* invoice_number;

@property (atomic) int32_t invoice_numberValue;
- (int32_t)invoice_numberValue;
- (void)setInvoice_numberValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* tax_amount;

@property (atomic) float tax_amountValue;
- (float)tax_amountValue;
- (void)setTax_amountValue:(float)value_;

@property (nonatomic, strong, nullable) NSNumber* total;

@property (atomic) float totalValue;
- (float)totalValue;
- (void)setTotalValue:(float)value_;

@property (nonatomic, strong, nullable) Appointment *appointment;

@property (nonatomic, strong, nullable) NSSet<Payment*> *payments;
- (nullable NSMutableSet<Payment*>*)paymentsSet;

@end

@interface _Invoice (PaymentsCoreDataGeneratedAccessors)
- (void)addPayments:(NSSet<Payment*>*)value_;
- (void)removePayments:(NSSet<Payment*>*)value_;
- (void)addPaymentsObject:(Payment*)value_;
- (void)removePaymentsObject:(Payment*)value_;

@end

@interface _Invoice (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveApproved;
- (void)setPrimitiveApproved:(nullable NSNumber*)value;

- (BOOL)primitiveApprovedValue;
- (void)setPrimitiveApprovedValue:(BOOL)value_;

- (nullable NSNumber*)primitiveCallback;
- (void)setPrimitiveCallback:(nullable NSNumber*)value;

- (BOOL)primitiveCallbackValue;
- (void)setPrimitiveCallbackValue:(BOOL)value_;

- (nullable NSNumber*)primitiveDiscount;
- (void)setPrimitiveDiscount:(nullable NSNumber*)value;

- (float)primitiveDiscountValue;
- (void)setPrimitiveDiscountValue:(float)value_;

- (nullable NSNumber*)primitiveDiscount_amount;
- (void)setPrimitiveDiscount_amount:(nullable NSNumber*)value;

- (float)primitiveDiscount_amountValue;
- (void)setPrimitiveDiscount_amountValue:(float)value_;

- (nullable NSNumber*)primitiveInvoice_number;
- (void)setPrimitiveInvoice_number:(nullable NSNumber*)value;

- (int32_t)primitiveInvoice_numberValue;
- (void)setPrimitiveInvoice_numberValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTax_amount;
- (void)setPrimitiveTax_amount:(nullable NSNumber*)value;

- (float)primitiveTax_amountValue;
- (void)setPrimitiveTax_amountValue:(float)value_;

- (nullable NSNumber*)primitiveTotal;
- (void)setPrimitiveTotal:(nullable NSNumber*)value;

- (float)primitiveTotalValue;
- (void)setPrimitiveTotalValue:(float)value_;

- (Appointment*)primitiveAppointment;
- (void)setPrimitiveAppointment:(Appointment*)value;

- (NSMutableSet<Payment*>*)primitivePayments;
- (void)setPrimitivePayments:(NSMutableSet<Payment*>*)value;

@end

@interface InvoiceAttributes: NSObject 
+ (NSString *)approved;
+ (NSString *)callback;
+ (NSString *)discount;
+ (NSString *)discount_amount;
+ (NSString *)invoice_number;
+ (NSString *)tax_amount;
+ (NSString *)total;
@end

@interface InvoiceRelationships: NSObject
+ (NSString *)appointment;
+ (NSString *)payments;
@end

NS_ASSUME_NONNULL_END
