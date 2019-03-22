#import "FWPDFForm.h"
#import "CDHelper.h"
#import "FWRequestKit.h"
#import "PDFField.h"
#import "Estimate.h"
#import "Appointment.h"

@interface FWPDFForm ()

// Private interface goes here.

@end

@implementation FWPDFForm

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[FWPDFForm entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[FWPDFForm class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
    [mapping addToManyRelationshipMapping:[PDFField defaultMapping] forProperty:@"fields" keyPath:@"fields"];

    //mapping.primaryKey = @"entity_id";
    
    return mapping;
}

- (void) downloadWithAppointment:(Appointment*) appointment andCompletionBlock:(DownloadFileCompletionBlock)block
{
    // work_orders/%d/pdf_forms/%d.pdf
    NSFileManager *mg = [NSFileManager defaultManager];
    NSString *path = [self pdfFilePathWithAppointment:appointment];
    if (![mg fileExistsAtPath:path]) {
        NSString *url_part = [NSString stringWithFormat:@"/work_orders/%d/pdf_forms/%d.pdf?nameformat=new", self.appointment.entity_idValue, self.entity_idValue];
        [FWRequest downloadFile:url_part saveToFilePath:path withCompletionBlock:^(FWRequest *request) {
            NSLog(@"File Downloaded %@", path);
            if (block) {
                block(request);
            }
        }];
    }
}

- (void) downloadWithEstimate:(Estimate*) estimate andCompletionBlock:(DownloadFileCompletionBlock)block
{
    // work_orders/%d/pdf_forms/%d.pdf
    NSFileManager *mg = [NSFileManager defaultManager];
    NSString *path = [self pdfFilePathWithEstimate:estimate];
    if (![mg fileExistsAtPath:path]) {
        NSString *url_part = [NSString stringWithFormat:@"/estimates/%@/pdf_forms/%d.pdf?nameformat=new", self.estimate.entity_id, self.entity_idValue];
        [FWRequest downloadFile:url_part saveToFilePath:path withCompletionBlock:^(FWRequest *request) {
            NSLog(@"File Downloaded %@", path);
            if (block) {
                block(request);
            }
        }];
    }
}

- (void) downloadWithEstimate:(Estimate*) estimate
{
    [self downloadWithEstimate:estimate andCompletionBlock:nil];
}

- (void) downloadWithAppointment:(Appointment*) appointment
{
    // work_orders/%d/pdf_forms/%d.pdf
    [self downloadWithAppointment:appointment andCompletionBlock: nil];
}



- (NSString *)getFileNameWithAppointment:(Appointment*) appointment {
    //    if(appointment!=NULL){
    //        NSString* appointmentEndsDate=[appointment ends_at_date];
    //        if ((appointmentEndsDate!=NULL)&&(appointmentEndsDate.length>8)) {
    //            NSString* date=[appointmentEndsDate substringToIndex:8];
    //            return [NSString stringWithFormat:@"%@-%d-%@", date,self.appointment.entity_idValue,self.entity_id ];
    //
    //        }
    //    }

    
    //        FWPDFForm* pdf=[FWPDFForm e]
    NSString* returnStatement=[NSString stringWithFormat:@"#%d -%@-[%@]-form",appointment.entity_idValue,self.name,self.entity_id];
    //    NSString* filename=[NSString stringWithFormat:@"#%@-%@-[%@]-form",appointment.entity_id,self.name,self.entity_id ];
    return returnStatement;
    
    
    //    return [NSString stringWithFormat:@"%d_%d", self.entity_idValue, self.appointment.entity_idValue];
}


- (NSString *)getFileNameWithEstimate:(Estimate*) estimate {
//    if(appointment!=NULL){
//        NSString* appointmentEndsDate=[appointment ends_at_date];
//        if ((appointmentEndsDate!=NULL)&&(appointmentEndsDate.length>8)) {
//            NSString* date=[appointmentEndsDate substringToIndex:8];
//            return [NSString stringWithFormat:@"%@-%d-%@", date,self.appointment.entity_idValue,self.entity_id ];
//
//        }
//    }

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:estimate.expires_on];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSString* dateStr=@"";
    if ((day>9)&&(month>9)) {
        dateStr=[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    }else{
        if ((day<10)&&(month<10)){
            dateStr=[NSString stringWithFormat:@"%ld-0%ld-0%ld",year,month,day];
        }
        else{
            if (month<10) {
                dateStr=[NSString stringWithFormat:@"%ld-0%ld-%ld",year,month,day];
            }
            else{
                if (day<10) {
                    dateStr=[NSString stringWithFormat:@"%ld-%ld-0%ld",year,month,day];
                }
                else{
                    dateStr=[NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
                }
            }
        }
    }
    
    //        FWPDFForm* pdf=[FWPDFForm e]
    NSString* returnStatement=[NSString stringWithFormat:@"%@-#%@ -%@-[%@]-form", dateStr,estimate.entity_id,self.name,self.entity_id];
//    NSString* filename=[NSString stringWithFormat:@"#%@-%@-[%@]-form",appointment.entity_id,self.name,self.entity_id ];
    return returnStatement;

    
//    return [NSString stringWithFormat:@"%d_%d", self.entity_idValue, self.appointment.entity_idValue];
}

-(NSString *)pdfFilePathWithAppointment:(Appointment*)appointment{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",[self getFileNameWithAppointment:appointment]]];
    return finalPath;
}

-(NSString *)pdfFilePathWithEstimate:(Estimate*)estimate{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"est-%@.pdf",[self getFileNameWithEstimate:estimate]]];
    return finalPath;
}


