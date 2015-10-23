//
//  addCompanyVC.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"

@interface addCompanyVC : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *newCompanyText;


- (IBAction)doneButton:(id)sender;

@end
