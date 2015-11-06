//
//  addCompanyVC.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "addCompanyVC.h"

@interface addCompanyVC ()

@end

@implementation addCompanyVC

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (IBAction)doneButton:(id)sender {
	NSString *tempTextField =  self.newCompanyText.text;
	NSLog(@"%lu", (unsigned long)[[[DAO sharedDAO] companyList]count]);
	NSString *newIDNumber = [NSString stringWithFormat:@"%lu",(unsigned long)[[[DAO sharedDAO] companyList]count]+1];
	NSLog(@"%@", newIDNumber);
	
	[[DAO sharedDAO] addCompany:tempTextField logo:@"myLogo.jpg" companyID:newIDNumber];
	[self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {
	[_newCompanyText release];
	[super dealloc];
}
@end