- (void) openPdfForEditingWithFromRect:(CGRect) rect andInView:(UIView*) view appointment:(Appointment *)apponitment
{
    NSString *fullPath = [self pdfFilePathWithAppointment:apponitment];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    if (isExists == NO) {
        //[self download];
    }
    
    NSURL * URL = [NSURL fileURLWithPath:[self pdfFilePathWithAppointment:apponitment]];
    UIDocumentInteractionController *_documentInteractionController;
    
    if (URL) {
        // Initialize Document Interaction Controller
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        // Configure Document Interaction Controller
        [_documentInteractionController setDelegate:nil];
        // Present Open In Menu
        [_documentInteractionController presentOpenInMenuFromRect:rect inView:view animated:YES];
    }
}

//- (PDFAttachment *)getRelatedAttachment {
//    Appointment *app = self.appointment;
//    if (app.attachments != nil && app.attachments.count > 0) {
//        for (PDFAttachment *att in [app.attachments allObjects]) {
//            if ([att.attached_pdf_form_file_name isEqualToString:self.name]) {
//                return att;
//            }
//        }
//    }
//    return nil;
//}

+ (FWPDFForm*) getById:(NSNumber*)pdf_id appointmentId:(NSNumber*)app_id
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"entity_id == %@ AND appointment_id == %@", pdf_id, app_id];
    FWPDFForm *form = [FWPDFForm MR_findFirstWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    if (form == nil) {
        // try to find old FWPDFForm (without appointment_id) be relationship with Appointment
        predicate = [NSPredicate predicateWithFormat:@"entity_id == %@ AND appointment.entity_id == %@", pdf_id, app_id];
        form = [FWPDFForm MR_findFirstWithPredicate:predicate];
    }
    return form;
}

- (PDFAttachment *)getRelatedAttachment {
    Appointment *app = self.appointment;
    if (!app) {
        return [self getEstimateAttachment];
    }
    if (app.attachments != nil && app.attachments.count > 0) {
        for (PDFAttachment *att in [app.attachments allObjects]) {
            if ([att.pdf_form_id isEqualToNumber:self.entity_id]) {
                return att;
            }
        }
    }
    return nil;
}

- (PDFAttachment *)getRelatedAttachmentForAppointId:(NSNumber*)app_id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pdf_form_id == %@ AND appointment_occurrence_id == %@", self.entity_id, app_id];
//    PDFAttachment *attachment = [PDFAttachment MR_findFirstInContext:[NSManagedObjectContext MR_defaultContext] ];
    PDFAttachment *attachment = [PDFAttachment MR_findFirstWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext] ];
    return attachment;
//    Appointment *app = self.appointment;
//    if (!app) {
//        return [self getEstimateAttachment];
//    }
//    if (app.attachments != nil && app.attachments.count > 0) {
//        for (PDFAttachment *att in [app.attachments allObjects]) {
//            if ([att.pdf_form_id isEqualToNumber:self.entity_id]) {
//                return att;
//            }
//        }
//    }
//    return nil;
}

- (PDFAttachment *)getEstimateAttachment {
    Estimate *app = self.estimate;
    if (app.attachments != nil && app.attachments.count > 0) {
        for (PDFAttachment *att in [app.attachments allObjects]) {
            if ([att.pdf_form_id isEqualToNumber:self.entity_id]) {
                return att;
            }
        }
    }
    return nil;
}
@end
