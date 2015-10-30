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

//- (void)insertNewObject{
//	
//}

- (IBAction)doneButton:(id)sender {
//	NSLog(@"made it here");
	NSString *tempTextField =  self.newCompanyText.text;
//	Company *tempCompany = [[Company alloc]init];
//	tempCompany.name = tempTextField;
//	tempCompany.logo = @"myLogo.jpg";
	//NSString *tempTextProductField =  self.newCompanyProductText.text;//[alertView textFieldAtIndex:0].text;
	//tempCompany.products = [[NSMutableArray alloc]initWithArray:@[@"%@", tempTextProductField]];
	NSLog(@"%lu", (unsigned long)[[[DAO sharedDAO] companyList]count]);
//	NSInteger *newIDNumber = (unsigned long)[[[DAO sharedDAO] companyList]count]+1;
//	NSString *newIDNumberString = [[NSString stringWithFormat:@"lu", [newIDNumber intValue]];
	NSString *newIDNumber = [NSString stringWithFormat:@"%lu",(unsigned long)[[[DAO sharedDAO] companyList]count]+1];
	NSLog(@"%@", newIDNumber);
//	NSLog(@"logo tempCompany = %@",tempCompany.logo);
	
	[[DAO sharedDAO] addCompany:tempTextField logo:@"myLogo.jpg" companyID:newIDNumber];
//		[[[DAO sharedDAO] companyList] addObject:tempCompany];
		//[self.tableView reloadData];
	
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

//- (IBAction)doneButton:(id)sender {
//	if (buttonIndex == 1) {
//		NSString *tempTextField = [doneButton textFieldAtIndex:0].text;
//		if (!self.dao.companyList) {
//			self.dao.companyList = [[NSMutableArray alloc]init];
//		}
//
//		Company *tempCompany = [[Company alloc]init];
//		tempCompany.name = tempTextField;
//		tempCompany.logo = @"myLogo.jpg";
//		//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
//		[self.dao.companyList addObject:tempCompany];
//		[self.tableView reloadData];
//	}
//
//}
- (void)dealloc {
	[_newCompanyText release];
	//[_newCompanyProductText release];
	[super dealloc];
}
@end
