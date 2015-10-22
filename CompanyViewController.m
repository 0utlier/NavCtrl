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
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
//    self.companyList = [[NSMutableArray alloc]initWithArray:@[@"Apple mobile devices",@"Samsung mobile devices",@"Moto mobile devices",@"Microsoft mobile devices"]];
//    self.title = @"Mobile device makers";
//	self.productLogo = [[NSMutableArray alloc]initWithArray:@[@"AppleLogo.jpg", @"SamsungLogo.jpg", @"MotoLogo.jpg", @"MicrosoftLogo.jpg"]];
//	self.applePr = [[NSMutableArray alloc]initWithArray:@[ipad, ipodTouch,iphone]];
//	self.samsungPr = [[NSMutableArray alloc]initWithArray:@[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"]];
//	self.motoPr = [[NSMutableArray alloc]initWithArray:@[@"slider",@"motog",@"360"]];
//	self.microsoftPr = [[NSMutableArray alloc]initWithArray:@[@"windows",@"phone",@"tablet"]];
	self.dao = [[DAO alloc]init];
	// call upon callback method
	[self.dao initiation];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		NSString *logoString = [[self.dao.companyList objectAtIndex:indexPath.row] logo];
		cell.imageView.image = [UIImage imageNamed:logoString];

    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
//	[[cell imageView] setImage:[UIImage imageNamed:[self.logo objectAtIndex:[indexPath row]]]];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// edit row order
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSUInteger fromRow = [fromIndexPath row];
	NSUInteger toRow = [toIndexPath row];
	id rep = [self.dao.companyList objectAtIndex:fromRow];
	[self.dao.companyList removeObjectAtIndex:fromRow];
	[self.dao.companyList insertObject:rep atIndex:toRow];
//	id repL = [[self.dao.companyList objectAtIndex:fromRow]logo ];
//	[[self.dao.companyList removeObjectAtIndex:fromRow] logo];
//	[self.productLogo insertObject:repL.logo atIndex:toRow];
}

// delete rows
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	[self.dao.companyList removeObjectAtIndex:row];
//	[self.productLogo removeObjectAtIndex:row];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	[tableView reloadData];
	
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
	self.productViewController.company = [self.dao.companyList objectAtIndex:indexPath.row];
	
//	if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Apple mobile devices"]){
//		self.productViewController.title = @"Apple mobile devices";
//		self.productViewController.products = self.applePr;
//		self.productViewController.productLogo = @"AppleLogo.jpg";
//	}
//	else if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Samsung mobile devices"]){
//		self.productViewController.title = @"Samsung mobile devices";
//		self.productViewController.products = self.samsungPr;
//		self.productViewController.productLogo = @"SamsungLogo.jpg";
//	}
//	else if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Moto mobile devices"]){
//		self.productViewController.title = @"Moto mobile devices";
//		self.productViewController.products = self.motoPr;
//		self.productViewController.productLogo = @"MotoLogo.jpg";
//	}
//	else {
//		self.productViewController.title = @"Microsoft mobile devices";
//		self.productViewController.products = self.microsoftPr;
//		self.productViewController.productLogo = @"MicrosoftLogo.jpg";
//	}
	
	[self.navigationController
	 pushViewController:self.productViewController
	 animated:YES];
	
	[self.tableView reloadData];

	
}



@end
