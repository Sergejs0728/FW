//
//  SchemeDrawerControllerViewController.m
//  FieldWork
//
//  Created by Alexander on 07.09.16.
//
//

#import "SchemeDrawerControllerViewController.h"
#import "GiCanvasView.h"
#import "GiViewHelper.h"
#import "GridDrawer.h"
#import "Appointment.h"
#import "ServiceLocation.h"
#import "SchemeNoteViewController.h"

@interface SchemeDrawerControllerViewController ()
@property (weak, nonatomic) IBOutlet UIView *ToolbarView;
@property (weak, nonatomic) IBOutlet GiCanvasView *canvasView;
@property (strong,nonatomic) NSArray* tools;
@property (strong,nonatomic) NSString* filePath;
@property (strong,nonatomic) UIButton* lastTappedButton;
@property (strong,nonatomic) NSArray* images;
@property (strong,nonatomic) NSArray* imagesFocus;
@property (weak,nonatomic) IBOutlet UIButton* lineButton;
@property (weak, nonatomic) IBOutlet UIButton *selectionButton;
@property (strong,nonatomic) NSString* stageNote;
@property (nonatomic) BOOL saved;
@end

@implementation SchemeDrawerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _saved=NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Save"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(save:)];
        UIBarButtonItem *deleteBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteTapped:)];
        if (_stageModel) {
            [self.navigationItem setRightBarButtonItems:@[saveButton,deleteBarButton]];
        } else {
            [self.navigationItem setRightBarButtonItems:@[saveButton]];
        }
        [self.navigationItem setTitle:@"Scheme"];
    }
    _tools=@[@"line",@"square",@"splines", @"select",@"style",@"undo",@"redo"];
    _images=@[@"line.png",@"rect.png",@"brush.png",@"select.png"];
    _imagesFocus=@[@"line_focus.png",@"rect_focus.png",@"brush_focus.png",@"select_focus.png"];
    [_canvasView setCommand:@"line"];
    _canvasView.selectionChanged=^(){
        [self changeSelectedButton:_selectionButton];
    };
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _filePath = [NSString stringWithFormat:@"%@/%@/building/%@", documentsDirectory, _serviceLocationId, _stageTitle];
    [GridDrawer generateGrindonView:_canvasView colour:[UIColor colorWithRed:194/256 green:194/256 blue:194/256 alpha:0.075f] lineWidth:1.0f];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view layoutIfNeeded];
    if (_stageModel) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        [self.navigationItem setTitle:_stageModel.floor];
        _filePath =[NSString stringWithFormat:@"%@/%@", documentsDirectory, _stageModel.filePath];
        NSString* vgPath=[_filePath stringByAppendingString:@".vg"];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:vgPath];
        if (fileExists) {
            [_canvasView setPath:_filePath];
        }
        else{
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            [_stageModel downloadWithCompletionBlock:^(FWRequest *request) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _filePath =[NSString stringWithFormat:@"%@/%@", documentsDirectory, _stageModel.filePath];
                    [_canvasView setPath:_filePath];
                    [[ActivityIndicator currentIndicator] displayCompleted];
                });
            }];
        }
    } else {
        [_canvasView setPath:_filePath];
        [self.navigationItem setTitle:_stageTitle];
    }
    _canvasView.helper.lineWidth=-3;
}

- (IBAction)toolbarButtonTapped:(UIButton *)sender {
    NSInteger tag=sender.tag;
    [self changeSelectedButton:sender];
    NSString* command=[_tools objectAtIndex:tag];
    if([command isEqualToString:@"undo"]){
        [_canvasView undo];
    }
    else
        if([command isEqualToString:@"redo"]){
            [_canvasView redo];
        }
        else
            if([command isEqualToString:@"style"]){
                [_canvasView changeStyle];
            }
            else{
                [_canvasView setCommand:command];
            }
}

-(void)changeSelectedButton:(UIButton*)sender{
    NSInteger tag=sender.tag;
    if(!_lastTappedButton){
        _lastTappedButton=_lineButton;
    }
    if(tag<=(_images.count-1)){
        NSInteger lastTag= _lastTappedButton.tag;
        if (lastTag<=(_images.count-1)) {
            NSString* imageName=[_images objectAtIndex:lastTag];
            UIImage* image=[UIImage imageNamed:imageName];
            [_lastTappedButton setImage:image forState:UIControlStateNormal];
        }
    }
    if (tag<=(_images.count-1)) {
        NSString* imageName=[_imagesFocus objectAtIndex:tag];
        UIImage* image=[UIImage imageNamed:imageName];
        [sender setImage:image forState:UIControlStateNormal];
        _lastTappedButton=sender;
    }
}

