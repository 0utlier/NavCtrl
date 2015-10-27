//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject <NSCoding>

// Company has these properties: name, logo, stock ticker, tickerPrice, procuct array
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *ticker;
@property (nonatomic, retain) NSString *tickerPrice;
@property (nonatomic, retain) NSMutableArray *products;

//- (id)initWithName:(NSString *)name logo:(NSString *)logo ticker:(NSString *)ticker tickerPrice:(NSString *)tickerPrice products:(NSMutableArray *)products;


@end
