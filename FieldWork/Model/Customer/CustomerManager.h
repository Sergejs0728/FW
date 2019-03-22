//
//  CustomerManager.h
//  FieldWork
//
//  Created by SAMCOM on 27/11/15.
//
//

#import <Foundation/Foundation.h>

#define ADD_NEW_CUSTOMER_TAG @"ADD_NEW_CUSTOMER_TAG"

@interface CustomerManager : NSObject<FWRequestDelegate>
{
    ItemLoadedBlock _itemLoadedBlock;
    
    ItemSavedBlock _itemSavedBlock;
    
}

@property (nonatomic) NSInteger objectsCount;
+ (instancetype) Instance;

- (NSMutableArray *)getCustomersForAppointments:(NSMutableArray *)appointments;

- (void) loadCustomersWithBlock:(ItemLoadedBlock)block;
- (void) loadCustomersWithIds: (NSMutableArray*)arr block:(ItemLoadedBlock)block;

//- (void) refreshCustomersWithBlock:(ItemLoadedBlock)block;
- (void) refreshCustomersWithIds: (NSMutableArray*)arr block:(ItemLoadedBlock)block;
- (void) loadCustomersAllWithBlock:(ItemLoadedBlock)block;

- (NSUInteger) loadedCount;

- (void) addNewCustomer:(Customer*)cust withBlock:(ItemSavedBlock)block;
- (void) refreshCustomersWithBlock:(ItemLoadedBlock)block;
- (void) clearAllCustomerandDevices;

@end
