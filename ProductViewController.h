//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
//import webView to point to
#import "WebViewController.h"
#import "CompanyCollectionViewController.h"

@interface ProductViewController : UICollectionViewController <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
//@property (nonatomic, retain) NSMutableArray *products;
//@property (nonatomic, retain) NSString *productLogo;
//@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSIndexPath *indexToChange;
@property (nonatomic, retain) UITextField *textField1;
@property (nonatomic, retain) UITextField *textField2;
@property (nonatomic, retain) UITextField *textField3;

//make a property for viewController
@property (nonatomic, retain) WebViewController *webViewController;


@end
