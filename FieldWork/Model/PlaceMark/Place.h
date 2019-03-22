//
//  Place.h
//  Miller
//
//  Created by kadir pekel on 2/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Place : NSObject {

	NSString* name;
//	NSString* description;
	double latitude;
	double longitude;
}

@property (nonatomic, strong) NSString* name;
//@property (nonatomic, retain) NSString* description;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;

@end
