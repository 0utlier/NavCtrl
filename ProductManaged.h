//
//  ProductManaged.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/3/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface ProductManaged : NSManagedObject

@property (nonatomic, retain) NSString * company_ID;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * product_ID;
@property (nonatomic, retain) id url;
@property (nonatomic, retain) Company *company;

@end
