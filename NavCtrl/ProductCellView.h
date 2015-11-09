//
//  ProductCellView.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/9/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCellView : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *productLogo;
@property (retain, nonatomic) IBOutlet UILabel *productName;

@end
