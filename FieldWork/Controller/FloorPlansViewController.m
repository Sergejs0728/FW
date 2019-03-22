//
//  FloorPlansViewController.m
//  FieldWork
//
//  Created by Alexander on 09.09.16.
//
//

#import "FloorPlanCell.h"
#import "FloorPlansViewController.h"
#import "SchemeDrawerControllerViewController.h"

@interface FloorPlansViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *stages;
@property (nonatomic) CGFloat cellWidth;
@end

@implementation FloorPlansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellWidth=0;
    UINib *nib = [UINib nibWithNibName:@"FloorPlanCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"FloorPlanCell"];
    if (_building) {
        if (self.navigationItem) {
            [self.navigationItem setTitle:_building];
        }
    }
    if (self.navigationItem) {
        UIImage* image1 = [UIImage imageNamed:@"ic_new_appointments.png"];
        CGRect frameimg1 = CGRectMake(15,5, 25,25);
        UIImage* image2 = [UIImage imageNamed:@"delete.png"];
        CGRect frameimg2 = CGRectMake(15,5, 25,25);
        UIButton *rightSaveButton = [[UIButton alloc] initWithFrame:frameimg1];
        [rightSaveButton setBackgroundImage:image1 forState:UIControlStateNormal];
        [rightSaveButton addTarget:self action:@selector(addPlan:)
              forControlEvents:UIControlEventTouchUpInside];
        [rightSaveButton setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *saveButton =[[UIBarButtonItem alloc] initWithCustomView:rightSaveButton];

        UIButton *rightDeleteButton = [[UIButton alloc] initWithFrame:frameimg2];
        [rightDeleteButton setBackgroundImage:image2 forState:UIControlStateNormal];
        [rightDeleteButton addTarget:self action:@selector(deleteBuilding)
                  forControlEvents:UIControlEventTouchUpInside];
        [rightDeleteButton setShowsTouchWhenHighlighted:YES];
        UIBarButtonItem *deleteButton =[[UIBarButtonItem alloc] initWithCustomView:rightDeleteButton];
        
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:saveButton,deleteButton,nil]];
        if (_building) {
            [self.navigationItem setTitle:_building];
        }
        else{
            [self.navigationItem setTitle:@"Scheme"];
        }
    }
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
}


-(void)viewDidAppear:(BOOL)animated{
    [self loadStages];
    _cellWidth=self.view.frame.size.width/2-20;
    [self.collectionView reloadData];
}

-(void)loadStages{
    NSPredicate *buildingFilter = [NSPredicate predicateWithFormat:@"building like %@", _building];
    NSPredicate *notDeletedFilter = [NSPredicate predicateWithBlock:^BOOL(id   evaluatedObject, NSDictionary<NSString *,id> *  bindings) {
        StageModel* object=evaluatedObject;
        return ![object.deleted boolValue];
    }];
    NSArray* tempStages=[StageModel MR_findAllWithPredicate:buildingFilter];
    _stages=[tempStages filteredArrayUsingPredicate:notDeletedFilter];
    for (StageModel* stage in _stages) {
        if (!stage.filePath) {
            [stage downloadWithCompletionBlock:^(FWRequest *request) {
                [self.collectionView reloadData];
            }];
            
        }
    }
}

-(FloorPlanCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    static NSString *identifier = @"FloorPlanCell";
    FloorPlanCell* cell= (FloorPlanCell*) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil){
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"FloorPlanCell" owner:self options:nil];
        for(id floorcell in topLevelObject){
            if([floorcell isKindOfClass:[UITableViewCell class]]){
                cell = (FloorPlanCell*) floorcell;
            }
        }
    }
    StageModel* stageModel=[_stages objectAtIndex:row];
    [cell setStageModel:stageModel];
    __weak FloorPlansViewController* weakSelf=self;
    cell.callback=^(){
        UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:@"Do you want to delete diagram?"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okDeleteAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             NSFileManager *fileManager = [NSFileManager defaultManager];
                                                             NSError *error;
                                                             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                             NSString *documentsDirectory = [paths objectAtIndex:0];
                                                             NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, stageModel.filePath];
                                                             [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@",filePath] error:&error];
                                                             [self deleteStage:stageModel completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                                                                 [self loadStages];
                                                                 [self.collectionView reloadData];
                                                             }];
                                                        }];
        [alertDelete addAction:okDeleteAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
        [alertDelete addAction:cancelAction];
        [weakSelf presentViewController:alertDelete animated:YES completion:nil];
    };
    return cell;
}

-(void)deleteStage:(StageModel*) stageModel completion:(MRSaveCompletionHandler) completion{
    [stageModel setDeleted:@(YES)];
    [stageModel.managedObjectContext MR_saveWithBlock:^(NSManagedObjectContext * localContext) {
        
    } completion:completion];
}


-(void)addPlan:(UIButton*)button{
    
    __block FloorPlansViewController* blockSelf=self;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add new floor?"
                                                                   message:@"Set floor title"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         SchemeDrawerControllerViewController *drawerController = [[SchemeDrawerControllerViewController alloc] initWithNibName:@"SchemeDrawerControllerViewController" bundle:nil];
//                                                         [drawerController setBuildingTitle:_building];
                                                         drawerController.stageTitle=[alert.textFields objectAtIndex:0].text;
                                                         drawerController.serviceLocationId=_serviceLocationId;
                                                         drawerController.block=^(){
                                                             [self.collectionView reloadData];
                                                         };
                                                         [blockSelf.navigationController pushViewController:drawerController animated:YES];
                                                    }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_stages) {
        return _stages.count;
    }
    else{
        return 0;
    }
}

-(void)deleteBuilding{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete this building?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         for (StageModel* stage in _stages) {
                                                             [self deleteStage:stage completion:nil];
                                                         }
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                     }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_cellWidth, _cellWidth*1.2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    StageModel* stage= [_stages objectAtIndex: row];
    SchemeDrawerControllerViewController *drawerController = [[SchemeDrawerControllerViewController alloc] initWithNibName:@"SchemeDrawerControllerViewController" bundle:nil];
//    [drawerController setBuildingModel:_buildingModel];
    [drawerController setStageModel:stage];
    drawerController.serviceLocationId=_serviceLocationId;
    drawerController.block=^(){
        NSPredicate *buildingFilter = [NSPredicate predicateWithFormat:@"building like %@", _building];
        _stages=[StageModel MR_findAllWithPredicate:buildingFilter];
        [self.collectionView reloadData];
    };
    [self.navigationController pushViewController:drawerController animated:YES];
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
