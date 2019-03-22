//
//  PDFSelectCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 01.09.16.
//
//

#import "PDFSelectCell.h"

@interface PDFSelectCell ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lablel;
@property (strong,nonatomic) NSArray* options;
@property (strong,nonatomic) NSString* defaultOption;
@property (strong,nonatomic) NSString* value;
//@property (strong,nonatomic) NSMutableArray* selectedOptions;
@end

@implementation PDFSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UINib *nib = [UINib nibWithNibName:@"PDFSelectItemCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"SelectItem"];
    // Initialization code
}
-(void)setField:(PDFField *)field{
    _field=field;
    _value=field.field_value;
    [_lablel setText:[NSString stringWithFormat:@"%@:",field.label]];
    _defaultOption=field.default_value;
    _options=field.options;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_options) {
        return _options.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    NSString* option= [_options objectAtIndex:row];
    PDFSelectItemCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SelectItem" forIndexPath:indexPath];
    [cell setDefaultOption:_defaultOption];
    if(_value){
        [cell setValue:_value];
    }
    else{
        [cell setValue:@""];
    }
    [cell setOption:option];
    [cell initialize];
//    cell.checkBlock=^(NSString *option, BOOL checked) {
//        if (![_value isEqualToString:option]) {
//            _value=option;
//            if (self.block) {
//                self.block(_value);
//            }
//        }
//    };
//    [cell initialize ];{
//        if (![_value isEqualToString:option]) {
//            _value=option;
//            if (self.block) {
//                self.block(_value);
//            }
//        }
//   }];
  cell.checkBlock=^(NSString *option, BOOL checked) {
        _value=option;
      [self.tableView reloadData];
      if (self.block) {
          self.block(_value);
      }
  };

    return cell;
}


@end
