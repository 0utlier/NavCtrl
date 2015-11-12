//
//  utilities.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/26/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "utilities.h"

@implementation utilities


//- (void)importStockPrice:(UITableView*)tableView{
- (void)importStockPrice:(UICollectionView*)collectionView{
	
	
	self.dao =[DAO sharedDAO];
//	NSURLSession *session = [NSURLSession sharedSession];
	NSString *urlString = @"http://download.finance.yahoo.com/d/quotes.csv?s=";//AAPL&f=l1";
	// append ticker string (e.g. AAPL) via loop
	
	// http://download.finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF&f=l1
	
	for (Company *company in self.dao.companyList) {
		if (company.ticker == nil) {
			continue;
		}
		else {
			urlString = [urlString stringByAppendingString:company.ticker];
			urlString = [urlString stringByAppendingString:@"+"];
		}
	}
	
	if ([urlString length] > 0) {
		urlString = [urlString substringToIndex:[urlString length] - 1];
	}
	// append this to ticker string &f=sl1
	urlString = [urlString stringByAppendingString:@"&f=l1"];
//	NSLog(@"%@", urlString);
	//	NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
	NSURL *myUrl = [NSURL URLWithString:urlString];
	
	
	
	//	AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
	//	manager1.responseSerializer = [AFHTTPResponseSerializer new];
	//	manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
	//	[manager1 GET:urlString
	//	  parameters:nil
	//		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
	//			 NSLog(@"JSON: %@", responseObject);
	//		 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	//			 NSLog(@"Error: %@", error);
	//		 }];
	
	//if(manager1)return;
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:myUrl];
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	
	
	operation.responseSerializer = [AFHTTPResponseSerializer serializer];
	operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
 
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		
//		NSLog(@"CSV: %@", [[NSString alloc]initWithBytes:[responseObject bytes] length:[responseObject length] encoding:NSUTF8StringEncoding]);
		// data to string
		NSString* stockValues =[[NSString alloc]initWithBytes:[responseObject bytes] length:[responseObject length] encoding:NSUTF8StringEncoding];
//		NSLog(@"%@", stockValues);
		NSMutableArray *stockPrices = [[NSMutableArray alloc]initWithArray:[stockValues componentsSeparatedByString:@"\n"]];
//		NSLog(@"%@", stockPrices);
		
		for (int i = 0; i < stockPrices.count - 1; i++) {
			Company *company = [self.dao.companyList objectAtIndex:i];
			company.tickerPrice = stockPrices[i];
		}
		[collectionView reloadData];
		[stockPrices release];
		[stockValues release];
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		// 4
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Stock Prices"
															message:[error localizedDescription]
														   delegate:nil
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];
		[alertView show];
	}];
 
	// 5
	[operation start];
}
// start to end of NSURLSession
/*
 // cr: check for error
 // data to string
 NSString* stockValues =[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
 //				NSLog(@"%@", stockValues);
 NSMutableArray *stockPrices = [[NSMutableArray alloc]initWithArray:[stockValues componentsSeparatedByString:@"\n"]];
 //				NSLog(@"%@", stockPrices);
 
 for (int i = 0; i < stockPrices.count - 1; i++) {
 Company *company = [self.dao.companyList objectAtIndex:i];
 company.tickerPrice = stockPrices[i];
 }
 
 
 // execute block of codes on main thread
 dispatch_async(dispatch_get_main_queue(), ^{
 [tableView reloadData];
 });
	}];
	[dataTask resume];
 }
 */

-(void)dealloc
{
	[_dao release];
	[super dealloc];
}
@end
