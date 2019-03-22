#import "PhotoAttachment.h"
#import "CDHelper.h"
#import "Appointment.h"
#import "UIImage+ResizeMagick.h"
#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>
#import <stdlib.h>
#import "SyncManager.h"
#import "Estimate.h"
#import "NSManagedObject+Mapping.h"

@interface PhotoAttachment ()

// Private interface goes here.

@end

@implementation PhotoAttachment

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[PhotoAttachment entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[PhotoAttachment class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
    [mapping addAttribute:[PhotoAttachment dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (PhotoAttachment*) newPhotoWithAppointmentId:(NSNumber*)appt_id
{
    PhotoAttachment *pa = [PhotoAttachment MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [pa setEntity_status:c_ADDED];
    [pa setEntity_idValue:[Utils RandomId]];
    [pa setAppointment_occurrence_id:appt_id];
    return pa;
}

+ (PhotoAttachment*) newPhotoWithEstimate:(Estimate*)est
{
    PhotoAttachment *pa = [PhotoAttachment MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [pa setEntity_status:c_ADDED];
    [pa setEntity_idValue:[Utils RandomId]];
    [pa setEstimate:est];
    return pa;
}

+ (PhotoAttachment*) getById:(NSNumber*)ph_id
{
    return [PhotoAttachment MR_findFirstByAttribute:@"entity_id" withValue:ph_id];
}

+ (NSMutableArray*) getPhotosWithAppointmentId:(NSNumber*)appt_id
{
    return [PhotoAttachment MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@", appt_id]].mutableCopy;
}

+ (NSArray*) getPhotosForSync {
    NSArray *photos = [PhotoAttachment MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    photos = [photos filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"entity_status != %@ AND sync_status == %@", c_DELETED, c_DIRTY]];
    return photos;
}

+ (void) removeDeleteAttachmentsForAppontment:(Appointment*)app {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appointment_occurrence_id == %@ AND entity_status == %@ ", app.entity_id, c_DELETED];
    [PhotoAttachment MR_deleteAllMatchingPredicate:predicate];
}

+ (NSArray*) getSyncingPhotos {
    NSArray *photos = [PhotoAttachment MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    photos = [photos filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"entity_status != %@ AND sync_status == %@", c_DELETED, c_SYNC]];
    return photos;
}

+ (NSArray*)getDirtyForAppointmentId:(NSNumber*)app_id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(entity_status == %@ OR entity_status == %@) AND appointment_occurrence_id == %@", c_ADDED, c_EDITED, app_id];
    NSArray *attachments = [PhotoAttachment MR_findAllWithPredicate:predicate];
    return attachments;
}

- (NSString*) getImgName
{
    if(self.appointment_occurrence_idValue){
        return [NSString stringWithFormat:@"%d_photo_%d", [self.entity_id intValue], self.appointment_occurrence_idValue];
    }
    else{
        return [NSString stringWithFormat:@"%d_photo_%@", [self.entity_id intValue], self.estimate.entity_id];
    }
}

- (NSString*) getImgName:(NSNumber *)photoId
{
    return [NSString stringWithFormat:@"%d_photo_%d", [photoId intValue], self.appointment_occurrence_idValue];
}

-(NSString *)ImageFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[self getImgName]]];
    return finalPath;
}

-(NSString *)ImageFilePath:(NSNumber *)photoId {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[self getImgName:photoId]]];
    return finalPath;
}

-(NSString *)thumbFilePath {
    NSString *dataPath = [PhotoAttachment thumbnailsFolderPath];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    NSString *finalPath=[dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"thumb_%@.png",[self getImgName]]];
    return finalPath;
}

-(NSString *)thumbFilePath:(NSNumber *)photoId {
    NSString *dataPath = [PhotoAttachment thumbnailsFolderPath];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    NSString *finalPath=[dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"thumb_%@.png",[self getImgName:photoId]]];
    return finalPath;
}

+ (NSString *)thumbnailsFolderPath {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    NSString *dataPath = [documentDirectory stringByAppendingPathComponent:@"/Thumbnails"];
    return dataPath;
}

+ (BOOL)isTnumbnailsFolderExists {
    NSString *dataPath = [self thumbnailsFolderPath];
    return [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
}

+ (void)clearThumbnailsFolder {
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSString *directory = [self thumbnailsFolderPath];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
    
    while (files.count > 0) {
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:directory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [directory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:directory error:nil];
                if (!removeSuccess) {
                    // Error
                    NSLog(@"error: %@", error.localizedDescription);
                }
            }
        } else {
            // Error
            NSLog(@"error: %@", error.localizedDescription);
        }
    }
}

