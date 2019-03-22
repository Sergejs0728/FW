//
//  NSDictionary+Extension.h
//  FWModel
//
//  Created by SamirMAC on 11/21/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (id) initWithDestroy:(id)entity_id;

- (NSDictionary*) dictionaryByRemovingId;

- (NSMutableDictionary*)replaceKeyName:(NSString*)old_key with:(NSString*)new_key;

@end
