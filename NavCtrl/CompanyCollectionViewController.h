//
//  CompanyCollectionViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/7/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#include "addCompanyVC.h"
#import "CompanyCellView.h"
#import "utilities.h"
#import "ProductCollectionViewController.h"



@interface CompanyCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) DAO *dao;
@property (nonatomic, strong) utilities *utilities;

@property (nonatomic, strong) ProductCollectionViewController * productCollectionViewController;


@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSIndexPath *indexToChange;
@property (nonatomic, retain) UITextField *textField1;
@property (nonatomic, retain) UITextField *textField2;
@property (nonatomic, retain) UITextField *textField3;

@end
