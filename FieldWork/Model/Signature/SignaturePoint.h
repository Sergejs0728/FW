//
//  SignaturePoint.h
//  SignatureDemo
//
//  Created by Samir Kha on 17/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//26112015
//#import "SBJSON.h"

@interface SignaturePoint : NSObject
{
    float _lx;
    float _ly;
    float _mx;
    float _my;
}

@property (nonatomic, assign) float lx;
@property (nonatomic, assign) float ly;
@property (nonatomic, assign) float mx;
@property (nonatomic, assign) float my;

+ (SignaturePoint*) newPointWithlx:(float) llx ly:(float) lly mx:(float) mmx my:(float) mmy;

+ (NSMutableArray*) parseWithArray:(NSString*) sigString;

- (NSString*) getJson;

-(void)print;

//- (void) calcByDrawingConstant:(CGFloat)constant;

+ (NSString*) getSignatureJson:(NSMutableArray*) sigArray;


@end
