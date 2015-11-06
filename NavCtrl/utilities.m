//
//  utilities.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/26/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "utilities.h"

@implementation utilities


- (void)importStockPrice:(UITableView*)tableView{
	
	self.dao =[DAO sharedDAO];
	NSURLSession *session = [NSURLSession sharedSession];
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
	
	NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		// data to string
		NSString* stockValues =[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
		//		NSLog(@"%@", stockValues);
		NSMutableArray *stockPrices = [[NSMutableArray alloc]initWithArray:[stockValues componentsSeparatedByString:@"\n"]];
		//		NSLog(@"%@", stockPrices);
		
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

-(void)dealloc
{
	[_dao release];
	[super dealloc];
}
@end
