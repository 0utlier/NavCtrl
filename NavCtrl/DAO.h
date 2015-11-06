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
#import "CompanyManaged.h"
#import "ProductManaged.h"



@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *companyListManaged;

// cr: try to remove codes, variables not in use
//@property (nonatomic, strong) NSString *documentsDirectory;
//@property (nonatomic, strong) NSString *databaseFilename;

@property (nonatomic, strong) NSArray *fetchedObjects;

//Core Data properties
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)initiation;
+ (instancetype)sharedDAO;

-(void)updateDB;
-(void)reloadDataFromContext;
-(void)createDBFromObjects;


-(void)addCompany:(NSString *)name logo:(NSString *)logo companyID:(NSString *)companyListLength;
-(void)editCompany:(NSString *)name logo:(NSString *)logo ticker:(NSString *)ticker original:(NSString *)original;
-(void)deleteCompany:(Company *)company;
-(void)editCompanyRows:(Company *)companyFrom locationFrom:(double)locationFrom locationTo:(double)locationTo locationNextTo:(double)locationNextTo;

-(void)addProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo company_id:(NSString *)company_id product_id:(NSString *)product_id;
-(void)editProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo original:(NSString *)original company:(Company *)company;
-(void)deleteProduct: (Product *)product company:(Company *)company;
-(void)editProductRows:(NSMutableArray *)productIDArray company:(Company *)company;

@end
