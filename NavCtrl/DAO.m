//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "NavControllerAppDelegate.h"


@implementation DAO


// uncomment to make the DAO a singleton
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

- (void)initiation{
	// company creation
	Company *apple = [[Company alloc]init];
	Company *samsung = [[Company alloc]init];
	Company *moto = [[Company alloc]init];
	Company *microsoft = [[Company alloc]init];
	
	// product creation
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
	
	// company values (name, logo, ticker, companyID, location)
	apple.name = @"Apple";
	apple.logo = @"AppleLogo.jpg";
	apple.ticker = @"AAPL";
	apple.companyID = @"1";
	apple.location = 1.00;
	//	apple.tickerPrice = ;
	samsung.name = @"Samsung";
	samsung.logo = @"samsungLogo.jpg";
	samsung.ticker = @"SSNLF";
	samsung.companyID = @"2";
	samsung.location = 2.00;
	moto.name = @"Moto";
	moto.logo = @"motoLogo.jpg";
	moto.ticker = @"MSI";
	moto.companyID = @"3";
	moto.location = 3.00;
	microsoft.name = @"Microsoft";
	microsoft.logo = @"microsoftLogo.jpg";
	microsoft.ticker = @"MSFT";
	microsoft.companyID = @"4";
	microsoft.location = 4.00;
	
	// products values (name, companyID, productID)
	ipad.name = @"iPad";
	ipad.company_ID = @"1";
	ipad.product_ID = @"1";
	ipodTouch.name = @"iPod Touch";
	ipodTouch.company_ID = @"1";
	ipodTouch.product_ID = @"2";
	iphone.name = @"iPhone";
	iphone.company_ID = @"1";
	iphone.product_ID = @"3";
	
	gS4.name = @"Galaxy S4";
	gS4.company_ID = @"2";
	gS4.product_ID = @"1";
	gNote.name = @"Galaxy Note";
	gNote.company_ID = @"2";
	gNote.product_ID = @"2";
	gTab.name = @"Galaxy Tab";
	gTab.company_ID = @"2";
	gTab.product_ID = @"3";
	
	slider.name = @"Slider";
	slider.company_ID = @"3";
	slider.product_ID = @"1";
	motoG.name = @"MotoG";
	motoG.company_ID = @"3";
	motoG.product_ID = @"2";
	m360.name = @"360";
	m360.company_ID = @"3";
	m360.product_ID = @"3";
	
	windows.name = @"Windows";
	windows.company_ID = @"4";
	windows.product_ID = @"1";
	wPhone.name = @"Phone";
	wPhone.company_ID = @"4";
	wPhone.product_ID = @"2";
	wTablet.name = @"Tablet";
	wTablet.company_ID = @"4";
	wTablet.product_ID = @"3";
	
	// company list array
	self.companyList = [[NSMutableArray alloc]initWithArray:@[apple,samsung,moto,microsoft]];
	
	//company's product array
	apple.products = [[NSMutableArray alloc]initWithArray:@[ipad,ipodTouch,iphone]];
	samsung.products = [[NSMutableArray alloc]initWithArray:@[gS4,gNote,gTab]];
	moto.products = [[NSMutableArray alloc]initWithArray:@[slider,motoG,m360]];
	microsoft.products = [[NSMutableArray alloc]initWithArray:@[windows,wPhone,wTablet]];
	
	// update the dataBase with fresh hard data
	[self createDBFromObjects];
	
}

-(void)updateDB
{// if the file exists, reload. Otherwise, initiation
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [path objectAtIndex:0];
	NSString *dbPathString = [docPath stringByAppendingPathComponent:@"DayTwelveData.sqlite"];
	NSLog(@"\n%@\n\n", dbPathString);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath:dbPathString]) {
		[self initiation];
	}
	else{
		[self reloadDataFromContext];
	}
}

