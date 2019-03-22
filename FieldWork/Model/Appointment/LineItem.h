#import "_LineItem.h"

@interface LineItem : _LineItem {}

+ (FEMMapping* )defaultMapping;

+ (LineItem*) newLineItem;

- (void) discard;

- (void) saveLineItem;


@end
