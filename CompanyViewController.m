//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

// uncomment this to initialiaze the view without xib
/*
 - (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	
	if (self) {
		// Custom initialization
	}
	return self;
}
*/

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Uncomment the following line to preserve selection between presentations.
	self.clearsSelectionOnViewWillAppear = NO;
 
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
	
	// Uncomment the following line to add button to make new company
	self.navigationItem.rightBarButtonItem = addButton;
	
	// instantiate tableView
	self.tableView.delegate=self;
	self.tableView.dataSource=self;
	[self.tableView registerNib:[UINib nibWithNibName:@"CompanyCellView" bundle:nil] forCellReuseIdentifier:@"CompanyCellView"];
	
	self.dao = [DAO sharedDAO];
	[self.dao updateDB];
	
	self.utilities = [[utilities alloc]init];
	[self.utilities importStockPrice:self.tableView];
	[self.tableView reloadData];

}


- (void)insertNewObject
{
	addCompanyVC *newCompany = [[addCompanyVC alloc]init];
	newCompany.modalTransitionStyle = UIModalPresentationFormSheet;
	
	[self.navigationController pushViewController:newCompany animated:YES];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
	CGPoint p = [gestureRecognizer locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
	self.indexToChange = indexPath;
	if (indexPath == nil)
		NSLog(@"long press on table view but not on a row");
	else
	{
		if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
			NSLog(@"UIGestureRecognizerStateEnded");
		}
		else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
			
			UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
			
			UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
			textField1.borderStyle = UITextBorderStyleRoundedRect;
			textField1.placeholder = @"Enter Company";
			textField1.text = [self.dao.companyList[self.indexToChange.row] name];
			textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField1.delegate = self;
			[v addSubview:textField1];
			self.textField1 = textField1;
			
			UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
			textField2.placeholder = @"Enter Ticker";
			textField2.text = [self.dao.companyList[self.indexToChange.row] ticker];
			textField2.borderStyle = UITextBorderStyleRoundedRect;
			textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField2.delegate = self;
			[v addSubview:textField2];
			self.textField2 = textField2;

			
			UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,60,252,25)];
			textField3.placeholder = @"Enter Logo";
			textField3.text = [self.dao.companyList[self.indexToChange.row] logo];
			textField3.borderStyle = UITextBorderStyleRoundedRect;
			textField3.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField3.delegate = self;
			[v addSubview:textField3];
			self.textField3 = textField3;

			
			UIAlertView *av = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"Edit %@",[[[self.tableView cellForRowAtIndexPath:self.indexToChange] textLabel]text]]
														 message:@"" delegate:self
											   cancelButtonTitle:@"Cancel"
											   otherButtonTitles:@"Change", nil];
			[av setValue:v  forKey:@"accessoryView"];
			[av show];
			[av release];
			
//			NSLog(@"long press on table view at row %ld", (long)indexPath.row);
			[self.tableView reloadData];
		}
	}
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
	// Return the number of rows in the section.
	return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CompanyCellView *tableViewCell=(CompanyCellView*)[self.tableView dequeueReusableCellWithIdentifier:@"CompanyCellView" forIndexPath:indexPath];
	tableViewCell.companyName.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
	tableViewCell.companyStock.text = [[self.dao.companyList objectAtIndex:[indexPath row]] ticker];
	tableViewCell.compantyStockPrice.text = [[self.dao.companyList objectAtIndex:[indexPath row]]tickerPrice];
	NSString *logoString = [[self.dao.companyList objectAtIndex:indexPath.row] logo];
//		NSLog(@"%@",logoString);
	tableViewCell.CompanyLogo.image = [UIImage imageNamed:logoString];
		UILongPressGestureRecognizer *longPr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
		longPr.minimumPressDuration = 1.0; //seconds
		[tableViewCell addGestureRecognizer:longPr];

	return tableViewCell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

// edit row order
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	double fromRow = [fromIndexPath row];
	double toRow = [toIndexPath row];
	
	Company *rep = [self.dao.companyList objectAtIndex:fromRow];
	Company *repTo = [self.dao.companyList objectAtIndex:toRow];
	
	double fromLocation = rep.location;
	double toLocation = repTo.location;
	double nextLocation = 0;
	//if its the last spot
	if (toRow + 1 >= [self.dao.companyList count]) {
		nextLocation = toLocation + 1;
	}
//	if its the first spot
	else if (toRow == 0.00	){
		nextLocation = toLocation - 1;
	}
	else{
		Company *repNext = [self.dao.companyList objectAtIndex:toRow + 1];
		nextLocation = repNext.location;
	}
	[self.dao.companyList removeObjectAtIndex:fromRow];
	[self.dao.companyList insertObject:rep atIndex:toRow];
	[[DAO sharedDAO] editCompanyRows:rep locationFrom:fromLocation locationTo:toLocation locationNextTo:nextLocation];
}

// delete rows
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	Company *original = self.dao.companyList[indexPath.row];
	[self.dao deleteCompany:original];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[tableView reloadData];
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.productViewController.company = [self.dao.companyList objectAtIndex:indexPath.row];
	
	[self.navigationController
	 pushViewController:self.productViewController
	 animated:YES];
	
	[self.tableView reloadData];
	
	
}

// use text from input to create new company
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *original = [self.dao.companyList[self.indexToChange.row] name];
	// only do the following if user hits ADD
	if (buttonIndex == 1) {
		if (!self.dao.companyList) {
			self.dao.companyList = [[NSMutableArray alloc]init];
		}
		NSString *tempTextField0 = self.textField1.text;
		NSString *tempTextField1 = self.textField2.text;
		NSString *tempTextField2 = self.textField3.text;
		
		[self.dao.companyList[self.indexToChange.row] setName: tempTextField0];
		[self.dao.companyList[self.indexToChange.row] setTicker: tempTextField1];
		[self.dao.companyList[self.indexToChange.row] setLogo: tempTextField2];
		//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
		//		NSLog(@"%ld", (long)buttonIndex);
		
		CompanyManaged *comp = [self.dao.companyListManaged  objectAtIndex:self.indexToChange.row];
		[self.dao editCompany:tempTextField0 logo:tempTextField2 ticker:tempTextField1 original:original];
		[self.tableView reloadData];
	}
}

-(void)dealloc {
	[_dao release];
	[_utilities release];
	[_indexToChange release];
	[_productViewController release];
	[_textField1 release];
	[_textField2 release];
	[_textField3 release];
	[super dealloc];
}

@end