-(void) reloadDataFromContext { // request for all the data from dataBase
	[self.companyList removeAllObjects];
	[self.companyListManaged removeAllObjects];
	
	NSFetchRequest *request = [[NSFetchRequest alloc]init];
	NSPredicate *p = [NSPredicate predicateWithFormat:@"name MATCHES '.*'"];
	[request setPredicate:p];
	
	NSSortDescriptor *sortByLocation = [[NSSortDescriptor alloc]
										initWithKey:@"location" ascending:YES];
	
	[request setSortDescriptors:[NSArray arrayWithObject:sortByLocation]];
	
	NSEntityDescription *company = [[self.managedObjectModel entitiesByName] objectForKey:@"Company"];
	[request setEntity:company];
	NSError *error = nil;
	
	//This gets data only from context, not from store
	NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
	self.companyList = [[NSMutableArray alloc] init];
	
	if(!result)
	{
		[NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
	}
	else if([result count] == 0)
	{
		// cr: if result is 0 and file exists - it will be a never ending recursive call
		// its better to call initiation
		[self initiation];
	}
	else {
		self.companyListManaged = [[NSMutableArray alloc]initWithArray:result];
	}
	
	//make the NSObject array from NSMangaged Array
	for (CompanyManaged *companyManaged in result) {
		
		Company *company = [[Company alloc]init];
		company.name = companyManaged.name;
		company.logo = companyManaged.logo;
		company.ticker = companyManaged.ticker;
		company.companyID = companyManaged.companyID;
		company.location = companyManaged.location;
		company.products = [[NSMutableArray alloc]init];
		
		for(ProductManaged *productManaged in companyManaged.products){
			
			// make nsmangedO from object
			Product *product = [[Product alloc]init];
			product.name = productManaged.name;
			product.url = productManaged.url;
			product.logo = productManaged.logo;
			product.company_ID = productManaged.company_ID;
			product.product_ID = productManaged.product_ID;
			[company.products addObject:product];
			[product release];
			
		}
		
		[self.companyList addObject:company];
		[company release];
	}
	
	
	[self managedObjectContext];
	[self saveContext];
	
	
	
	
}


-(void)createDBFromObjects {
	
	self.companyListManaged = [[NSMutableArray alloc]init];
	NSManagedObjectContext *context = self.managedObjectContext;
	//make an NSManaged array as well, using the existing companyList
	for (Company *company in self.companyList) {
		
		
		CompanyManaged *companyObject =(CompanyManaged*)[NSEntityDescription
														 insertNewObjectForEntityForName:@"Company"
														 inManagedObjectContext:context];
		companyObject.name = company.name;
		companyObject.logo = company.logo;
		companyObject.ticker = company.ticker;
		companyObject.companyID = company.companyID;
		companyObject.location = company.location;
		//companyObject.products = [[NSMutableArray alloc]init];
		
		for(Product *product in company.products){
			// make nsmangedO from object
			ProductManaged *productObject = (ProductManaged *) [NSEntityDescription
																insertNewObjectForEntityForName:@"Product"
																inManagedObjectContext:context];
			productObject.name = product.name;
			productObject.url = product.url;
			productObject.logo = product.logo;
			productObject.company_ID = product.company_ID;
			productObject.product_ID = product.product_ID;
			
			[companyObject addProductsObject:productObject];
		}
		
		[self.companyListManaged addObject:companyObject];
		[self saveContext];
	}
}

#pragma mark - Company Methods

-(void)addCompany:(NSString *)name logo:(NSString *)logo companyID:(NSString *)companyListLength {
	NSManagedObjectContext *context = self.managedObjectContext;
	CompanyManaged *companyObject =(CompanyManaged*)[NSEntityDescription
													 insertNewObjectForEntityForName:@"Company"
													 inManagedObjectContext:context];
	companyObject.name = name;
	companyObject.logo = logo;
	companyObject.companyID = companyListLength;
	companyObject.location = [companyListLength integerValue];
	companyObject.ticker = nil;
	[self.companyListManaged addObject:companyObject];
	
	[self saveContext];
	
//	NSLog(@"Company added to DB");
	
	Company *company = [[Company alloc] init];
	[company setName:name];
	[company setLogo:logo];
	[company setCompanyID:companyListLength];
	[company setLocation:[companyListLength integerValue]];
	[company setTicker:nil];
	[self.companyList addObject:company];
}


-(void)editCompany:(NSString *)name logo:(NSString *)logo ticker:(NSString *)ticker original:(NSString *)original
{
	for (CompanyManaged *company in self.companyListManaged) {
		if ([company.name isEqualToString:original]) {
			
			company.name = name;
			company.logo = logo;
			company.ticker = ticker;
			
		}
	}
	[self saveContext];
}


-(void)deleteCompany:(Company *)company
{
	// remove the NSManagedObject
	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if ([companyManaged.name isEqualToString:company.name]) {
			//	NSMutableSet *mutableSet = [NSMutableSet setWithSet:companyManaged.products];
			//	[mutableSet removeAllObjects];
			
			for (ProductManaged *productManaged in companyManaged.products) {
				[self.managedObjectContext deleteObject:productManaged];
			}
			[companyManaged removeProducts:companyManaged.products];
			[self.companyListManaged removeObject:companyManaged];
			
			[self.managedObjectContext deleteObject:companyManaged];
			//			NSLog(@"Removed NSMgm object");
			break;
		}
	}
	[self saveContext];

	[company.products removeAllObjects];
	[self.companyList removeObject:company];
	
	//[company retain];
	
	//[company.products[0] release];
//	[company.products[1] release];
//	[company.products[2] release];

	
//	[company release];

}


