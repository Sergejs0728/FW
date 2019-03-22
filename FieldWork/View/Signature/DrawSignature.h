//
//  DrawSignature.h
//  SignatureDemo
//
//  Created by Samir Kha on 17/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignaturePoint.h"

@interface DrawSignature : UIView{
    NSMutableArray *_sigPoints;
    CGRect mainFrame;
    float factor;
}

@property (nonatomic, retain, readwrite) NSMutableArray * sigPoints;

@end
