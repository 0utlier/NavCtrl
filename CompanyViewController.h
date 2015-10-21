//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductViewController;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *productLogo;

// make arrays of products for each company
@property (nonatomic, retain) NSMutableArray *applePr;
@property (nonatomic, retain) NSMutableArray *samsungPr;
@property (nonatomic, retain) NSMutableArray *motoPr;
@property (nonatomic, retain) NSMutableArray *microsoftPr;


@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;

@end
