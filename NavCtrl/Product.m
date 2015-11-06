//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)dealloc{
	[_name release];
	[_logo release];
	[_url release];
	[_company_ID release];
	[_product_ID release];
	_name = nil;
	_logo = nil;
//	_ticker = nil;
//	_tickerPrice = nil;
	
	[super dealloc];
}


@end
