//
//  SignaturePoint.m
//  SignatureDemo
//
//  Created by Samir Kha on 17/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SignaturePoint.h"

@implementation SignaturePoint

@synthesize ly = _ly;
@synthesize lx = _lx;
@synthesize mx = _mx;
@synthesize my = _my;


+ (SignaturePoint *)newPointWithlx:(float)llx ly:(float)lly mx:(float)mmx my:(float)mmy {
    SignaturePoint *sp = [[SignaturePoint alloc] init];
    sp.lx = llx;
    sp.ly = lly;
    sp.mx = mmx;
    sp.my = mmy;
    return sp;
}


+ (NSMutableArray *)parseWithArray:(NSString *)sigString {
        //26112015
    NSData *data = [sigString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //    SBJSON *jsonParser = [[SBJSON alloc] init];
        //    NSError *error;
        //    NSMutableArray *arr = [jsonParser objectWithString:sigString error:&error];
    if (error) {
        NSLog(@"Error Occured in parsing signature : %@", error.userInfo);
    }
    NSMutableArray *sigArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arr) {
        float lly = [[dict objectForKey:@"ly"] floatValue];
        float llx = [[dict objectForKey:@"lx"] floatValue];
        float mmy = [[dict objectForKey:@"my"] floatValue];
        float mmx = [[dict objectForKey:@"mx"] floatValue];
            //NSLog(@"ff");
        SignaturePoint *sp = [SignaturePoint newPointWithlx:llx ly:lly mx:mmx my:mmy];
        [sigArr addObject:sp];
    }
    return sigArr;
}

- (NSString *)getJson {
    return [NSString stringWithFormat:@"{\\\"my\\\":%.02f,\\\"ly\\\":%.02f,\\\"mx\\\":%.02f,\\\"lx\\\":%.02f}", self.my, self.ly, self.mx, self.lx];
}

//- (void) calcByDrawingConstant:(CGFloat)constant{
//    self.mx= self.mx;
//    self.my= self.my;
//    self.lx= self.lx;
//    self.ly= self.ly;
//}

+ (NSString*) getSignatureJson:(NSMutableArray*) sigArray
{
    NSMutableArray *points=[[NSMutableArray alloc]init];
    for (SignaturePoint *sp in sigArray) {
        NSString *temp=@"{\"my\":%f,\"ly\":%f,\"mx\":%f,\"lx\":%f}";
        NSString * temp1=[NSString stringWithFormat:temp,sp.my,sp.ly,sp.mx,sp.lx];
        [points addObject:temp1];
        
    }
    NSString *h=[points joinWithDelimeter:@","];
    h = [NSString stringWithFormat:@"[%@]",h];
    
    return h;
}
-(void)print{
    NSLog(@"{\"my\":%f,\"ly\":%f,\"mx\":%f,\"lx\":%f}",self.my,self.ly,self.mx,self.lx);
}

@end
