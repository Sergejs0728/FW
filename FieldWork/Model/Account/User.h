#import "_User.h"



typedef void(^UserLoadBlock)(BOOL success,NSError *error);
@interface User : _User <FWRequestDelegate>
{}
// Custom logic goes here.


+ (FEMMapping* )defaultMapping;

+ (User *)getUser;

+ (void)loadUser;

- (void)updateUserLocationKitlocate:(CLLocationCoordinate2D)cordinate;

- (void)loadUserWithBlock:(UserLoadBlock)block;


+(User *)createNewUser;
@end
