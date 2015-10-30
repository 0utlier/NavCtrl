//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO
{
	//	NSMutableArray *arrayOfPesron;
	sqlite3 *personDB;
	NSString *dbPathString;
}

- (void)initiation{
	// create all the companies
	Company *apple = [[Company alloc]init];
	Company *samsung = [[Company alloc]init];
	Company *moto = [[Company alloc]init];
	Company *microsoft = [[Company alloc]init];
	
	// create all the products
	Product *ipad = [[Product alloc]init];
	Product *ipodTouch = [[Product alloc]init];
	Product *iphone = [[Product alloc]init];
	Product *gS4 = [[Product alloc]init];
	Product *gNote = [[Product alloc]init];
	Product *gTab = [[Product alloc]init];
	Product *slider = [[Product alloc]init];
	Product *motoG = [[Product alloc]init];
	Product *m360 = [[Product alloc]init];
	Product *windows = [[Product alloc]init];
	Product *wPhone = [[Product alloc]init];
	Product *wTablet = [[Product alloc]init];
	
	// give the company class values (name, logo, ticker)
	apple.name = @"Apple";
	apple.logo = @"AppleLogo.jpg";
	apple.ticker = @"AAPL";
	//	apple.tickerPrice = ;
	samsung.name = @"Samsung";
	samsung.logo = @"samsungLogo.jpg";
	samsung.ticker = @"SSNLF";
	moto.name = @"Moto";
	moto.logo = @"motoLogo.jpg";
	moto.ticker = @"MSI";
	microsoft.name = @"Microsoft";
	microsoft.logo = @"microsoftLogo.jpg";
	microsoft.ticker = @"MSFT";
	
	// give the products values
	ipad.name = @"iPad";
	ipodTouch.name = @"iPod Touch";
	iphone.name = @"iPhone";
	gS4.name = @"Galaxy S4";
	gNote.name = @"Galaxy Note";
	gTab.name = @"Galaxy Tab";
	slider.name = @"Slider";
	motoG.name = @"MotoG";
	m360.name = @"360";
	windows.name = @"Windows";
	wPhone.name = @"Phone";
	wTablet.name = @"Tablet";
	
	// initialize company array to call upon
	self.companyList = [[NSMutableArray alloc]initWithArray:@[apple,samsung,moto,microsoft]];
	
	// allocate space for products array
	
	//fill array for each company
	apple.products = [[NSMutableArray alloc]initWithArray:@[ipad,ipodTouch,iphone]];
	samsung.products = [[NSMutableArray alloc]initWithArray:@[gS4,gNote,gTab]];
	moto.products = [[NSMutableArray alloc]initWithArray:@[slider,motoG,m360]];
	microsoft.products = [[NSMutableArray alloc]initWithArray:@[windows,wPhone,wTablet]];
}
// make the DAO a singleton
+ (instancetype)sharedDAO
{
	static DAO *sharedDAO = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedDAO = [[DAO alloc] init];
		// Do any other initialisation stuff here
	});
	return sharedDAO;
}

//- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
//	// Set the documents directory path to the documentsDirectory property.
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	self.documentsDirectory = [paths objectAtIndex:0];
//
//	// Keep the database filename.
//	self.databaseFilename = dbFilename;
//
//	// Copy the database file into the documents directory if necessary.
//	[self copyDatabaseIntoDocumentsDirectory];
//}

// create or open existing dataBase
-(void)updateDB
{
	char *error = NULL;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:dbPathString])
	{
		const char *dbPath = [dbPathString UTF8String];
	}
	else{
		//copy SQLite file from bundle to documents directory
		// Get the path to the database in the application package
		NSString *databasePathFromApp = [[NSBundle mainBundle] pathForResource:@"CompanyDataBase" ofType:@"sqlite"];
		//NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"wine.sqlite"];
		
		// Copy the database from the package to the users filesystem
		[[NSFileManager defaultManager] copyItemAtPath:databasePathFromApp toPath:dbPathString error:nil];
		//check if successful
		if (error == nil) {
			NSLog(@"it worked");
		}
	}
}

