//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (void)encodeWithCoder:(NSCoder *)encoder
{
	//Encode properties, other class variables, etc
//	NSLog(@"Encoder Called");
	[encoder encodeObject:[self name] forKey:@"name"];
	[encoder encodeObject:[self logo] forKey:@"logo"];
	[encoder encodeObject:[self url] forKey:@"url"];

	//	[encoder encodeObject:[self products] forKey:@"products"];
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
		[self setUrl:[decoder decodeObjectForKey:@"url"]];

		//		[self setProducts:[decoder decodeObjectForKey:@"products"]];
	}
	return self;
}


@end
