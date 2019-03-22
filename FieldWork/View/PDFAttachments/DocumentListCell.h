//
//  DocumentListCell.h
//  FieldWork
//
//  Created by Samir Khatri on 3/20/14.
//
//

#import <UIKit/UIKit.h>

@interface DocumentListCell : UITableViewCell
{
    IBOutlet UILabel *_lblDocumentName;
}

@property (nonatomic, retain, readwrite) UILabel *lblDocumentName;

@end
