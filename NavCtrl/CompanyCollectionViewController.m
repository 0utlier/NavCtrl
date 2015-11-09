//
//  CompanyCollectionViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 11/7/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"

@interface CompanyCollectionViewController ()

@end

@implementation CompanyCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
	
	//instantiate UICollectionView
	self.collectionView.delegate=self;
	self.collectionView.dataSource=self;
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
	[flowLayout setItemSize:CGSizeMake(350, 50)];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
	
    // Register cell classes
	[self.collectionView registerNib:[UINib nibWithNibName:@"CompanyCellView" bundle:nil] forCellWithReuseIdentifier:@"CompanyCellView"];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
	
	// Uncomment the following line to add button to make new company
	self.navigationItem.rightBarButtonItem = addButton;
	
	self.dao = [DAO sharedDAO];
	[self.dao updateDB];
	
	self.utilities = [[utilities alloc]init];
	[self.utilities importStockPrice:self.collectionView];
	
	UILongPressGestureRecognizer *longPr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
	
	longPr.minimumPressDuration = 1.0; //seconds
	[self.collectionView addGestureRecognizer:longPr];
	
	
	[self.collectionView setCollectionViewLayout:flowLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (self.editing) {
		// Open an action sheet with the possible editing actions
		Company *index = [self.dao.companyList objectAtIndex:indexPath.row];
//		NSLog(@"You clicked on %@ and indexPath row is %ld", index.name, (long)[indexPath row]);
		[self.collectionView performBatchUpdates:^{
			NSArray<NSIndexPath * > *deletionArray = @[indexPath];
			[self.collectionView deleteItemsAtIndexPaths:deletionArray];
			Company *original = self.dao.companyList[indexPath.row];
			[self.dao deleteCompany:original];
			[self.collectionView reloadData];
		} completion:nil];
		
	}
	else{
	self.productCollectionViewController = [[ProductCollectionViewController alloc]initWithNibName:@"ProductCollectionViewController" bundle:nil];
	self.productCollectionViewController.company = [self.dao.companyList objectAtIndex:indexPath.row];
	[self.navigationController
	 pushViewController:self.productCollectionViewController
	 animated:YES];
	}
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)insertNewObject
{
	//display UIAlertView
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
	
	UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
	textField1.borderStyle = UITextBorderStyleRoundedRect;
	textField1.placeholder = @"Enter Company";
	//	textField1.text = [self.company.products[self.indexToChange.row] name];
	textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
	textField1.delegate = self;
	[v addSubview:textField1];
	self.textField1 = textField1;
	
	UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
	textField2.placeholder = @"Enter Ticker";
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
	
	
	UIAlertView *av = [[UIAlertView alloc] initWithTitle: @"Add Company"
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
	[self.collectionView reloadData];
	//Do Whatever You want on Began of Gesture
	
}

//- (void)insertNewObject
//{
//	addCompanyVC *newCompany = [[addCompanyVC alloc]init];
//	newCompany.modalTransitionStyle = UIModalPresentationFormSheet;
//	
//	[self.navigationController pushViewController:newCompany animated:YES];
//}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
	CGPoint p = [gestureRecognizer locationInView:self.collectionView];
	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
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
			
			UIAlertView *av = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"Edit %@", [self.dao.companyList[self.indexToChange.row] name]]
														 message:@""
														delegate:self
											   cancelButtonTitle:@"Cancel"
											   otherButtonTitles:@"Change", nil];
			[av setValue:v  forKey:@"accessoryView"];
			[av show];
			[av release];
			
//						NSLog(@"long press on table view at row %ld", (long)indexPath.row);
//			[self.collectionView reloadData];
		}
	}
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dao.companyList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	CompanyCellView *cell = [[CompanyCellView alloc]init];
	cell = (CompanyCellView*)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCellView" forIndexPath:indexPath];
    
    // Configure the cell
	cell.companyName.text = [[self.dao.companyList objectAtIndex:[indexPath row]]name];
	cell.companyStock.text = [[self.dao.companyList objectAtIndex:[indexPath row]] ticker];
	cell.compantyStockPrice.text = [[self.dao.companyList objectAtIndex:[indexPath row]]tickerPrice];
	NSString *logoString = [[self.dao.companyList objectAtIndex:indexPath.row] logo];
	//		NSLog(@"%@",logoString);
	cell.CompanyLogo.image = [UIImage imageNamed:logoString];
	
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//delete cell
- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths{
//how to delete cell in UICollectionView
}
/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

// use text from input to create new company
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	//alertView.title
//	Company *company = self.company;
	NSString *original = [self.dao.companyList[self.indexToChange.row] name];
	
	if ([alertView.title isEqualToString:@"Add Company"]) {
		
		// only do the following if user hits ADD
		if (buttonIndex == 1) {
			if (!self.dao.companyList) {
				self.dao.companyList = [[NSMutableArray alloc]init];
			}
			NSString *tempTextField0 = self.textField1.text;
			NSString *tempTextField1 = self.textField2.text;
			NSString *tempTextField2 = self.textField3.text;
			
			// cr: its better if you put the 3 lines below into dao method - the same way you are changing the managed object or pass the index and alter the array based on index
			//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
			//		NSLog(@"%ld", (long)buttonIndex);
			NSString *companyListLength = [NSString stringWithFormat:@"%lu",(unsigned long)[self.dao.companyList count]+1	];
			[self.dao addCompany:tempTextField0 logo:tempTextField2 companyID:companyListLength];
			
			
			// there is also an option just to update the particular row in table
			[self.collectionView reloadData];
		}
	}
	else {
		
		// Edit Company
//		NSString *original = [self.company.products[self.indexToChange.row] name];
		NSString *tempTextField0 = self.textField1.text;
		NSString *tempTextField1 = self.textField2.text;
		NSString *tempTextField2 = self.textField3.text;
		
		//		Company *tempCompany = [[Company alloc]init];
		//		tempCompany.name = tempTextField;
		//		tempCompany.logo = @"myLogo.jpg";
		//	NSLog(@"stuff changed");
		[self.dao.companyList[self.indexToChange.row] setName: tempTextField0];
		[self.dao.companyList[self.indexToChange.row] setTicker: tempTextField1];
		[self.dao.companyList[self.indexToChange.row] setLogo: tempTextField2];
		//		NSLog(@"logo tempCompany = %@",tempCompany.logo);
		NSLog(@"%ld", (long)buttonIndex);
		//		[self.dao.companyList addObject:tempCompany];
		[self.collectionView reloadData];
		[self.dao editCompany:tempTextField0 logo:tempTextField2 ticker:tempTextField1 original:original];
		[tempTextField0 release];
		
	}
}

@end
