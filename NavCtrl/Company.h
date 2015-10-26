//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Product.h"

@interface Company : NSObject
// Company has these properties: name, logo, stock ticker, procuct array
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *ticker;
@property (nonatomic, retain) NSString *tickerPrice;
@property (nonatomic, retain) NSMutableArray *products;


@end
