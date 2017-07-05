//
//  XWShopDetailBannderView.m
//  HPShop
//
//  Created by 李学文 on 2017/4/13.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWShopDetailBannderView.h"
#import "XWbannderItem.h"
NSString * const XWbannderItemID = @"XWbannderItem";
@interface XWShopDetailBannderView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(weak, nonatomic) UICollectionView * mainCollection;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) UIControl *pageControl;



@property (nonatomic, weak) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图

@end
@implementation XWShopDetailBannderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupMainCollection];
        
        self.pageButton.frame = CGRectMake(frame.size.width-45, frame.size.height - 45, 45, 45);
        [self.pageButton setBackgroundImage:[UIImage imageNamed:@"pagenumber"] forState:UIControlStateNormal];
        
        self.placeholderImage = [UIImage imageNamed:@"guide_1"];
        
        [self addSubview:self.pageButton];
    }
    return self;
}
#pragma mark - properties

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.clipsToBounds = YES;
        [self insertSubview:bgImageView belowSubview:self.mainCollection];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}
#pragma mark- 创建  mainCollection 

-(void)setupMainCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    UICollectionView *mainCollection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainCollection.backgroundColor = [UIColor clearColor];
    mainCollection.pagingEnabled = YES;
    mainCollection.showsHorizontalScrollIndicator = NO;
    mainCollection.showsVerticalScrollIndicator = NO;
    
    [mainCollection registerNib:[UINib nibWithNibName:NSStringFromClass([XWbannderItem class]) bundle:nil] forCellWithReuseIdentifier:XWbannderItemID];
 
    mainCollection.dataSource = self;
    mainCollection.delegate = self;
    [self addSubview:mainCollection];
    _mainCollection = mainCollection;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagePathsGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XWbannderItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XWbannderItemID forIndexPath:indexPath];
   // long itemIndex = indexPath.item % self.imagePathsGroup.count;
    
    NSString *imagePath = self.imagePathsGroup[indexPath.row];
    
    if ([imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.photoView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
//            cell.photoView.image = self.placeholderImage;
        } else {
            cell.photoView.image = [UIImage imageNamed:imagePath];
        }
    } else if ([imagePath isKindOfClass:[UIImage class]]) {
        cell.photoView.image = imagePath;
    }
    


    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.width, self.height);
    
    return size;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(XWShopDetailBannderView:didSelectItemAtIndex:)]) {
        
        [self.delegate XWShopDetailBannderView:self didSelectItemAtIndex:indexPath.row];
        
    }
//    if (self.clickItemOperationBlock) {
//        self.clickItemOperationBlock(indexPath.item % self.imagePathsGroup.count);
//    }
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
}
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.imagePathsGroup.count;
    
    if (imagePathsGroup.count != 1) {
        self.mainCollection.scrollEnabled = YES;
       
    } else {
        self.mainCollection.scrollEnabled = NO;
    }
    

    [self.mainCollection reloadData];
    
    if (imagePathsGroup.count>0) {
        
         [self.pageButton setTitle:[NSString stringWithFormat:@"1/%ld",_totalItemsCount] forState:UIControlStateNormal];
    }
    
    //添加页码
    

    
//    [self.pageButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [self.pageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    
}
-(UIButton *)pageButton
{
    if (!_pageButton) {
        _pageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _pageButton;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainCollection.width * 0.5) / self.mainCollection.width;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl = itemIndex % self.imagePathsGroup.count+1;
    
    [self.pageButton setTitle:[NSString stringWithFormat:@"%d/%ld",indexOnPageControl,self.imagePathsGroup.count] forState:UIControlStateNormal];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainCollection.width * 0.5) / self.mainCollection.width;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl = itemIndex % self.imagePathsGroup.count;
    
    
    // 结束的回掉
    if ([self.delegate respondsToSelector:@selector(XWShopDetailBannderView:didScrollToIndex:)]) {
        [self.delegate XWShopDetailBannderView:self didScrollToIndex:itemIndex];
    }
}

#pragma mark- 代码左滑
-(void)makeCodeLeftScroll
{
    
    
    int itemIndex = (self.mainCollection.contentOffset.x + self.mainCollection.width * 0.5) / self.mainCollection.width;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    if (!(itemIndex+1<=self.imagePathsGroup.count)) return;
    
    CGFloat offsethight = self.mainCollection.contentOffset.y;
    self.mainCollection.contentOffset =CGPointMake((itemIndex+1)* self.mainCollection.width, offsethight);
    
   
        
    // 结束的回掉
    if ([self.delegate respondsToSelector:@selector(XWShopDetailBannderView:didScrollToIndex:)]) {
        [self.delegate XWShopDetailBannderView:self didScrollToIndex:itemIndex+1];
    }
 [self.pageButton setTitle:[NSString stringWithFormat:@"%d/%ld",itemIndex+1,_totalItemsCount] forState:UIControlStateNormal];
}

#pragma mark- 代码又滑
-(void)makeCodeRightScroll
{
    
    int itemIndex = (self.mainCollection.contentOffset.x + self.mainCollection.width * 0.5) / self.mainCollection.width;
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    if (!(itemIndex-1>=0)) return;
    
    CGFloat offsethight = self.mainCollection.contentOffset.y;
    self.mainCollection.contentOffset =CGPointMake((itemIndex-1)* self.mainCollection.width, offsethight);
    // 结束的回掉
    if ([self.delegate respondsToSelector:@selector(XWShopDetailBannderView:didScrollToIndex:)]) {
        [self.delegate XWShopDetailBannderView:self didScrollToIndex:itemIndex];
    }

    [self.pageButton setTitle:[NSString stringWithFormat:@"%d/%ld",itemIndex,_totalItemsCount] forState:UIControlStateNormal];
}




@end
