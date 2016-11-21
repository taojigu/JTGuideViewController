//
//  JTGuideViewCell.h
//  JTGuideViewControllerDemo
//
//  Created by Gu on 2016/11/21.
//  Copyright © 2016年 Dangdang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kJTGuideViewBounds [UIScreen mainScreen].bounds
static NSString *kCellIdentifier_JTGuideViewCell = @"JTGuideViewCell";

@interface JTGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end
