//
//  NoteController.m
//  FieldWork
//
//  Created by Samir Khatri on 29/04/2013.
//
//

#import "NoteController.h"
#import "KeyboardAccessoryHelper.h"

@interface NoteController ()

@end

@implementation NoteController
@synthesize characterlbl=_characterlbl;
@synthesize noteRoundView;
@synthesize saveBtn=_saveBtn;
@synthesize noteScrollView=_noteScrollView;
@synthesize txtPrivateNote = _txtPrivateNote;



+ (NoteController *)initWithAppointment:(Appointment *)app
{
    NoteController * notes;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        notes =[[NoteController alloc]initWithNibName:@"NoteViewController_IPad" bundle:nil];
        
    }else{
        notes =[[NoteController alloc]initWithNibName:@"NoteViewController" bundle:nil];
        
    }
    notes.Appointment= app;
    notes.title =@"Notes";
    return notes;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // because of Note View Keyboard height Change in ios 7 & ios6
    // i have set frame manually wether ios7 & ios 6
    
    //[_noteTextView becomeFirstResponder];
    if ([[UIScreen mainScreen]bounds].size.height==568)
    {
        
    }
    else
    {
        _noteScrollView.frame=CGRectMake(self.noteScrollView.frame.origin.x, self.noteScrollView.frame.origin.y, self.noteScrollView.frame.size.width, self.noteScrollView.frame.size.height);
    }
    [self manageTableHeight];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarButton];
    //_btnHeaderSave = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(NoteSave:)];
    
    
    _selectedRecommendations = [[NSMutableArray alloc] init];

    if (self.Appointment.recommendation_ids != nil && [(NSArray*)self.Appointment.recommendation_ids count] > 0) {
        for (NSNumber *num in self.Appointment.recommendation_ids) {
            Recommendations *rec = [Recommendations recommendationById:num];
            if (rec) {
                [_selectedRecommendations addObject:rec];
            }
        }
    }

    _selectedConditions = [[NSMutableArray alloc] init];
    if (self.Appointment.appointment_condition_ids != nil && [(NSArray*)self.Appointment.appointment_condition_ids count] > 0) {
        for (NSNumber *num in self.Appointment.appointment_condition_ids) {
            Conditions *rec = [Conditions conditionById:num];
            if (rec) {
                [_selectedConditions addObject:rec];
            }
        }
    }
    
    //noteview.backgroundColor =[UIColor colorWithRed:53.0/255 green:152.0/255.0 blue:219.0/255.0 alpha:1.0];
    noteRoundView.layer.cornerRadius = 1;
    _noteTextView.layer.cornerRadius = _txtPrivateNote.layer.cornerRadius = 1;
    
    
    if (self.Appointment.notes && self.Appointment.notes.length > 1) {
        _noteTextView.text = self.Appointment.notes;
    }else{
        _noteTextView.text =@"";
    }

    if (self.Appointment.private_notes && self.Appointment.private_notes.length > 1) {
        _txtPrivateNote.text = self.Appointment.private_notes;
    }else{
        _txtPrivateNote.text =@"";
    }
    
    _characterlbl.text=[NSString stringWithFormat:@"%lu",2000-_noteTextView.text.length];
    _lblPrivateCount.text = [NSString stringWithFormat:@"%lu",2000-_txtPrivateNote.text.length];
    _shouldAskForUnsavedData = NO;
    [[KeyboardAccessoryHelper getInstance] createInputAccessoryForTextView:_noteTextView inView:self.view andDelegate:self];
    [[KeyboardAccessoryHelper getInstance] createInputAccessoryForTextView:_txtPrivateNote inView:self.view andDelegate:self];
	// Do any additional setup after loading the view.
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(NoteSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (void)manageTableHeight {
//    int initialY = _tblView.frame.origin.y;
    int rowHeight = 44;
    
    int sectionTitleHeight = 35;
    int totalHeight = (int)((_selectedRecommendations.count + 1) * rowHeight) + sectionTitleHeight;
    totalHeight += ((_selectedConditions.count + 1) * rowHeight) + sectionTitleHeight;
    
    
    _tblView.frame = CGRectMake(_tblView.frame.origin.x, _tblView.frame.origin.y, _tblView.frame.size.width, totalHeight);
    _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _tblView.frame.origin.y + _tblView.frame.size.height + 20, _saveBtn.frame.size.width, _saveBtn.frame.size.height);
    int viewHeight = _tblView.frame.origin.y + _tblView.frame.size.height + 30;
    viewHeight = [[UIScreen mainScreen] bounds].size.height < viewHeight ? viewHeight : [[UIScreen mainScreen] bounds].size.height;
    
    _noteScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, viewHeight);
