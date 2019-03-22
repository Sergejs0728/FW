//
//  MultiUnitListViewController.m
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import "UnitListViewController.h"
#import "UnitInspectionViewController.h"
#import "AddUnitViewController.h"

@interface UnitListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, AddUnitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) ServiceLocation *serviceLocation;

@end

@implementation UnitListViewController
+(UnitListViewController *)initWithAppointment:(Appointment *)app{
    UnitListViewController * vc;
    //    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //        environment =[[AddUnitViewController alloc]initWithNibName:@"EnvironmentView_iPad" bundle:nil];
    //
    //    }else{
    vc =[[UnitListViewController alloc]initWithNibName:@"UnitListViewController" bundle:nil];
    
    //    }
    vc.appointment= app;
    vc.serviceLocation = [app getServiceLocation];
    vc.title =@"Units";
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 65;
    [self registerNibs:@[@"UnitListCell"]];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUnit)];
    self.navigationItem.rightBarButtonItem = addBtn;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _unitsList=[[_serviceLocation.flats allObjects] mutableCopy];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
-(void)registerNibs:(NSArray*)keys{
    for (NSString* key in keys) {
        UINib *cellNib = [UINib nibWithNibName:key bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:key];
    }
}

- (void)addUnit {
    if ([[AppDelegate appDelegate] isReachable]) {
        AddUnitViewController* controller= [AddUnitViewController init];
        controller.serviceLocation = [self.appointment getServiceLocation];
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [[ActivityIndicator currentIndicator] displayCompletedWithError:NSLocalizedString(@"No internet connection", @"")];
    }
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Unit* unit;
    if (_searchbar.text.length) {
        unit=_searchResults[indexPath.row];
    } else if (_unitsList) {
        unit=_unitsList[indexPath.row];
    }
    UnitInspectionViewController* inspectionViewController=[UnitInspectionViewController initWithUnit:unit andAppointment:self.appointment];
    [self.navigationController pushViewController:inspectionViewController animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchbar.text.length) {
        return _searchResults.count;
    } else if (_unitsList) {
        return _unitsList.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Unit* unit;
    if (_searchbar.text.length) {
        unit=_searchResults[indexPath.row];
    } else if (_unitsList) {
        unit=_unitsList[indexPath.row];
    }
    UnitListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"UnitListCell" forIndexPath:indexPath];
    [cell setUnit:unit];
    NSLog(@"UNIT ID %@",unit.entity_id);
    return cell;
}

#pragma mark - Search
- (void)filterContentForSearchText:(NSString*)searchText {
    _searchResults = [_unitsList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Unit *unit = (Unit*)evaluatedObject;
        NSRange range = [unit.unit_number rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (unit.unit_number && range.location != NSNotFound) {
            return YES;
        } else {
            range = [unit.tenant_name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (unit.tenant_name && range.location != NSNotFound) {
                return YES;
            }
        }
        return NO;
    }]];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchbar.text = @"";
    [searchBar resignFirstResponder];
    [self search];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self search];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self search];
}

- (void)search {
    NSString *input = _searchbar.text;
    _searchResults = @[];
    if (input.length > 0) {
        [self filterContentForSearchText:input];
    }
    [_tableView reloadData];
}

#pragma mark - AddUnitViewControllerDelegate
- (void) addUnitViewControllerDidFinish:(Unit*)unit {
    if (unit) {
        [_serviceLocation addFlatsObject:unit];
//        [self refreshObjects];
        [_tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        //        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    } else {
        
    }
}


@end
