//
//  PictureViewController.m
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//

#import "PictureViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
@synthesize pictureArray=_pictureArray;
@synthesize collectionView=_collectionView;
@synthesize cellItem=_cellItem;


+(PictureViewController *)initViewControllerAppointment:(Appointment *)app{
    PictureViewController * controller =[[PictureViewController alloc]initWithNibName:@"PictureViewController" bundle:nil];
    controller.Appointment = app;
    controller.title =@"Pictures";
    return controller;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadPicture) name:@"PhotoAttachmentLoaded" object:nil];
    
    [self reloadPicture];
    UIBarButtonItem * addBarButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPicture)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellidentifier"];
}

-(void)addNewPicture{

    if (self.Appointment.photo_attachments.count >= 10) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"You can not add more than 10 photos." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    AddPictureViewController * controller =[AddPictureViewController initViewController:self.Appointment];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)reloadPicture{
    self.pictureArray = [[NSMutableArray alloc]init];
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        PhotoAttachment *photo = (PhotoAttachment*) evaluatedObject;
        if (![photo.entity_status isEqualToNumber:c_DELETED]) {
            return YES;
        }
        return NO;
    }];
    self.pictureArray = [[[self.Appointment.photo_attachments filteredSetUsingPredicate:pred] allObjects] mutableCopy];
    [_collectionView reloadData];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return [self.pictureArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cellidentifier";
    PictureCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    PhotoAttachment * pa=  [self.pictureArray objectAtIndex:indexPath.row];
    if([pa getImg] == nil){
        [pa downloadWithCompletionHandler:^(id result) {
            UIImage *img = (UIImage*)result;
            cell.imgView.image  = img;
        }];
    }else{
        cell.imgView.image  = [pa getImg];
    }
    cell.pAttechment = pa;
    cell.delegate =self;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
    PhotoAttachment * pa=  [self.pictureArray objectAtIndex:indexPath.row];
    AddPictureViewController * controller =[AddPictureViewController initViewController:pa Appointment:self.Appointment];
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -PictureDelegate
-(void)pictureDeleteCell:(PictureCollectionViewCell *)cell{
    _cellItem = cell;
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Are you sure want to delete Picture ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}


#pragma mark - 
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([_cellItem.pAttechment.entity_status isEqualToNumber:c_ADDED]) {
            [self.Appointment.photo_attachmentsSet removeObject:_cellItem.pAttechment];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [_cellItem.pAttechment MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [[NSManagedObjectContext MR_defaultContext] refreshObject:self.Appointment mergeChanges:YES];
        }else{
            [_cellItem.pAttechment setEntity_status:c_DELETED];
            [_cellItem.pAttechment savePhoto];
        }

        [self reloadPicture];
        [self postNotificationForDirty];
    }
}


#pragma mark -PictureFileUploadDelegate
-(void)pictureDeletedSucessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [self reloadPicture];
    
}
-(void)pictureDeletedUnSucessfullyWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
