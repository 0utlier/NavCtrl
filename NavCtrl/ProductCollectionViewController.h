//
//  ProductCollectionViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "Company.h"
#import "ProductCellView.h"
#import "Product.h"
#import "DAO.h"
//@class CompanyCollectionViewController;


@interface ProductCollectionViewController : UICollectionViewController <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSIndexPath *indexToChange;
@property (nonatomic, retain) UITextField *textField1;
@property (nonatomic, retain) UITextField *textField2;
@property (nonatomic, retain) UITextField *textField3;

//make a property for viewController
@property (nonatomic, retain) WebViewController *webViewController;




@end
