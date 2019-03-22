#import "PDFAttachment.h"
#import "GameTimer.h"
#import "CDHelper.h"
#import "Appointment.h"
#import "PDFField.h"
#import "FWPDFForm.h"
#import "Estimate.h"
#import "NSManagedObject+Mapping.h"

@interface PDFAttachment ()

// Private interface goes here.
@end

@implementation PDFAttachment

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[PDFAttachment entityName]];
    NSMutableDictionary *dict = [[CDHelper mappingForClass:[PDFAttachment class]] mutableCopy];
    
    [mapping addAttributesFromDictionary:dict];
    [mapping addAttribute:[PDFAttachment dateTimeGMT0AttributeFor:@"updated_at" andKeyPath:@"updated_at"]];
    [mapping addToManyRelationshipMapping:[PDFField defaultMapping] forProperty:@"field_values" keyPath:@"field_values"];
    mapping.primaryKey = @"entity_id";
    
    return mapping;
}

+ (PDFAttachment *)newPDFAttachmentWithAppointmentId:(NSNumber *)appt_id andPDFForm:(FWPDFForm *)pdfForm{
    PDFAttachment *attachment = [PDFAttachment MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    [attachment setEntity_status:c_ADDED];
    [attachment setAppointment_occurrence_id:appt_id];
    [attachment setEntity_id:[NSNumber numberWithInt:[Utils RandomId]]];
    [attachment setPdf_form:pdfForm];
    return attachment;
}

//+ (PDFAttachment *)newPDFAttachmentWithAppointmentId:(NSNumber *)appt_id filename:(NSString*) filename{
//    PDFAttachment *attachment = [PDFAttachment newPDFAttachmentWithAppointmentId:appt_id];
//    [attachment setAttachment_file_name:filename];
//    return attachment;
//}

- (NSString *)getFileName {
    
    //    if ((appointmentEndsDate!=NULL)&&(appointmentEndsDate.length>8)) {
    FWPDFForm* form=[[FWPDFForm MR_findByAttribute:@"entity_id" withValue:self.pdf_form_id] firstObject];
    
    //        FWPDFForm* pdf=[FWPDFForm e]
    NSString* returnStatement=[NSString stringWithFormat:@"#%d -%@-[%@]-att",self.appointment_occurrence_idValue,form.name,form.entity_id];
    return returnStatement;
    
    //    }
    
    //   return [NSString stringWithFormat:@"att_%d_%d", self.entity_idValue, self.appointment_occurrence_idValue];
}

//-(NSString*) getAttached_pdf_form_file_name{
//    return self.attached_pdf_form_file_name;
//}


-(NSString *)pdfFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
    
    NSString *finalPath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",[self getFileName]]];
    return finalPath;
}

- (void) download
{
    // work_orders/%d/attachments/%d.pdf?api_key=%@
    [self downloadWithCompletionBlock:nil];
}

- (void) downloadWithCompletionBlock:(DownloadFileCompletionBlock)block
{
    // work_orders/%d/attachments/%d.pdf?api_key=%@
    NSFileManager *mg = [NSFileManager defaultManager];
    NSString *path = [self pdfFilePath];
    NSString *url_part =@"";
    if (self.estimate) {
        url_part=[NSString stringWithFormat:@"/estimates/%d/attachments/%d.pdf?nameformat=new", self.appointment_occurrence_idValue, self.entity_idValue];
    }else{
        url_part=[NSString stringWithFormat:@"/work_orders/%d/attachments/%d.pdf?nameformat=new", self.appointment_occurrence_idValue, self.entity_idValue];
    }
    
    if ([mg fileExistsAtPath:path]) {
        NSDictionary *attributes = [mg attributesOfItemAtPath:path error:nil];
        NSDate *date = [attributes fileModificationDate];
        if ([[self.updated_at laterDate:date] isEqual:self.updated_at]) {
            if ([[NSFileManager defaultManager] isDeletableFileAtPath:path]) {
                NSError *error = nil;
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                if (error) {
                    NSLog(@"Error deleting pdf attachment %@ from app %@ : %@", self.entity_id, self.appointment_occurrence_id, error);
                }
            }
            [self forceDownloadFromUrl:url_part completion:block];
        }
    } else {
        [self forceDownloadFromUrl:url_part completion:block];
    }
}

