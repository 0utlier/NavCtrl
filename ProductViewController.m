//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Uncomment the following line to preserve selection between presentations.
	self.clearsSelectionOnViewWillAppear = NO;
 
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.navigationItem.rightBarButtonItems = @[self.editButtonItem, addButton];
	
	if (self.webViewController) {
		[self.webViewController release];
	}
	
	
	[self.tableView reloadData];
	
}

- (void)insertNewObject
{
	//display UIAlertView
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
	
	UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
	textField1.borderStyle = UITextBorderStyleRoundedRect;
	textField1.placeholder = @"Enter Product";
	//	textField1.text = [self.company.products[self.indexToChange.row] name];
	textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
	textField1.delegate = self;
	[v addSubview:textField1];
	self.textField1 = textField1;
	
	UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
	textField2.placeholder = @"Enter URL";
//	textField2.text = [self.company.products[self.indexToChange.row] url];
//	textField2.text = [[[self.tableView cellForRowAtIndexPath:self.indexToChange] textLabel]text];
	textField2.borderStyle = UITextBorderStyleRoundedRect;
	textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
	textField2.delegate = self;
	[v addSubview:textField2];
	self.textField2 = textField2;
	
	
	UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,60,252,25)];
	textField3.placeholder = @"Enter Logo";
	//	textField3.text = [self.company.products[self.indexToChange.row] logo];
	textField3.borderStyle = UITextBorderStyleRoundedRect;
	textField3.keyboardAppearance = UIKeyboardAppearanceAlert;
	textField3.delegate = self;
	[v addSubview:textField3];
	self.textField3 = textField3;
	
	
	UIAlertView *av = [[UIAlertView alloc] initWithTitle: @"Add Product"
												 message:@"" delegate:self
									   cancelButtonTitle:@"Cancel"
									   otherButtonTitles:@"Add", nil];
	[av setValue:v  forKey:@"accessoryView"];
	[av show];
	//			alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	//			[alert show];
	[av release];
	//NSLog(@"UIGestureRecognizerStateBegan.");
	
	// Update ToDoStatus
	[self.tableView reloadData];
	//Do Whatever You want on Began of Gesture
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	[self.tableView reloadData];
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
			//Do Whatever You want on End of Gesture
		}
		else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
			
			//			UIAlertView *alert = [[UIAlertView alloc] init];//WithTitle: @"Edit %@" message: @"" delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
			UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
			
			UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
			textField1.borderStyle = UITextBorderStyleRoundedRect;
			textField1.placeholder = @"Enter Product";
			textField1.text = [self.company.products[self.indexToChange.row] name];
			textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField1.delegate = self;
			[v addSubview:textField1];
			self.textField1 = textField1;
			
			UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
			textField2.placeholder = @"Enter URL";
			textField2.text = [NSString stringWithFormat:@"%@",[self.company.products[self.indexToChange.row] url]];
			//textField2.text = [[[self.tableView cellForRowAtIndexPath:self.indexToChange] textLabel]text];
			textField2.borderStyle = UITextBorderStyleRoundedRect;
			textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
			textField2.delegate = self;
			[v addSubview:textField2];
			self.textField2 = textField2;
			
			
			UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(10,60,252,25)];
			textField3.placeholder = @"Enter Logo";
			textField3.text = [self.company.products[self.indexToChange.row] logo];
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
			//			alert.alertViewStyle = UIAlertViewStylePlainTextInput;
			//			[alert show];
			[av release];
			//NSLog(@"UIGestureRecognizerStateBegan.");
			
			NSLog(@"long press on table view at row %lu",(unsigned long) indexPath.row);
			
			// Update ToDoStatus
			[self.tableView reloadData];
			//Do Whatever You want on Began of Gesture
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
	return [self.company.products count];
}
//cell configuration
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	// Configure the cell...
	cell.textLabel.text = [[self.company.products objectAtIndex:[indexPath row]]name];
	//	[[cell imageView] setImage:[UIImage imageNamed:self.company.products]logo];
	UILongPressGestureRecognizer *longPr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
	longPr.minimumPressDuration = 1.0; //seconds
	[cell addGestureRecognizer:longPr];
	
	
	return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return YES;
}
//edit rows
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSUInteger fromRow = [fromIndexPath row];
	NSUInteger toRow = [toIndexPath row];
	id rep = [self.company.products objectAtIndex:fromRow];
	//	[self.dao editCompanyAtRow:fromRow toRow:toRow rep:rep];
	[self.company.products removeObjectAtIndex:fromRow];
	[self.company.products insertObject:rep atIndex:toRow];

	NSMutableArray *productIDArray = [[NSMutableArray alloc]init];
	for (Product *product in self.company.products) {
		[productIDArray addObject:product.product_ID];
	}

	// if i need to have multiple images for each product
	//	id repL = [self.productLogo objectAtIndex:fromRow];
	//	[self.productLogo removeObjectAtIndex:fromRow];
	//	[self.productLogo insertObject:repL atIndex:toRow];
	[tableView reloadData];
	Company* company = self.company;
	[[DAO sharedDAO]editProductRows:productIDArray company:company];
}