-(void)edit:(UIBarButtonItem*)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Rename diagram"
                                                                   message:@"Do you want to rename diagram?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         __block NSString* title=[alert.textFields objectAtIndex:0].text;
                                                         [MagicalRecord saveWithBlock:^(NSManagedObjectContext * localContext) {
                                                             StageModel* localStageModel= [localContext existingObjectWithID:_stageModel.objectID error:nil];
                                                             [localStageModel setTitle:title];
                                                         } completion:^(BOOL contextDidSave, NSError *  error) {
                                                              [self.navigationItem setTitle:_stageTitle];
                                                         }];
                                                     }];
    [alert addTextFieldWithConfigurationHandler:nil];

    [alert addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"NO"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)save:(UIBarButtonItem*)sender{
    [_canvasView setCommand:@"line"];
    _saved=YES;
    if (_stageModel) {
        _stageModel.changed=@(YES);
        [_canvasView saveToFile];
        [self afterSave];
    }
    else{
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *  localContext) {
            StageModel* newStageModel = [StageModel MR_createEntityInContext:localContext];
            [newStageModel setBuilding:@"building"];
            [newStageModel setEntity_idValue:[Utils RandomId]];
            if (_stageNote) {
                [newStageModel setNotes:_stageNote];
            }
            newStageModel.changed=@(YES);
            [newStageModel setFloor:_stageTitle];
            ServiceLocation* serviceLocation= [ServiceLocation MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"entity_id == %@", _serviceLocationId] inContext:localContext];
            [newStageModel setServiceLocation:serviceLocation];
            [newStageModel setFilePath:[NSString stringWithFormat:@"%@/building/%@", _serviceLocationId, _stageTitle]];
            [localContext MR_saveToPersistentStoreAndWait];
        } completion:^(BOOL contextDidSave, NSError *  error) {
            [_canvasView saveToFile];
            [self afterSave];
        }];
    }
}

-(void)afterSave{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if(_block){
            _block();
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
    [CATransaction commit];
}

-(void)back:(UIBarButtonItem*)sender{
    BOOL hasChanges=[_canvasView.helper canUndo];
    if((!_saved)&&(hasChanges)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Save shanges?"
                                                                       message:@"Save changes in diagram"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self save:nil];
                                                         }];
        [alert addAction:okAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"NO"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 if (_stageModel == nil) {
                                                                     NSFileManager *fileManager = [NSFileManager defaultManager];
                                                                     NSError *error;
                                                                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                                     NSString *documentsDirectory = [paths objectAtIndex:0];
                                                                     [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,_filePath] error:&error];
                                                                     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                                                                 }
                                                                 [CATransaction setCompletionBlock:^{
                                                                     if(_block){
                                                                         _block();
                                                                     }
                                                                 }];
                                                                 [self.navigationController popViewControllerAnimated:YES];
                                                                 [CATransaction commit];
                                                             }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
       [super viewWillDisappear:animated];
}

- (IBAction)deleteTapped:(UIButton *)sender {
    UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:@"Do you want to delete diagram?"
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okDeleteAction = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               NSFileManager *fileManager = [NSFileManager defaultManager];
                                                               NSError *error;
                                                               [fileManager removeItemAtPath:_filePath error:&error];
                                                               [self deleteStage:_stageModel completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                                                                   if(_block){
                                                                       _block();
                                                                   }
                                                                   [self.navigationController popViewControllerAnimated:YES];
                                                               }];
                                                           }];
    [alertDelete addAction:okDeleteAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertDelete addAction:cancelAction];
    [self presentViewController:alertDelete animated:YES completion:nil];
}

- (IBAction)noteButtonTapped:(UIButton *)sender {
    [_canvasView saveToFile];
    SchemeNoteViewController *noteController = [[SchemeNoteViewController alloc] initWithNibName:@"SchemeNoteViewController" bundle:nil];
    [self.navigationController pushViewController:noteController animated:YES];
    if (_stageModel) {
        noteController.stageName=_stageModel.floor;
        noteController.stageNote=_stageModel.notes;
    }
    else{
        noteController.stageName=_stageTitle;
        noteController.stageNote=_stageNote;
    }

    noteController.noteBlock=^(NSString* note){
        if (_stageModel) {
            _stageModel.notes=note;
        }
        else{
            _stageNote=note;
        }
    };
}

-(void)deleteStage:(StageModel*) stageModel completion:(MRSaveCompletionHandler) completion{
    [stageModel setDeleted:@(YES)];
    [stageModel.managedObjectContext MR_saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
    } completion:completion];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
