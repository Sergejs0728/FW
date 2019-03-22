#import "_FWPDFForm.h"
#import "PDFAttachment.h"

@interface FWPDFForm : _FWPDFForm <UIDocumentInteractionControllerDelegate>
{}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (FWPDFForm*) getById:(NSNumber*)pdf_id appointmentId:(NSNumber*)app_id;

- (void) downloadWithAppointment:(Appointment*) appointment andCompletionBlock:(DownloadFileCompletionBlock)block;

- (void) downloadWithAppointment:(Appointment*) appointment;

- (NSString *)pdfFilePathWithAppointment:(Appointment*)appointment;

- (NSString *)getFileNameWithAppointment:(Appointment*) appointment ;

- (void) openPdfForEditingWithFromRect:(CGRect) rect andInView:(UIView*) view appointment:(Appointment*) apponitment;

- (PDFAttachment*) getRelatedAttachment;

- (PDFAttachment *)getRelatedAttachmentForAppointId:(NSNumber*)app_id;

- (void) downloadWithEstimate:(Estimate*) estimate andCompletionBlock:(DownloadFileCompletionBlock)block;

- (void) downloadWithEstimate:(Estimate*) estimate;
-(NSString *)pdfFilePathWithEstimate:(Estimate*)estimate;
- (PDFAttachment *)getEstimateAttachment ;
@end