//delete rows
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	Product *original = self.company.products[indexPath.row];
	Company *company = self.company;
	NSUInteger row = [indexPath row];
//	NSLog(@"%@", company.name);

	[self.company.products removeObjectAtIndex:row];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[[DAO sharedDAO] deleteProduct:original company:company];
	[tableView reloadData];
	
	[original release];
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */


// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the item to be re-orderable.
	return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Navigation logic may go here, for example:
	// Create the next view controller.
	_webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	self.webViewController.url =@"https://www.google.com/";
	
	// Pass the selected object to the new view controller.
	
	// Push the view controller.
	[self.navigationController pushViewController:self.webViewController animated:YES];
	
	[_webViewController release];
	
}

// use text from input to create new company
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	// only do the following if user hits ADD
//	if (buttonIndex == 1) {
//		NSString *tempTextField = [alertView textFieldAtIndex:0].text;
//		if (!self.company.products) {
//			self.company.products = [[NSMutableArray alloc]init];
//		}
//
//		Company *tempCompany = [[Company alloc]init];
//		tempCompany.name = tempTextField;
//		tempCompany.logo = @"myLogo.jpg";
//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
//		[self.company.products addObject:tempCompany];
//		[self.tableView reloadData];
//	}
//}
// use text from input to create new company
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	//alertView.title
	Company *company = self.company;

	// only do the following if user hits ADD
	if (buttonIndex == 1) {
		if([alertView.title isEqualToString:@"Add Product"]){
			
			if (!self.company.products) {
//				NSMutableArray *products = [[NSMutableArray alloc]init];
//				self.company.products = products;
//				[products release];
				self.company.products = [[[NSMutableArray alloc]init] autorelease];
			}
			NSString *tempTextField0 = self.textField1.text;
			NSString *tempTextField1 = self.textField2.text;
			NSString *tempTextField2 = self.textField3.text;
			/*
			Product *tempProduct = [[Product alloc]init];
			tempProduct.name = tempTextField0;
			tempProduct.url = tempTextField1;
			tempProduct.logo = tempTextField2;
			//			NSLog(@"logo tempProduct = %@",tempProduct.logo);
//			[self.company.products addObject:tempProduct];
//			NSLog(@"%@",[self.company.products]);
*/
			NSString *newIDNumber = [NSString stringWithFormat:@"%lu",(unsigned long)[self.company.products count]+1];
			NSLog(@"%@", newIDNumber);

			NSString *company_id = company.companyID;
			[[DAO sharedDAO] addProduct:tempTextField0 url:tempTextField1 logo:tempTextField2 company_id:company_id product_id:newIDNumber];
			[self.tableView reloadData];

		}
		else {
			
			// Edit Product
			NSString *original = [self.company.products[self.indexToChange.row] name];
			NSString *tempTextField0 = self.textField1.text;
			NSString *tempTextField1 = self.textField2.text;
			NSString *tempTextField2 = self.textField3.text;
			
			//		Company *tempCompany = [[Company alloc]init];
			//		tempCompany.name = tempTextField;
			//		tempCompany.logo = @"myLogo.jpg";
			//	NSLog(@"stuff changed");
			[self.company.products[self.indexToChange.row] setName: tempTextField0];
			[self.company.products[self.indexToChange.row] setUrl: tempTextField1];
			[self.company.products[self.indexToChange.row] setLogo: tempTextField2];
			//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
			NSLog(@"%ld", (long)buttonIndex);
			//		[self.dao.companyList addObject:tempCompany];
			[self.tableView reloadData];
			[[DAO sharedDAO] editProduct:tempTextField0 url:tempTextField1 logo:tempTextField2 original:original company:company];
			[tempTextField0 release];
		}
	}
}



@end
