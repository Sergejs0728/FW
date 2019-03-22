#import "_PDFAttachment.h"

@interface PDFAttachment : _PDFAttachment <UIDocumentInteractionControllerDelegate,FWRequestDelegate>
{}

+ (FEMMapping *)defaultMapping ;

+ (PDFAttachment*) newPDFAttachmentWithAppointmentId:(NSNumber*)appt_id andPDFForm:(FWPDFForm*) pdfForm;

//+ (PDFAttachment *)newPDFAttachmentWithAppointmentId:(NSNumber *)appt_id filename:(NSString*) filename;

- (NSString *)getFileName;

- (NSString *)pdfFilePath;

+(NSArray*)getAttachmentsForSync;

- (void) download;

- (void) downloadWithCompletionBlock:(DownloadFileCompletionBlock)block;

- (void) openPdfForEditingWithFromRect:(CGRect) rect andInView:(UIView*) view;

- (void) upload;

- (void) uploadWithPDFid:(NSString*) pdfId;

- (void) uploadWithPDF;

- (void) postPDFAttachment;

+ (NSArray*)getDirtyForAppointmentId:(NSNumber*)app_id;

@end
