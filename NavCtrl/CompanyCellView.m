//
//  CompanyCellView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/25/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "CompanyCellView.h"

@implementation CompanyCellView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_CompanyLogo release];
    [_companyName release];
    [_companyStock release];
    [_compantyStockPrice release];
    [super dealloc];
}
@end
