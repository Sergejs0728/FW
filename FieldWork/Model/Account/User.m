#import "User.h"
#import "CDHelper.h"

@interface User ()
{
    UserLoadBlock _userLoadedBlock;
}
// Private interface goes here.

@end

@implementation User

+ (FEMMapping* )defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[User entityName]];
    NSMutableDictionary *line_mapping = [[CDHelper mappingForClass:[User class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:line_mapping];
    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"account_features" toKeyPath:@"account_features" map:^id(id value) {
        if ( [value isKindOfClass:NSArray.class]) {
            return (NSArray*)value;
        }
        return value;
    } reverseMap:nil]];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (User *)getUser
{
    return [User MR_findFirst];
}

+ (void)loadUser {
    User *user = [User getUser];
    if (user == nil) {
        user = [User MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    }
    if ([[AppDelegate appDelegate] isReachable]) {
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_USER andDelegate:user];
        request.Tag = API_USER;
        [request startRequest];
    }
}

-(void)loadUserWithBlock:(UserLoadBlock)block{
//    _userLoadedBlock = block;
//    FWRequest *request = [[FWRequest alloc] initWithUrl:API_USER andDelegate:self];
//    request.Tag = API_USER;
//    [request startRequest];
    [FWRequest requestWithURLPart:API_USER
                           method:GET
                             dict:nil block:^(BOOL success, FWRequest *request) {
                                 if (success) {
                                         [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                                             NSDictionary *mainDict = request.serverData;
                                             NSDictionary *userdict = [mainDict objectForKey:@"user"];
                                             BOOL saved = YES;
                                             @try {
                                                 [FEMDeserializer fillObject:self fromRepresentation:userdict mapping:[User defaultMapping]];
                                             } @catch (NSException *exception) {
                                                 saved = NO;
                                                 [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                                                      @"Method":NSStringFromSelector(@selector(loadUserWithBlock:)),
                                                                                                      @"Exception":exception.description,
                                                                                                      @"UserId":self.entity_id,
                                                                                                      @"RequestMethod":@"GET",
                                                                                                      @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                                             } @finally {
                                                 if (block) {
                                                     block(saved,nil);
                                                 }

                                             }
                                            }];
                                             
                                 }
                             }];
}

+(User *)createNewUser{
    return [User MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
}

-(void)updateUserLocationKitlocate:(CLLocationCoordinate2D)cordinate{
    if ([[AppDelegate appDelegate] isReachable]) {
        NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
        [Dict setValue:[NSNumber numberWithDouble:cordinate.latitude] forKey:@"lat"];
        [Dict setValue:[NSNumber numberWithDouble:cordinate.longitude] forKey:@"lng"];
        
        FWRequest *request = [[FWRequest alloc] initWithUrl:API_USER_COORDINATES andDelegate:self andMethod:POST];
        [request setPostParameters:Dict];
        request.Tag = API_USER_COORDINATES;
        [request startRequest];
    }
}

#pragma mark - FWRequestDelegate

- (void)RequestDidSuccess:(FWRequest *)request {
    if (request.IsSuccess)
    {
        if ([request.Tag isEqual: API_USER_COORDINATES]) {
            return;
        }
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSDictionary *mainDict = request.serverData;
            NSDictionary *userdict = [mainDict objectForKey:@"user"];
            BOOL saved = YES;
            @try {
                [FEMDeserializer fillObject:self fromRepresentation:userdict mapping:[User defaultMapping]];
            } @catch (NSException *exception) {
                saved = NO;
                [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                     @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                     @"Exception":exception.description,
                                                                     @"UserId":self.entity_id,
                                                                     @"RequestTag":request.Tag,
                                                                     @"RequestMethod":@"GET",
                                                                     @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            } @finally {
                if (_userLoadedBlock) {
                    _userLoadedBlock(saved,nil);
                }
            }
            // For testing purpose only
            //[self setShow_balance_forward:[NSNumber numberWithBool:NO]];
            
            //[FEMDeserializer objectFromRepresentation:userdict mapping:[User defaultMapping] context:localContext];
        }];
    }
}

- (void)RequestDidFailForRequest:(FWRequest *)request withError:(NSString *)error{
    if ([request.Tag isEqual: API_USER_COORDINATES]) {
        NSLog(@"Could not update location. Error : %@", error);
    }else{
        NSError *error;
//        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Error" message: error.localizedDescription delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//        [alrt show];
        _userLoadedBlock(false,error);
    }
}

@end
