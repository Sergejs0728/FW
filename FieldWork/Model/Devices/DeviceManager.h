//
//  DeviceManager.h
//  FieldWork
//
//  Created by Borys Duda on 2/14/18.
//

#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject<FWRequestDelegate>
{
    ItemLoadedBlock __load_block;
}
+ (instancetype) Instance;
- (void) loadAllDevices:(ItemLoadedBlock)block;

@end

