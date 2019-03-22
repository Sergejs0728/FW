//
//  AppSchemeCell.m
//  FieldWork
//
//  Created by Alexander on 06.09.16.
//
//

#import "AppSchemeCell.h"
#import "GiCanvasView.h"
#import "GiViewHelper.h"

@interface AppSchemeCell()
@property (weak, nonatomic) IBOutlet GiCanvasView *canvasView;
@property (weak, nonatomic) IBOutlet UILabel *noSchemeAddedLabel;
//@property (strong, nonatomic) 
@property (weak,nonatomic) NSString* path;
@end

@implementation AppSchemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOrderId:(NSNumber *)orderId{
    _orderId=orderId;
    [_canvasView setZoomable:NO];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, _orderId];
    if ([self fileAlreadyExist:_path]) {
        [_noSchemeAddedLabel setHidden:YES];
        [_canvasView.helper loadFromFile:  _path];
        [_canvasView.helper startUndoRecord:_path];
        [_canvasView.helper setViewScale:1];
    }
    else{
        [_noSchemeAddedLabel setHidden:NO];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)fileAlreadyExist:(NSString*) filePath{
    BOOL fileExist=[[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.vg",filePath]];
    return fileExist;
}

@end
