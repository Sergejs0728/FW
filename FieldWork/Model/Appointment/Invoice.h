#import "_Invoice.h"

@interface Invoice : _Invoice {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

- (Payment*) getMobilePayment;

+ (Invoice*) invoiceWithAppointment:(Appointment*)app;

@end
