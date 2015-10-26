//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
// import classes
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#include "addCompanyVC.h"
#import "CompanyCellView.h"
#import "utilities.h"

@class ProductViewController;

@interface CompanyViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

//@property (nonatomic, retain) NSMutableArray *companyList;
//@property (nonatomic, retain) NSMutableArray *products;
//@property (nonatomic, retain) NSMutableArray *productLogo;
//
//// make arrays of products for each company
//@property (nonatomic, retain) NSMutableArray *applePr;
//@property (nonatomic, retain) NSMutableArray *samsungPr;
//@property (nonatomic, retain) NSMutableArray *motoPr;
//@property (nonatomic, retain) NSMutableArray *microsoftPr;
@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) utilities *utilities;

@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;

@property (nonatomic, retain) NSIndexPath *indexToChange;
@property (nonatomic, retain) UITextField *textField1;
@property (nonatomic, retain) UITextField *textField2;
@property (nonatomic, retain) UITextField *textField3;

@end
