//
//  SchemeNoteViewController.m
//  FieldWork
//
//  Created by Alexander on 28.10.16.
//
//

#import "SchemeNoteViewController.h"
#import "GridDrawer.h"

@interface SchemeNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation SchemeNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:_stageName];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    [self.noteTextView setText:_stageNote];
    self.navigationItem.rightBarButtonItem=saveBarButton;
//    [GridDrawer generateGrindonView:self.backgroundView colour:[UIColor colorWithRed:194/256 green:194/256 blue:194/256 alpha:0.075f] lineWidth:1.0f];
    [self.view bringSubviewToFront:self.noteTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)save:(UIBarButtonItem*)saveBarButton{
    _stageNote=self.noteTextView.text;
    if(_noteBlock){
        _noteBlock(_stageNote);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