- (void)forceDownloadFromUrl:(NSString*) url_part completion:(DownloadFileCompletionBlock)block {
    [FWRequest downloadFile:url_part saveToFilePath:[self pdfFilePath] withCompletionBlock:^(FWRequest *request) {
        NSLog(@"File Downloaded %@", [self pdfFilePath]);
        if (block) {
            block(request);
        }
    }];
    
}

- (void) openPdfForEditingWithFromRect:(CGRect) rect andInView:(UIView*) view
{
    NSString *fullPath = [self pdfFilePath];
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    if (isExists == NO) {
        //[self download];
    }
    
    NSURL * URL = [NSURL fileURLWithPath:[self pdfFilePath]];
    UIDocumentInteractionController *_documentInteractionController;
    
    if (URL) {
        // Initialize Document Interaction Controller
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        // Configure Document Interaction Controller
        [_documentInteractionController setDelegate:self];
        // Present Open In Menu
        [_documentInteractionController presentOpenInMenuFromRect:rect inView:view animated:YES];
    }
}

- (void) upload
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.attached_pdf_form_file_name forKey:@"name"];
    [dict setValue:self.attachment_file_name forKey:@"filename"];
    NSString *file_path = [self pdfFilePath];
    RequestMethod method = POST;
    NSString * server_url=@"";
    if(self.estimate){
        server_url = [NSString stringWithFormat:@"estimates/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"estimates/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    else{
        server_url = [NSString stringWithFormat:@"work_orders/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"work_orders/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
    __block Appointment *relation_appt = self.appointment;
    [FWRequest uploadFile:file_path file_name:self.attached_pdf_form_file_name withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
        if (request.IsSuccess) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                PDFAttachment *attachment = [self MR_inContext:localContext];
                attachment.appointment = [relation_appt MR_inContext:localContext];
                [attachment setEntity_status:c_UNCHANGED];
            } completion:^(BOOL contextDidSave, NSError *error) {
                [self download];
            }];
        }
        
    }];
}

- (void) uploadWithPDF{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.attached_pdf_form_file_name forKey:@"name"];
    [dict setValue:self.attachment_file_name forKey:@"filename"];
    NSString *file_path = [self pdfFilePath];
    RequestMethod method = POST;
    NSString * server_url=@"";
    if(self.estimate){
        server_url = [NSString stringWithFormat:@"estimates/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"estimates/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    else{
        server_url = [NSString stringWithFormat:@"work_orders/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"work_orders/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
    __block Appointment *relation_appt = self.appointment;
    [FWRequest uploadPDFFile:file_path file_name:self.attached_pdf_form_file_name formId:[self.pdf_form_id stringValue] withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
        if (request.IsSuccess) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                PDFAttachment *attachment = [self MR_inContext:localContext];
                attachment.appointment = [relation_appt MR_inContext:localContext];
                [attachment setEntity_status:c_UNCHANGED];
            } completion:^(BOOL contextDidSave, NSError *error) {
                [self download];
            }];
        }
    }];
}

- (void) uploadWithPDFid:(NSString*) pdfId
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.attached_pdf_form_file_name forKey:@"name"];
    [dict setValue:self.attachment_file_name forKey:@"filename"];
    NSString *file_path = [self pdfFilePath];
    RequestMethod method = POST;
    NSString * server_url=@"";
    if(self.estimate){
        server_url = [NSString stringWithFormat:@"estimates/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"estimates/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    else{
        server_url = [NSString stringWithFormat:@"work_orders/%d/attachments", self.appointment_occurrence_idValue];
        if ([self.entity_status isEqualToNumber:c_EDITED]) {
            method = PUT;
            server_url = [NSString stringWithFormat:@"work_orders/%d/attachments/%d", self.appointment_occurrence_idValue, self.entity_idValue];
        }
    }
    // Somehow the appointment relation is breaking after upload call, so will hold the appointment and attach the relation again.
    __block Appointment *relation_appt = self.appointment;
    [FWRequest uploadPDFFile:file_path file_name:self.attached_pdf_form_file_name formId:pdfId withFormaData:dict onServerUrl:server_url withMethod:method withCompletionBlock:^(FWRequest *request) {
        if (request.IsSuccess) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                PDFAttachment *attachment = [self MR_inContext:localContext];
                attachment.appointment = [relation_appt MR_inContext:localContext];
                [attachment setEntity_status:c_UNCHANGED];
            } completion:^(BOOL contextDidSave, NSError *error) {
                [self download];
            }];
        }
    }];
}