- (void)clearImages {
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSString *path = [self thumbFilePath];
    BOOL removeSuccess = [fileMgr removeItemAtPath:path error:&error];
    if (!removeSuccess) {
        // Error
        NSLog(@"error: %@", error.localizedDescription);
    }
    path = [self ImageFilePath];
    removeSuccess = [fileMgr removeItemAtPath:path error:&error];
    if (!removeSuccess) {
        // Error
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (UIImage*)getImg {
    NSString *path = [self ImageFilePath];
    
    //    NSData *imgData = [NSData dataWithContentsOfFile:path];
    //    UIImage *img = [UIImage imageWithData:imgData];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    ///Users/irina/Library/Developer/CoreSimulator/Devices/84279F0F-C84F-4405-A4A3-8538C4C84658/data/Containers/Data/Application/C249C9CC-54AF-4760-AAE9-B114B4133D76/Documents/26691_photo_1635030.png
    return img;
}

- (UIImage*)getThumb {
    NSString *path = [self thumbFilePath];
    
    //    NSData *imgData = [NSData dataWithContentsOfFile:path];
    //    UIImage *mg = [UIImage imageWithData:imgData];
    UIImage *mg = [UIImage imageWithContentsOfFile:path];
    return mg;
}

- (void)createThumbForImage:(UIImage*)img {
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImage *thumb = [img resizedImageWithMaximumSize:CGSizeMake(300, 300)];
    [UIImagePNGRepresentation(thumb) writeToFile:[self thumbFilePath] atomically:YES];
    //    });
    
}

- (void)renameImagesFrom:(NSNumber*)localId to:(NSNumber *)serverId {
    NSError * err = nil;
    NSFileManager * fm = [[NSFileManager alloc] init];
    BOOL result = [fm moveItemAtPath:[self ImageFilePath:localId] toPath:[self ImageFilePath:serverId] error:&err];
    if(!result)
        NSLog(@"Error: %@", err);
    result = [fm moveItemAtPath:[self thumbFilePath:localId] toPath:[self thumbFilePath:serverId] error:&err];
    if(!result)
        NSLog(@"Error: %@", err);
}

- (void) downloadWithCompletionHandler:(DownloadCompletion)completion;
{
    NSString *url_part ;
    
    if (self.estimate) {
        url_part = [NSString stringWithFormat:@"/estimates/%@/photo_attachments/%d/download", self.estimate.entity_id, self.entity_idValue];
    }
    else{
        url_part = [NSString stringWithFormat:@"/work_orders/%d/photo_attachments/%d/download", self.appointment_occurrence_idValue, self.entity_idValue];
    }
    NSFileManager *mg = [NSFileManager defaultManager];
    NSString *path = [self ImageFilePath];
    if ([mg fileExistsAtPath:path]) {
        NSDictionary *attributes = [mg attributesOfItemAtPath:path error:nil];
        NSDate *date = [attributes fileModificationDate];
        if ([[self.updated_at laterDate:date] isEqual:self.updated_at]) {
            [FWRequest downloadFile:url_part saveToFilePath:path withCompletionBlock:^(FWRequest *request) {
                NSLog(@"File Downloaded %@", path);
                UIImage *img = [self getImg];
                [self createThumbForImage:img];
                if (completion != nil) {
                    completion(img);
                }
            }];
        }
    } else {
        [FWRequest downloadFile:url_part saveToFilePath:path withCompletionBlock:^(FWRequest *request) {
            NSLog(@"File Downloaded %@", path);
            UIImage *img = [self getImg];
            [self createThumbForImage:img];
            if (completion != nil) {
                completion(img);
            }
        }];
    }
    
}

- (void)saveImageOnLocal:(UIImage *)image WithCompletion:(TaskCompleted)completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block BOOL isDone = [UIImagePNGRepresentation(image) writeToFile:[self ImageFilePath] atomically:YES];
        [self createThumbForImage:image];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image, isDone);
            });
        }
    });
}

- (void) discard
{
    [[NSManagedObjectContext MR_defaultContext] rollback];
    [[NSManagedObjectContext MR_defaultContext] refreshObject:self mergeChanges:NO];
    // To reload the object, we need to access it
    NSLog(@"%@", self.entity_status);
}