- (void)createOrOpenDB
{
	sqlite3_stmt *statement ;
	if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK)
	{
		[self.companyList removeAllObjects];
		NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Company ORDER BY location"];
		const char *query_sql = [querySQL UTF8String];
		if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement)== SQLITE_ROW)
			{
				NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
				NSString *logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
				NSString *ticker = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
				NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
				
				Company *company = [[Company alloc]init];
				[company setName:name];
				[company setLogo:logo];
				[company setTicker:ticker];
				[company setCompanyID:companyID];
				company.products = [[NSMutableArray alloc]init];
				// add products
				sqlite3_stmt *statement2 ;
				NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Products WHERE company_id = '%@' ORDER BY location", companyID];
				const char *query_sql = [querySQL UTF8String];
				if (sqlite3_prepare(personDB, query_sql, -1, &statement2, NULL) == SQLITE_OK)
				{
					while (sqlite3_step(statement2)== SQLITE_ROW)
					{
						NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement2, 0)];
						NSString *url = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement2, 1)];
						//						NSString *logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement2, 2)];
						NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement2, 3)];
						NSString *productID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement2, 5)];
						
						
						Product *product = [[Product alloc]init];
						[product setName:name];
						[product setUrl:[NSURL URLWithString:url]];
						//						[product setLogo:logo];
						[product setCompany_ID:companyID];
						[product setProduct_ID:productID];
						
						[company.products addObject:product];
						
					}
				}
				[self.companyList addObject:company];
			}
		}
	}
}

#pragma Company Methods

-(void)addCompany:(NSString *)name logo:(NSString *)logo companyID:(NSString *)companyListLength //this is to add an ID number, which will be one more than the amount that's on there
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO Company (name,logo,ticker,companyID,location) VALUES ('%@','%@','','%@','%@')", name,logo,companyListLength,companyListLength];
		const char *insert_stmt = [insertStmt UTF8String];
		
		NSLog(@"%@", insertStmt);
		
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Company added to DB");
			Company *company = [[Company alloc] init];
			[company setName:name];
			[company setLogo:logo];
			[company setCompanyID:companyListLength];
			[self.companyList addObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
}

//this will become EDIT COMPANY
//using the row path of index, the company should already have an ID associated
//but then, wont ediitng the rows change that? - no becuase the class moves when we edit the rows (including any values that are apart of it (ie companyID))

-(void)editCompany:(NSString *)name logo:(NSString *)logo ticker:(NSString *)ticker original:(NSString *)original
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"UPDATE Company SET name='%@',logo='%@',ticker='%@' WHERE name='%@'", name,logo,ticker,original];
		NSLog(@"%@", insertStmt);
		const char *insert_stmt = [insertStmt UTF8String];
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Company edited in DB");
			//			Company *company = [[Company alloc] init];
			//			[company setName:name];
			//			[company setLogo:logo];
			//			[company setTicker:ticker];
			//			[self.companyList addObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
}

-(void)deleteCompany: (Company *)company
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"DELETE FROM Company WHERE name='%@'", company.name];
		NSLog(@"%@", insertStmt);
		const char *insert_stmt = [insertStmt UTF8String];
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Company REMOVED in DB");
			//			Company *company = [[Company alloc] init];
			//			[company setName:name];
			//			[company setLogo:logo];
			//			[company setTicker:ticker];
			[self.companyList removeObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
	
}
/*
 -(void)editCompanyRows: (Company *)companyFrom locationFrom:(NSUInteger *)locationFrom companyTo:(Company *)companyTo locationTo:(NSUInteger *)locationTo
 {
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
 NSString *insertStmt = [NSString stringWithFormat:@"UPDATE Company SET location = '%lu' WHERE name = '%@'; UPDATE Company SET location = '%lu' WHERE name = '%@'",locationFrom, companyFrom.name, locationTo, companyTo.name];
 NSLog(@"%@", insertStmt);
 const char *insert_stmt = [insertStmt UTF8String];
 if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
 {
 NSLog(@"Company REMOVED in DB");
 //			Company *company = [[Company alloc] init];
 //			[company setName:name];
 //			[company setLogo:logo];
 //			[company setTicker:ticker];
 //			[self.companyList removeObject:company];
 }
 sqlite3_close(personDB);
 
 [self updateDB];
	}
	
 }
 */

