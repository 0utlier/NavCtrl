//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"



@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;

- (void)initiation;
+ (instancetype)sharedDAO;
-(void)userDefaults;
-(void)readUserDefaults;

-(void)addCompany:(id)newCompany;
-(void)editCompanyAtRow:(NSUInteger)fromRow toRow:(NSUInteger)toRow rep:(id)rep;
-(void)deleteCompanyAtRow:(NSUInteger)row;




@end
