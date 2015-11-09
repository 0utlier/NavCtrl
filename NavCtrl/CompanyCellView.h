//
//  CompanyCellView.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/25/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCellView : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *CompanyLogo;
@property (retain, nonatomic) IBOutlet UILabel *companyName;
@property (retain, nonatomic) IBOutlet UILabel *companyStock;
@property (retain, nonatomic) IBOutlet UILabel *compantyStockPrice;

@end
