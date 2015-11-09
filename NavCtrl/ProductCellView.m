//
//  ProductCellView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 11/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "ProductCellView.h"

@implementation ProductCellView

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_productLogo release];
    [_productName release];
    [super dealloc];
}
@end
