//
//  JTGuideViewController.h
//  JTGuideViewControllerDemo
//
//  Created by Gu on 2016/11/21.
//  Copyright © 2016年 Dangdang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideFinishBlock)();
typedef void(^NextButtonAppearanceBlock)(UIButton* _Nonnull  button);

@interface JTGuideViewController : UICollectionViewController

@property(nonatomic,strong)_Nullable GuideFinishBlock guideFinishBlock;
@property(nonatomic,strong)_Nullable NextButtonAppearanceBlock nextButtonAppearanceBlock;

-(_Nonnull instancetype)initWithImageArray:(NSArray* _Nonnull )imageArray;

@end
