//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/21/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

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

@end
