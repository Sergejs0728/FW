#import "_PhotoAttachment.h"

@interface PhotoAttachment : _PhotoAttachment {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (PhotoAttachment*) getById:(NSNumber*)ph_id;

- (NSString*) getImgName;

- (NSString *)ImageFilePath;

- (NSString *)thumbFilePath;

- (UIImage*)getImg;

- (UIImage*)getThumb;

- (void)createThumbForImage:(UIImage*)img;

- (void) downloadWithCompletionHandler:(DownloadCompletion)completion;;

+ (PhotoAttachment*) newPhotoWithAppointmentId:(NSNumber*)appt_id;

+ (PhotoAttachment*) newPhotoWithEstimate:(Estimate*)est;

+ (NSMutableArray*) getPhotosWithAppointmentId:(NSNumber*)appt_id;

+ (NSArray*) getPhotosForSync;

+ (void) removeDeleteAttachmentsForAppontment:(Appointment*)app;

+ (NSArray*) getSyncingPhotos;

+ (NSArray*)getDirtyForAppointmentId:(NSNumber*)app_id;

+ (BOOL) isTnumbnailsFolderExists;

+ (void) clearThumbnailsFolder;

- (void) discard;

- (void) savePhoto;

- (void) clearImages;

- (void) saveImageOnLocal:(UIImage*)image WithCompletion:(TaskCompleted)completion;

- (void) upload;

//- (void) uploadEstimate;

@end