-(void)postPDFAttachment{
    NSMutableArray* fields=[NSMutableArray new];
    NSArray* fieldsArray=[self.field_values array];
    for(PDFField* field in fieldsArray ){
        if (field.field_value) {
            NSMutableDictionary* item= [NSMutableDictionary dictionary];
            if (field.pdf_name) {
                [item setValue:field.pdf_name forKey:@"pdf_name"];
            }
            if (field.field_value) {
                [item setValue:field.field_value forKey:@"value"];
            }
            if (field.field_type) {
                [item setValue:field.field_type forKey:@"type"];
            }
            if (field.required) {
                item[@"required"] = [NSString stringWithFormat:@"%@", field.required];
            }
            if (field.label) {
                [item setValue:field.label forKey:@"label"];
            }
            if (field.max_length) {
                item[@"max_length"] = [NSString stringWithFormat:@"%@", field.max_length];
            }
            if (field.options) {
                [item setValue:field.options forKey:@"options"];
            }
            if (field.selected_options) {
                [item setValue:field.selected_options forKey:@"selected_options"];
            }
            [fields addObject:item];
        }
    }
    
    NSMutableDictionary* innerJson=[NSMutableDictionary dictionaryWithDictionary:@{@"pdf_form_id":self.pdf_form_id,
                                                                                   @"field_values":fields}];
    if (self.entity_idValue > 0) {
        innerJson[@"id"] = self.entity_id;
    }
    NSDictionary* json=@{@"attachment":innerJson};
    NSString* workOrderId=[NSString stringWithFormat:@"%@",self.appointment_occurrence_id];
    NSString* urlStr=[NSString stringWithFormat:API_PDF_ATTACHMENT_NEW,workOrderId];
    FWRequest *request = [[FWRequest alloc] initWithUrl:urlStr andDelegate:self];
    request.Tag = API_PDF_ATTACHMENT_NEW;
    request.methodType=POST;
    request.postParameters=[NSMutableDictionary dictionaryWithDictionary:json];
    [request startRequest];
}


- (void) RequestDidSuccess:(FWRequest*)request{
    if (request.IsSuccess){
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//            PDFAttachment *attachment = [PDFAttachment MR_createEntityInContext:localContext];
            NSDictionary *mainDict = request.serverData;
            NSDictionary *attachmentDict = [mainDict objectForKey:@"attachment"];
            BOOL saved = YES;
            @try {
                [FEMDeserializer fillObject:self fromRepresentation:attachmentDict mapping:[PDFAttachment defaultMapping]];
                [self setEntity_status:c_UNCHANGED];
            } @catch (NSException *exception) {
                saved = NO;
                [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                     @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                     @"Exception":exception.description,
                                                                     @"UserId":self.entity_id,
                                                                     @"RequestTag":request.Tag,
                                                                     @"RequestMethod":@"GET",
                                                                     @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            }
        }];
    }
}

- (void) RequestDidFailForRequest:(FWRequest*)request withError:(NSString*)error{
    
}

+(NSArray*)getAttachmentsForSync{
    NSPredicate *attachmentFilter = [NSPredicate predicateWithFormat:@"entity_status == 100 OR entity_status == 101"];
    NSArray* editedAttachments=[PDFAttachment MR_findAllWithPredicate:attachmentFilter];
    NSPredicate* fieldsPredicate=[NSPredicate predicateWithBlock:^BOOL(PDFAttachment* evaluatedObject, NSDictionary<NSString *,PDFAttachment*> *  bindings) {
        BOOL readyForSync=((evaluatedObject.field_values)||([evaluatedObject.entity_status isEqualToNumber: c_EDITED]||[evaluatedObject.entity_status isEqualToNumber: c_ADDED]));
        return readyForSync;
    }];
    //    NSArray* attachmentsWithFields=[editedAttachments filteredArrayUsingPredicate:fieldsPredicate];
    //    NSArray* attachmentsWithFields=[PDFAttachment MR_findAllWithPredicate:fieldsPredicate];
    return editedAttachments;
}

+ (NSArray*)getDirtyForAppointmentId:(NSNumber*)app_id {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(entity_status == %@ OR entity_status == %@) AND appointment_occurrence_id == %@", c_ADDED, c_EDITED, app_id];
    NSArray *attachments = [PDFAttachment MR_findAllWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
    return attachments;
}

@end