-(void)editCompanyRows:(NSMutableArray *)companyIDArray
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		for (int i = 0; i < [companyIDArray count]; i++) {
			NSString *insertStmt = [NSString stringWithFormat:@"UPDATE Company SET location = '%d' WHERE companyID = '%@'", i, companyIDArray[i]];
			NSLog(@"%@", insertStmt);
			const char *insert_stmt = [insertStmt UTF8String];
			if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
			{
				NSLog(@"Company MOVED in DB");
				//			Company *company = [[Company alloc] init];
				//			[company setName:name];
				//			[company setLogo:logo];
				//			[company setTicker:ticker];
				//			[self.companyList removeObject:company];
			}
			
		}
	}
	sqlite3_close(personDB);
	[self updateDB];
	
}

#pragma Product Methods
-(void)addProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo company_id:(NSString *)company_id product_id:(NSString *)product_id
//this is to add an ID number, which will be the same as the value of the company's company_ID
//product id will be length of the products
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO Products (name,url,logo,company_id) VALUES ('%@','%@','%@','%@')", name,url,logo,company_id];
		const char *insert_stmt = [insertStmt UTF8String];
		
		NSLog(@"%@", insertStmt);
		
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Product added to DB");
			Product *product = [[Product alloc] init];
			[product setName:name];
			[product setUrl:url];
			[product setLogo:logo];
			[product setCompany_ID:company_id];
			//			[self.companyList addObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
}

-(void)editProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo original:(NSString *)original
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"UPDATE Products SET name='%@',url='%@',logo='%@' WHERE name='%@'", name,url,logo,original];
		NSLog(@"%@", insertStmt);
		const char *insert_stmt = [insertStmt UTF8String];
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Product edited in DB");
			//			Company *company = [[Company alloc] init];
			//			[company setName:name];
			//			[company setLogo:logo];
			//			[company setTicker:ticker];
			//			[self.companyList addObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
}

-(void)deleteProduct: (Product *)product
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		NSString *insertStmt = [NSString stringWithFormat:@"DELETE FROM Products WHERE name='%@'", product.name];
		NSLog(@"%@", insertStmt);
		const char *insert_stmt = [insertStmt UTF8String];
		if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
		{
			NSLog(@"Product REMOVED in DB");
			//			Company *company = [[Company alloc] init];
			//			[company setName:name];
			//			[company setLogo:logo];
			//			[company setTicker:ticker];
			//			[self.companyList removeObject:company];
		}
		sqlite3_close(personDB);
		
		[self updateDB];
	}
	
}

-(void)editProductRows:(NSMutableArray *)productIDArray
{
	char *error;
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	dbPathString = [docPath stringByAppendingPathComponent:@"CompanyDataBase"];
	
	if (sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
	{
		for (int i = 0; i < [productIDArray count]; i++) {
			NSString *insertStmt = [NSString stringWithFormat:@"UPDATE Products SET location = '%d' WHERE product_id = '%@'", i, productIDArray[i]];
			NSLog(@"%@", insertStmt);
			const char *insert_stmt = [insertStmt UTF8String];
			if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
			{
				NSLog(@"Product MOVED in DB");
				//			Company *company = [[Company alloc] init];
				//			[company setName:name];
				//			[company setLogo:logo];
				//			[company setTicker:ticker];
				//			[self.companyList removeObject:company];
			}
			
		}
	}
	sqlite3_close(personDB);
	[self updateDB];
	
}


@end
