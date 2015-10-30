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
#import "sqlite3.h"




@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;

//- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename;
- (void)initiation;
+ (instancetype)sharedDAO;

-(void)createOrOpenDB;
-(void)updateDB;

-(void)addCompany:(NSString *)name logo:(NSString *)logo companyID:(NSString *)companyListLength;
-(void)editCompany:(NSString *)name logo:(NSString *)logo ticker:(NSString *)ticker original:(NSString *)original;
-(void)deleteCompany:(Company *)company;
//-(void)editCompanyRows: (Company *)companyFrom locationFrom:(NSString *)locationFrom companyTo:(Company *)companyTo locationTo:(NSString *)locationTo;
-(void)editCompanyRows:(NSMutableArray *)companyIDArray;

-(void)addProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo company_id:(NSString *)company_id product_id:(NSString *)product_id;
-(void)editProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo original:(NSString *)original;
-(void)deleteProduct: (Product *)product;
-(void)editProductRows:(NSMutableArray *)productIDArray;

@end
