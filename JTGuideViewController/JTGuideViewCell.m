//
//  JTGuideViewCell.m
//  JTGuideViewControllerDemo
//
//  Created by Gu on 2016/11/21.
//  Copyright © 2016年 Dangdang. All rights reserved.
//

#import "JTGuideViewCell.h"

@implementation JTGuideViewCell



- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:kJTGuideViewBounds];
    self.imageView.center = CGPointMake(kJTGuideViewBounds.size.width / 2, kJTGuideViewBounds.size.height / 2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.hidden = YES;
    [button setFrame:CGRectMake(0, 0, 200, 44)];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:5];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    self.button = button;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    
    [self.button setCenter:CGPointMake(kJTGuideViewBounds.size.width / 2, kJTGuideViewBounds.size.height - 100)];
}
@end
