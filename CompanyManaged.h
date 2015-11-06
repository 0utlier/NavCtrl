//
//  CompanyManaged.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/3/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CompanyManaged : NSManagedObject

@property (nonatomic, retain) NSString * companyID;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * ticker;
@property (nonatomic, retain) NSString * tickerPrice;
@property (nonatomic) double location;
@property (nonatomic, retain) NSSet *products;
@end

@interface CompanyManaged (CoreDataGeneratedAccessors)

- (void)addProductsObject:(NSManagedObject *)value;
- (void)removeProductsObject:(NSManagedObject *)value;
- (void)addProducts:(NSSet *)values;
- (void)removeProducts:(NSSet *)values;

@end