- (void) savePhoto
{
    if (![self.entity_status isEqualToNumber:c_ADDED] && ![self.entity_status isEqualToNumber:c_DELETED]) {
        [self setEntity_status:c_EDITED];
    }
    [self.appointment setEntity_status:c_EDITED];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void) upload
{
    if (self.estimate) {
        [self uploadEstimate];
        return;
    }
    if (self.appointment_occurrence_idValue != 0) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:self.comments forKey:@"photo_attachment[comments]"];
        NSString *file_path = [self ImageFilePath];
        RequestMethod method = POST;
        NSString *server_url = [NSString stringWithFormat:@"work_orders/%d/photo_attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"work_orders/%d/photo_attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
        // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
        __block Appointment *relation_appt = self.appointment;
        NSLog(@"uploading photo %@ ...", [self ImageFilePath]);
        [FWRequest uploadFile:file_path file_name:@"image.jpg" withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (request.IsSuccess) {
                    //                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                    NSDictionary *main = request.serverData;
                    NSDictionary *attachment = [main objectForKey:@"photo_attachment"];
                    PhotoAttachment *photo = [self MR_inContext:[NSManagedObjectContext MR_defaultContext]];
                    NSNumber *localId = photo.entity_id;
                    @try {
                        PhotoAttachment *uploadedPhoto = [FEMDeserializer fillObject:photo fromRepresentation:attachment mapping:[PhotoAttachment defaultMapping]];
                        [self renameImagesFrom:localId to:uploadedPhoto.entity_id];
                        photo.appointment = [relation_appt MR_inContext:[NSManagedObjectContext MR_defaultContext]];
                        [photo setEntity_status:c_UNCHANGED];
                        [photo setSync_status:c_UNCHANGED];
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    } @catch (NSException *exception) {
                        [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                             @"Method":NSStringFromSelector(@selector(upload)),
                                                                             @"Exception":exception.description,
                                                                             @"UserId":self.entity_id,
                                                                             @"RequestTag":server_url,
                                                                             @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                    }
                    //                } completion:^(BOOL contextDidSave, NSError *error) {
                    //                            [self downloadWithCompletionHandler:nil];
                    
                    NSLog(@"photo uploaded %@", [self ImageFilePath]);
                    //                }];
                }
                else {
                    if (request.StatusCode == 422) { //Unprocessable Entity
                        NSString *file_path = [self ImageFilePath];
                        NSFileManager *fm = [NSFileManager defaultManager];
                        if ([fm fileExistsAtPath:file_path] && [fm isDeletableFileAtPath:file_path]) {
                            NSError *error = nil;
                            BOOL success = [[NSFileManager defaultManager] removeItemAtPath:file_path error:&error];
                            if (!success) {
                                NSLog(@"Error removing file at path: %@", error.localizedDescription);
                            }
                        }
                        [self MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    } else {
                        [self setSync_status:c_DIRTY];
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:nil];
                        [[SyncManager Instance] syncPhotos];
                        NSLog(@"photo uploading error %@", request.error.description);
                    }
                    
                }
            });
        }];
    }
    
}
- (void) uploadEstimate
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.comments forKey:@"photo_attachment[comments]"];
    NSString *file_path = [self ImageFilePath];
    RequestMethod method = POST;
    NSString *server_url = [NSString stringWithFormat:@"estimates/%@/photo_attachments", self.estimate.entity_id];
    if ([self.entity_status isEqualToNumber:c_EDITED]) {
        method = PUT;
        server_url = [NSString stringWithFormat:@"estimates/%@/photo_attachments/%d", self.estimate.entity_id, self.entity_idValue];
    }
    // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
    __block Estimate *relation_appt = self.estimate;
    NSLog(@"uploading photo %@ ...", [self ImageFilePath]);
    [FWRequest uploadFile:file_path file_name:@"image.jpg" withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
        if (request.IsSuccess) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                NSDictionary *main = request.serverData;
                NSDictionary *attachment = [main objectForKey:@"photo_attachment"];
                PhotoAttachment *photo = [self MR_inContext:localContext];
                NSNumber *localId = photo.entity_id;
                @try {
                    PhotoAttachment *uploadedPhoto = [FEMDeserializer fillObject:photo fromRepresentation:attachment mapping:[PhotoAttachment defaultMapping]];
                    [self renameImagesFrom:localId to:uploadedPhoto.entity_id];
                    photo.estimate = [relation_appt MR_inContext:localContext];
                    [photo setEntity_status:c_UNCHANGED];
                    [photo setSync_status:c_UNCHANGED];
                } @catch (NSException *exception) {
                    [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                         @"Method":NSStringFromSelector(@selector(upload)),
                                                                         @"Exception":exception.description,
                                                                         @"UserId":self.entity_id,
                                                                         @"RequestTag":server_url,
                                                                         @"ServerDataClass":NSStringFromClass([request.serverData class])}];
                }
            } completion:^(BOOL contextDidSave, NSError *error) {
                
                //                [self downloadWithCompletionHandler:nil];
                NSLog(@"photo uploaded %@", [self ImageFilePath]);
            }];
        }
        else {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                PhotoAttachment *photo = [self MR_inContext:localContext];
                photo.estimate = [self.estimate MR_inContext:localContext];
                [photo setSync_status:c_DIRTY];
                [photo.appointment.photo_attachmentsSet addObject:photo];
                [photo.appointment setEntity_status:c_EDITED];
                [photo.appointment setError_sync_message:@"Photo didn't upload."];
            } completion:^(BOOL contextDidSave, NSError *error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:nil];
                [[SyncManager Instance] syncPhotos];
                NSLog(@"photo uploading error %@", request.error.description);
            }];
            
            //            NSString *message = [NSString stringWithFormat:@"Photo for order #%@ didn't upload. Trying again...", self.appointment_occurrence_id];
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
            //                                                            message:message
            //                                                           delegate:nil
            //                                                  cancelButtonTitle:@"OK"
            //                                                  otherButtonTitles:nil];
            //            [alert show];
        }
    }];
}


@end
