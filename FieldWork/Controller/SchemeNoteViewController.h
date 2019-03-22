//
//  SchemeNoteViewController.h
//  FieldWork
//
//  Created by Alexander on 28.10.16.
//
//

#import <UIKit/UIKit.h>

typedef void(^NoteBlock)(NSString* note);

@interface SchemeNoteViewController : UIViewController
@property (strong,nonatomic) NSString* stageName;
@property (strong,nonatomic) NSString* stageNote;
@property (strong,nonatomic) NoteBlock noteBlock;
@end
