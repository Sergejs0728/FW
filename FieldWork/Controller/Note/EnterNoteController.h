//
//  EnterNoteController.h
//  FieldWork
//
//  Created by SamirMAC on 12/16/15.
//
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

typedef void(^EnterNoteBlock)(BOOL save_clicked, NSString *text_entered);


@interface EnterNoteController : UIViewController<UITextViewDelegate>
{
    __weak IBOutlet UIPlaceHolderTextView *_txtView;
}




+ (EnterNoteController*) viewControllerWithExistingText:(NSString*)text placeholder:(NSString*)placeholder title:(NSString*)title returnBlock:(EnterNoteBlock)block;



@end
