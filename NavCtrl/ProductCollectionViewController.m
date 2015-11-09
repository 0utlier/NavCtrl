//
//  ProductCollectionViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 11/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewController.h"

@interface ProductCollectionViewController ()

@end

@implementation ProductCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
	
	//instantiate UICollectionView
	self.collectionView.delegate = self;
	 self.collectionView.dataSource=self;
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(400, 50)];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

	    // Register cell classes
	[self.collectionView registerNib:[UINib nibWithNibName:@"ProductCellView" bundle:nil] forCellWithReuseIdentifier:@"ProductCellView"];
    
    // Do any additional setup after loading the view.
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.navigationItem.rightBarButtonItems = @[self.editButtonItem, addButton];

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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (self.editing) {
		// Open an action sheet with the possible editing actions
		Company *company = self.company;
		[self.collectionView performBatchUpdates:^{
			NSArray<NSIndexPath * > *deletionArray = @[indexPath];
			[self.collectionView deleteItemsAtIndexPaths:deletionArray];
			Product *original = self.company.products[indexPath.row];
			[[DAO sharedDAO] deleteProduct:original company:company];
			[self.collectionView reloadData];
		} completion:nil];
		
	}
	else{
	self.webViewController = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
	self.webViewController.url =@"https://www.google.com/";
	// Push the view controller.
	[self.navigationController pushViewController:self.webViewController animated:YES];
	}
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
	[self.collectionView reloadData];
	//Do Whatever You want on Began of Gesture
	
}

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
//			textField2.text = [NSString stringWithFormat:@"%@",[self.company.products[self.indexToChange.row] url]];
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
			
			
			UIAlertView *av = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat:@"Edit %@", [self.company.products[self.indexToChange.row] name]]
																   //@"Edit %@",[[[self.collectionView cellForItemAtIndexPath:self.indexToChange] textLabel]text]]
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
			[self.collectionView reloadData];
			//Do Whatever You want on Began of Gesture
		}
	}
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
	return [self.company.products count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	

	ProductCellView *cell = [[ProductCellView alloc]init];
	cell = (ProductCellView *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCellView"
												forIndexPath:indexPath];
	
	NSString *data = [[self.company.products objectAtIndex:indexPath.row] name];
//	NSLog(@"%@",data);
	
	[cell.productName setText:data];
	[cell.productLogo setImage:[UIImage imageNamed:self.company.logo]];
//	 [UIImage imageNamed:@"AppleLogo.jpg"]];
	
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
			[self.collectionView reloadData];
			
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
			[self.collectionView reloadData];
			[[DAO sharedDAO] editProduct:tempTextField0 url:tempTextField1 logo:tempTextField2 original:original company:company];
			[tempTextField0 release];
		}
	}
}

@end