//    if(_noteScrollView.frame.size.height < viewHeight){
//        _noteScrollView.frame = CGRectMake(_noteScrollView.frame.origin.x, _noteScrollView.frame.origin.y, _noteScrollView.frame.size.width, viewHeight + 30);
//    }
}

-(BOOL) navigationShouldPopOnBackButton
{
    if (_shouldAskForUnsavedData == YES) {
        [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have unsaved data, would you like to save before proceeding?"
                                   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
        return NO;
    }
    return YES;
}

- (IBAction)NoteSave:(id)sender
{
    
    self.Appointment.recommendation_ids = [[NSArray arrayWithArray:_selectedRecommendations] valueForKey:@"entity_id"];
    self.Appointment.appointment_condition_ids = [[NSArray arrayWithArray:_selectedConditions] valueForKey:@"entity_id"];

    
    NSString *note_trim=[_noteTextView.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *p_notes=[_txtPrivateNote.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (note_trim.length > 0)
    {
        [self.Appointment setNotes:note_trim];
        [self.Appointment setPrivate_notes:p_notes];
    }
    [self.Appointment saveAppointmentOnLocal];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
   
    int limit = 2000;
    UITextView *txt = _noteTextView;
    UILabel *lbl = _characterlbl;
    if (textView.tag == 1001) {
        txt = _txtPrivateNote;
        lbl = _lblPrivateCount;
    }
    
    if (txt.text.length > limit) {
        txt.text = [txt.text substringToIndex:limit];
    }
    int len = (int)txt.text.length;
     lbl.text=[NSString stringWithFormat:@"%i",2000-len];
    
    _shouldAskForUnsavedData = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL flag = NO;
    _shouldAskForUnsavedData = YES;
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    //self.navigationItem.rightBarButtonItem = _btnHeaderSave;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    //self.navigationItem.rightBarButtonItem = nil;
}

- (IBAction)keyboard:(id)sender
{
    [_noteTextView resignFirstResponder];
    [_txtPrivateNote resignFirstResponder];
}


#pragma mark - UIAlertViewDelegate


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==1) {
		
        [self NoteSave:nil];
	}else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Recommendations";
    }
    if (section == 1) {
        return @"Conditions";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _selectedRecommendations.count + 1;
    }else if (section == 1){
        return _selectedConditions.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"CellRecommendations";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == _selectedRecommendations.count) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            }
#endif
            cell.textLabel.text = @"Add Recommendations";
        }else{
            Recommendations *rec = [_selectedRecommendations objectAtIndex:indexPath.row];
            if (rec) {
                cell.textLabel.text = rec.name;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"CellConditions";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row == _selectedConditions.count) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            }
#endif
            cell.textLabel.text = @"Add Conditions";
        }else{
            Conditions *rec = [_selectedConditions objectAtIndex:indexPath.row];
            if (rec) {
                cell.textLabel.text = rec.name;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == _selectedRecommendations.count) {
            [self.view endEditing:YES];
            DataTableViewController *controller = [DataTableViewController tableWithDataType:RecommendationsList andDelegate:self withMultipleChoices:YES];
            controller.existing_items = _selectedRecommendations;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == _selectedConditions.count) {
            [self.view endEditing:YES];
            DataTableViewController *controller = [DataTableViewController tableWithDataType:ConditionsList andDelegate:self withMultipleChoices:YES];
            controller.existing_items = _selectedConditions;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    if (type == RecommendationsList) {
        _shouldAskForUnsavedData = YES;
        _selectedRecommendations = (NSMutableArray*) data;
        [_tblView reloadData];
        [self manageTableHeight];
    }
    if (type == ConditionsList) {
        _shouldAskForUnsavedData = YES;
        _selectedConditions = (NSMutableArray*) data;
        [_tblView reloadData];
        [self manageTableHeight];
    }
}

#pragma mark - KeyboardAccessoryHelper Delegate

- (void)hideKeyboard {
    [self.view endEditing:TRUE];
}

@end