- (void)editCompanyRows:(Company *)companyFrom locationFrom:(double)locationFrom locationTo:(double)locationTo locationNextTo:(double)locationNextTo
{
	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if (companyManaged.location == locationFrom) {
			double averageLocation =  (locationTo + locationNextTo)/2;
			companyManaged.location = averageLocation;
		}
	}
	for (Company *company in self.companyList) {
		if (company.location == locationFrom) {
			double averageLocation =  (locationTo + locationNextTo)/2;
			company.location = averageLocation;
		}
	}
	[self saveContext];
}


#pragma mark - Product Methods


-(void)addProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo company_id:(NSString *)company_id product_id:(NSString *)product_id
{
	NSManagedObjectContext *context = self.managedObjectContext;
	ProductManaged *productObject =(ProductManaged*)[NSEntityDescription
													 insertNewObjectForEntityForName:@"Product"
													 inManagedObjectContext:context];
	productObject.name = name;
	productObject.url = url;
	productObject.logo = logo;
	productObject.company_ID = company_id;
	productObject.product_ID = product_id;

	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if (companyManaged.companyID == company_id) {
			[companyManaged addProductsObject:productObject];
			break;
		}
	}
	[self saveContext];
//	NSLog(@"Company added to DB");
	
	Product *product = [[Product alloc] init];
	[product setName:name];
	[product setLogo:logo];
	[product setCompany_ID:company_id];
	[product setProduct_ID:product_id];
	
	for (Company *company in self.companyList) {
		if (company.companyID == company_id) {
			[company.products addObject:product];
			break;
		}
	}
}

- (void)editProduct:(NSString *)name url:(NSString *)url logo:(NSString *)logo original:(NSString *)original company:(Company *)company
{
	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if ([companyManaged.name isEqualToString:company.name]) {
			for (ProductManaged *productManaged in companyManaged.products) {
				if ([productManaged.name isEqualToString:original]) {
					
					productManaged.name = name;
					productManaged.logo = logo;
					productManaged.url = url;
				}
			}
		}
	}
	[self saveContext];
}


-(void)deleteProduct:(Product *)product company:(Company *)company // Does this needs to delete the product only? Or do I need to delete the relationship between that product and the company
{
	
	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if ([companyManaged.name isEqualToString:company.name]) {
			for (ProductManaged *productManaged in companyManaged.products) {
				if ([productManaged.name isEqualToString:product.name]) {
					NSMutableSet *mutableSet = [NSMutableSet setWithSet:companyManaged.products];
					[mutableSet removeObject:productManaged];
					[self.managedObjectContext deleteObject:productManaged];
				}
			}
			NSLog(@"Removed NSMgm object");
			break;
		}
	}
	[self saveContext];
	[company.products removeObject:product];
	[product release];
}

- (void)editProductRows:(NSMutableArray *)productIDArray company:(Company *)company
{
	for (CompanyManaged *companyManaged in self.companyListManaged) {
		if ([companyManaged.name isEqualToString: company.name]){
			for (ProductManaged *productManaged in companyManaged.products) {
				for (int i = 0; i < [productIDArray count]; i++) {
					productManaged.product_ID = productIDArray[i];
					
				}
			}
		}
	}
	[self saveContext];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

/*
 -(void) saveChanges
 {
	NSError *err = nil;
	BOOL successful = [context save:&err];
	if(!successful){
 NSLog(@"Error saving: %@", [err localizedDescription]);
	}
	NSLog(@"Data Saved");
 }
 */


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"dataModel" withExtension:@"momd"]; //dataModel.xcdatamodeld
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DayTwelveData.sqlite"];
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}



@end
