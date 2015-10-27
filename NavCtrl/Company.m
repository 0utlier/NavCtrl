//
//  Company.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (void)encodeWithCoder:(NSCoder *)encoder
{
	//Encode properties, other class variables, etc
//	NSLog(@"Encoder Called");
	[encoder encodeObject:[self name] forKey:@"name"];
	[encoder encodeObject:[self logo] forKey:@"logo"];
	[encoder encodeObject:[self ticker] forKey:@"ticker"];
	[encoder encodeObject:[self tickerPrice] forKey:@"tickerPrice"];
	[encoder encodeObject:[self products] forKey:@"products"];
}



- (id)initWithCoder:(NSCoder *)decoder
{
//	NSLog(@"Decoder Called");
	self = [super init];
	if(self)
	{
		//decode properties, other class vars
		[self setName:[decoder decodeObjectForKey:@"name"]];
		[self setLogo:[decoder decodeObjectForKey:@"logo"]];
		[self setTicker:[decoder decodeObjectForKey:@"ticker"]];
		[self setTickerPrice:[decoder decodeObjectForKey:@"tickerPrice"]];
		[self setProducts:[decoder decodeObjectForKey:@"products"]];
		//if no array exists for the new company, allocate array
		if (self.products == nil) {
			NSMutableArray *tempArray = [[NSMutableArray alloc]init];
			self.products = tempArray;
		}
	}
	return self;
}


@end
