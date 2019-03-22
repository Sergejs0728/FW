//
//  EnterNoteController.m
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import "EnterNoteController.h"

@interface EnterNoteController ()<UITextViewDelegate>

@property (nonatomic, retain, readwrite) NSString *existing_text;
@property (nonatomic, retain, readwrite) NSString *placeholder;
@property (nonatomic, copy) EnterNoteBlock savedBlock;

@end
#define kOFFSET_FOR_KEYBOARD 80.0

@implementation EnterNoteController

+ (EnterNoteController *)viewControllerWithExistingText:(NSString *)text placeholder:(NSString *)placeholder title:(NSString *)title returnBlock:(EnterNoteBlock)block {

    
    EnterNoteController * notes = [[EnterNoteController alloc]initWithNibName:@"EnterNoteController" bundle:nil];
    notes.title =title;
    notes.existing_text = text;
    notes.placeholder = placeholder;
    notes.savedBlock = block;
    return notes;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_txtView becomeFirstResponder];
    _txtView.placeholder = self.placeholder;
    _txtView.text = self.existing_text;
    _txtView.delegate = self;
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveClicked)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *btnClose = [UIBarButtonItem barButtonWithTitle:@"Close" andBlock:^{
        if (self.savedBlock) {
            self.savedBlock(NO, _txtView.text);
        }
        [_txtView resignFirstResponder];
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [btnClose setTextColor:RED_COLOR];
    self.navigationItem.leftBarButtonItem = btnClose;
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    int limit = 2000;
    UITextView *txt = _txtView;
//    UILabel *lbl = _characterlbl;
//    if (textView.tag == 1001) {
//        txt = _txtPrivateNote;
//        lbl = _lblPrivateCount;
//    }
//
    if (txt.text.length > limit) {
        txt.text = [txt.text substringToIndex:limit];
    }
//    int len = (int)txt.text.length;
//    lbl.text=[NSString stringWithFormat:@"%i",2000-len];
//
//    _shouldAskForUnsavedData = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL flag = NO;
//    _shouldAskForUnsavedData = YES;
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            flag = YES;
            return YES;
        }
        else {
            return NO;
        }
    }
    else if([[textView text] length] > 1999)
    {
        return NO;
    }
    return YES;
}

- (void) saveClicked
{
    if (self.savedBlock) {
        self.savedBlock(YES, _txtView.text);
    }
    [_txtView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
