//
//  JTGuideViewController.m
//  JTGuideViewControllerDemo
//
//  Created by Gu on 2016/11/21.
//  Copyright © 2016年 Dangdang. All rights reserved.
//

#import "JTGuideViewController.h"
#import "JTGuideViewCell.h"

@interface JTGuideViewController ()

@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,strong)NSArray* imageArray;


@end

@implementation JTGuideViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)initWithImageArray:(nonnull NSArray*)imageArray
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:layout];
    self.imageArray = imageArray;


    [self initCustomView];

    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self notifyThisVersionShown];
    
    
    [self layoutCustomViews];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(BOOL)shouldPresented
{
    return YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];

    BOOL shown = [userDefaults boolForKey:[NSString stringWithFormat:@"version_%@", version]];
    return !shown;
}
-(void)notifyThisVersionShown
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];

    [userDefaults setBool:YES forKey:[NSString stringWithFormat:@"version_%@", version]];
    [userDefaults synchronize];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark -- init messages

-(void)initCustomView
{

    self.pageControl = [[UIPageControl alloc] init];
    //self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.numberOfPages = self.imageArray.count;
}

-(void)configureCellButton:(UIButton*)button
{
    if (self.nextButtonAppearanceBlock == nil)
    {
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:NSLocalizedString(@"Netx", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nextButtonAppearanceBlock(button);
        });
    }
    
    return;
}
-(void)layoutCustomViews
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[JTGuideViewCell class] forCellWithReuseIdentifier:kCellIdentifier_JTGuideViewCell];
    
    self.pageControl.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0f);
    self.pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 60);
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x / kJTGuideViewBounds.size.width);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    JTGuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_JTGuideViewCell forIndexPath:indexPath];
    
    UIImage *img = [self.imageArray objectAtIndex:indexPath.row];
    CGSize size = [self adapterSizeImageSize:img.size compareSize:kJTGuideViewBounds.size];
    
    //自适应图片位置,图片可以是任意尺寸,会自动缩放.
    cell.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    cell.imageView.image = img;
    cell.imageView.center = CGPointMake(kJTGuideViewBounds.size.width / 2, kJTGuideViewBounds.size.height / 2);
    
    if (indexPath.row == self.imageArray.count - 1) {
        [cell.button setHidden:NO];
        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self configureCellButton:cell.button];
           } else {
        [cell.button setHidden:YES];
    }
    
    return cell;
    
    // Configure the cell
    
    return cell;
}
/**
 *  计算自适应的图片
 *
 *  @param is 需要适应的尺寸
 *  @param cs 适应到的尺寸
 *
 *  @return 适应后的尺寸
 */
- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs
{
    CGFloat w = cs.width;
    CGFloat h = cs.width / is.width * is.height;
    
    if (h < cs.height) {
        w = cs.height / h * w;
        h = cs.height;
    }
    return CGSizeMake(w, h);
}


-(void)nextButtonHandler:(id)sender
{
    if (nil != self.guideFinishBlock)
    {
        dispatch_async(dispatch_get_main_queue(), self.guideFinishBlock);
    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

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

@end
