//
//  XWShopDetetailsVC.m
//  HPShop
//
//  Created by 李学文 on 2017/3/28.
//  Copyright © 2017年 李学文. All rights reserved.
//
//#import "HPMessagecateoryVC.h"
#import "XWShopDetetailsVC.h"
#import "XWShopDetailBannderView.h"
#import "XWSignButton.h"
#import "XWPhotoWebView.h"
#import "XWAddShopCarTitleView.h"
#import "HPCommodityListVC.h"
#import "MyCommentsVC.h"
#import "XWAddShopBar.h"
#import "XWShopDetetailsCell.h"
#import "XWShopSelectSizeView.h"
//#import "HPStoreVC.h"
#import "XWShopDetetailsModel.h"
//#import "HPSureOrderVC.h"
//#import "XWShopDetailBannderView.h"
//#import "HPGoodsModel.h"
//#import "HPShopCarVC.h"
//#import "HPLoginController.h"
//#import "PYSearchViewController+request.h"
//#import "UIViewController+WXSTransition.h"
//#import "HPSearchResultVC.h"
//#import "KDShareTool.h"
//#import "ChatViewController.h"
#import "UIView+CurrentVc.h"
#import "HPShopCarModel.h"
@interface XWShopDetetailsVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,XWPhotoWebViewDelegate,XWAddShopCarTitleViewDelegate,XWAddShopBarDelegate,UIGestureRecognizerDelegate,XWShopDetetailsCellDelegate,XWShopSelectSizeViewDelegate>


/*
 生成订单参数
 */
@property(assign, nonatomic) NSInteger goodscount;//商品件数

@property(strong, nonatomic) NSString * spec_info;//规格 不包含个数

@property(strong, nonatomic) NSString * spec_infobl;//界面上显示的规格类容 （包含个数）




/*
 * 导航头部视图
 */
@property(strong, nonatomic) XWAddShopCarTitleView * titleView;

@property(strong, nonatomic) UIScrollView * detailBaseView;
/*
 * 头部bannder视图
 */
@property(strong, nonatomic) XWShopDetailBannderView *bannderView;


/*
 * 第一页面
 */
@property(strong, nonatomic) UITableView * mainTable;
/*
 *  图文详情
 */
@property(strong, nonatomic) XWPhotoWebView * PhotoWebView;
/*
 * 评论列表
 */
@property(strong, nonatomic) MyCommentsVC * commentlistVC;


/*
 * 底部的toobar
 */
@property(strong, nonatomic) XWAddShopBar * toolbar;
/*
 *  模型
 */

@property(strong, nonatomic) XWShopDetetailsModel * model;

@end

@implementation XWShopDetetailsVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _spec_info = @"-1"  ;
    _goodscount = 1; //初始化价钱
    _spec_infobl = @"选择 颜色尺码";
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self CreatNav];
    
    [self CreatDetailBaseView];
    
    [self requestData];
 
    [self.view addSubview:self.toolbar];
    
    
}
-(void)CreatNav
{
    //导航背景
    
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fqrwBackground"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    _titleView = [[XWAddShopCarTitleView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    
    self.navigationItem.titleView = _titleView;

    _titleView.delegate =self;
    // 左边按钮
    
    UIButton *leftbut =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbut setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    
    [leftbut addTarget:self action:@selector(ClicknavleftBut) forControlEvents:UIControlEventTouchUpInside];
    [leftbut sizeToFit];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftbut];
    
    // 右边按钮

    UIButton *rightnav =[UIButton buttonWithType:UIButtonTypeCustom];
    rightnav.backgroundColor =[UIColor clearColor];
    [rightnav addTarget:self action:@selector(jq_fenXiangMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [rightnav setBackgroundImage:[UIImage imageNamed:@"dy_zhuanfa"] forState:UIControlStateNormal];
    [rightnav sizeToFit];
    UIBarButtonItem* righttwo= [[UIBarButtonItem alloc] initWithCustomView:rightnav];
    XWSignButton * carbutton =[[XWSignButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    carbutton.Type = XWSignButtonTypeWithNumber;
    [carbutton addTarget:self action:@selector(ClickNavShopcar) forControlEvents:UIControlEventTouchUpInside];
    carbutton.NumberStr = @"0";
    [carbutton setImage:[UIImage imageNamed:@"gouwc"] forState:UIControlStateNormal];
    UIBarButtonItem* right= [[UIBarButtonItem alloc] initWithCustomView:carbutton];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 10;
    
    self.navigationItem.rightBarButtonItems = @[righttwo,fixedSpaceBarButtonItem,right];
}
/*
 *  购物车
 */
#pragma mark- 购物车
-(void)ClickNavShopcar
{
//    if (![HPPersonModel shareManager].isLoginKey) {
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[HPLoginController alloc]init ] animated:YES completion:nil];
//    }else
//    {
//        HPShopCarVC * vc =[[HPShopCarVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}
-(void)ClicknavleftBut
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 分享
-(void)jq_fenXiangMethod
{
}
#pragma mark-
#pragma mark- 创建滚动视图
-(void)CreatDetailBaseView
{
    self.detailBaseView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.detailBaseView.delegate = self;
    
    [self.view addSubview:self.detailBaseView];
    
    //self.detailBaseView.backgroundColor =[UIColor yellowColor];
    
    self.detailBaseView.pagingEnabled = YES;
    
    self.detailBaseView.bounces = NO;
    //需要先设置bounces为NO 才起效
    self.detailBaseView.alwaysBounceVertical =YES ;
    self.detailBaseView.alwaysBounceHorizontal =NO ;
    
    self.detailBaseView.showsHorizontalScrollIndicator = NO;
    self.detailBaseView.showsVerticalScrollIndicator = NO;
    
    self.detailBaseView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    // 商品
    [self CreatMainTable];
    [self CreatPhotoWebView];
    // 图文
    //  self.detailBaseView.userInteractionEnabled = YES;
    //评价
}
#pragma mark- 导航标题切换代理
-(void)XWAddShopCarTitleView:(XWAddShopCarTitleView *)View ClickTitleWithTag:(NSInteger)tag andButton:(UIButton *)sender
{
    // scroll水平方向偏移
    self.detailBaseView.contentOffset = CGPointMake(tag*SCREEN_WIDTH, 0);
    switch (tag) {
        case 0:
        {
            // 商品
            // 更改图文详情的位置
            [self modifyPhotoViewFrameOne:YES];
            
        }
            break;
        case 1:
        {
            //详情
            [self modifyPhotoViewFrameOne:NO];
            // 设置偏移
        }
            break;
            
            
        case 2:
        {
            // 评价
            // 设置偏移
            //            self.commentlistVC.view.x = tag*SCREEN_WIDTH;
            self.commentlistVC.view.frame = CGRectMake(tag*SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
          //  [self.detailBaseView addSubview:self.commentlistVC.view];
            
            
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark-
#pragma mark- UIScrollViewdelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 设置偏移
    [self scrollViewDidEndScrollingAnimation:scrollView];
  
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 繁殖冲突
    if ([self.mainTable isEqual:scrollView]) {
        
        // 调整 bannder的偏移量
        NSLog(@"---contentOffset Y:%lf",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y>0) {
            
            self.bannderView.y =64+ (scrollView.contentOffset.y)*0.2;
          //  self.bannderEventView.y = 0 - (scrollView.contentOffset.y+SCREEN_WIDTH);
        }
        if (scrollView.contentOffset.y<=0) {
            self.bannderView.y = 64;
          //  self.bannderEventView.y= 0;
        }
    }
    
    
}
// 减速完成调用（scrollView的contentOffSet是确定的）

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    
    
    if ([self.detailBaseView isEqual:scrollView]) {
        
        NSLog(@"---contentOffset Y:%lf",scrollView.contentOffset.y);
        
        // 索引
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        
        // 修改导航选中标题
        
        [self.titleView  updataSelectTitleWithTag:index];
        
        switch (index) {
            case 0:
            {
                // 更改图文详情的位置
                [self modifyPhotoViewFrameOne:YES];
                
                
            }
                break;
            case 1:
            {
                //详情
                [self modifyPhotoViewFrameOne:NO];
            }
                break;
            case 2:
            {
                // 评价
                // 设置偏移
                //            self.commentlistVC.view.x = tag*SCREEN_WIDTH;
                self.commentlistVC.view.frame = CGRectMake(index*SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
               // [self.detailBaseView addSubview:self.commentlistVC.view];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark- 创建图文详情
-(void)CreatPhotoWebView
{
    self.PhotoWebView = [[XWPhotoWebView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.PhotoWebView.backgroundColor =[UIColor whiteColor];
    self.PhotoWebView.goodsId = self.commodityId;
    [self.detailBaseView addSubview:self.PhotoWebView];
    // 图文详情下拉监听
    self.PhotoWebView.delegate = self;
    //开启下拉监听
    self.PhotoWebView.Yesdrop = YES;
    
}

#pragma mark-数据加载
-(void)requestData
{


    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopdemo" ofType:@"plist"];
    NSMutableDictionary *response = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
                _model = [XWShopDetetailsModel mj_objectWithKeyValues:[response objectForKey:@"map"]];
                
                NSMutableArray * urlArr =[[NSMutableArray alloc] init];
                //添加头部商品图片
                for (int i = 0; i<_model.imgList.count; i++) {
                    
                    XWShopbannderModel * model =[_model.imgList objectAtIndex:i];
                    
                    
                    [urlArr addObject:[NSString stringWithFormat:@"%@",model.pathName]];
                }
                
                if (_model.commodityPropertyList>0) {
                    
                     _spec_infobl = @"选择 颜色尺码";
                }else
                {
                     _spec_infobl = @"件数：1";
                }
                
                
                
                
                self.bannderView.imageURLStringsGroup = urlArr;
                
                [ self.toolbar XWAddShopBarfollwBtnWithState:[_model.whetherCollectList integerValue]];
                
               
            }else
            {
//                [AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        [self.mainTable reloadData];
        
     
}

#pragma mark-
#pragma mark- 创建tableview

-(void)CreatMainTable
{
    self.mainTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    self.mainTable.delegate = self ;
    
    self.mainTable.dataSource = self ;
    
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    self.mainTable.backgroundColor =[UIColor clearColor];
    
    //设置头部偏移 放入bannder
   // self.mainTable.contentInset=UIEdgeInsetsMake(SCREEN_WIDTH, 0, 0, 0);
    self.mainTable.showsVerticalScrollIndicator = NO;
  
    UIView * headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH+64)];
    headerView.clipsToBounds = YES;

    [headerView addSubview:self.bannderView];
    self.mainTable.tableHeaderView = headerView;//self.bannderView;
    
    [self.detailBaseView addSubview:self.mainTable];

    
    __weak typeof(self) weakSelf = self;
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //        NSLog(@"%d",self.mainTable.mj_footer.triggerAutomaticallyRefreshPercent);
        
        // 监听下拉 进入图文详情页
        [weakSelf GotoPhotoDetail];
    }];
    footer.triggerAutomaticallyRefreshPercent = 222;
    self.mainTable.mj_footer = footer;
    
    
    
}

#pragma mark- 上拉 显示图文
-(void)GotoPhotoDetail
{
    // 禁止在显示图文详情时可左右滚动
    
    self.detailBaseView.scrollEnabled = NO;
    
    // 结束上拉刷新
    [self.mainTable.mj_footer endRefreshing];
    // 添加延迟函数
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        // 调整contentSize
        weakSelf.detailBaseView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT*2);
        
        [UIView animateWithDuration:0.3 animations:^{
            //自动向上偏移
            weakSelf.detailBaseView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        }];
        //调整导航titleView
        
        [_titleView ScrollShowTitleLableWithDuration:0.3];
    });
    
    
    
}

#pragma mark- 图文下拉
-(void)XWPhotoWebViewDropdown:(XWPhotoWebView *)View
{
    // 开启滑动左右切换界面
    
    self.detailBaseView.scrollEnabled = YES;
    //图文下拉
    // 延迟0.5秒
    
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            // 改变偏移量
            weakSelf.detailBaseView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
            //调整contentsize
            weakSelf.detailBaseView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
            
        }];
        //调整导航titleView
        
        [_titleView ScrollShowTitleSegmentViewWithDuration:0.3];
        
    });
    [self.mainTable reloadData];
    
}

#pragma mark-mainTable 代理方法实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //
    XWShopDetetailsCell * cell =[XWShopDetetailsCell XWShopDetetailsCell:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _model;
    [cell configTempCellWith:indexPath];
    cell.delegate =self;
    if (indexPath.row==0&&indexPath.section==1) {
        if ([self.spec_info isEqualToString:@"-1"]) {

            cell.cateroySize.text = self.spec_infobl;
           
        }else
        {
            cell.cateroySize.text = self.spec_infobl;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat high;
    switch (indexPath.section) {
        case 0:
        {
            
            XWStoreMessageModel *storeModel = _model.StoreMessage;
            
            //有优惠信息和无优惠消息调整高度
            XWcommodityMessageModel *commodModel = _model.commodityMessageList;
            if ([commodModel.coupon_amount integerValue]||[storeModel.cut_price integerValue]) {
                high = 119+36;
            }else
            {
                high = 119;
            }
            
        }
            break;
        case 1:
        {
            high = 41;
        }
            break;
        case 2:
        {
            if (_model.EvaluateList.id.length==0) {
                return 44;
            }
            high = 107;
        }
            break;
        case 3:
        {
            
            high=131;
        }
            break;
        case 4:
        {
            NSInteger row=( _model.salesVolume.count+1)/2;
            high = 50 + 36 + ((SCREEN_WIDTH-3)/4*row+80/2*row)*2;
        }
            break;
            
        default:
            break;
    }
    return high;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
        }
            break;
        case 1:
        {
            // 选择种类
            
            XWShopSelectSizeView *goodSelectView = [[XWShopSelectSizeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            goodSelectView.degate =self;
            
            goodSelectView.dataArr = self.model.commodityPropertyList;
            goodSelectView.currentVc = self;
            [goodSelectView showWith3D:YES];
             goodSelectView.Goodsmodel = self.model.commodityMessageList;
            XWShopDetetailsCell *cell =[tableView cellForRowAtIndexPath:indexPath];
            __weak XWShopDetetailsCell *weakcell = cell;
            __weak XWShopDetetailsVC *weakself = self;
            goodSelectView.blockUpdateBtnTitle = ^(NSString *btnTitle,NSInteger count) {
              // 选择完尺码回调
                self.goodscount = count;
                self.spec_info = btnTitle;
                self.spec_infobl = [NSString stringWithFormat:@"%@ 件数：%ld",btnTitle,count];
                weakcell.cateroySize.text =  weakself.spec_infobl ;
                
            };
        }
            break;
        case 2:
        {
        }
            break;
        case 3:
        {
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionview =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    sectionview.backgroundColor =[UIColor colorFromHexRGB:@"f7f6f5"];
    return sectionview;
}
#pragma mark-
#pragma mark- XWShopDetetailsCell代理
-(void)XWShopDetetailsCell:(XWShopDetetailsCell *)cell ClickGotoStaoreButton:(UIButton *)sender
{
     [self gotoStore];
    
}
-(void)XWShopDetetailsCell:(XWShopDetetailsCell*)cell ClickMoreGoods:(UIButton *)sender
{
    NSLog(@" 查看更多");
    // 1. 创建热门搜索数组
//    HPSearchResultVC *vc = [[HPSearchResultVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.searchContentStr = @"";
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)XWShopDetetailsCell:(XWShopDetetailsCell*)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath withStoreId:(NSString *)StoreId
{
    XWShopDetetailsVC *vc = [[XWShopDetetailsVC alloc] init];
    vc.commodityId = StoreId;
    
    UINavigationController *nav =
    [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}
#pragma mark-
#pragma mark- 点击toolbar 客服 店铺 关注 加入购物车 立即购买
-(void)XWAddShopBar:(XWAddShopBar *)bar ClickbootomBarWithBtn:(UIButton *)sender withIndex:(NSInteger)index
{
    
    
    if ([DJTUtility YRIsEmptString: self.model.StoreMessage.id].length==0) {
        // 商品ID 为空的情况下
//        [AppDelegate showHUDAndHide:@"系统繁忙，请稍后再试" view:self.view];
        return;
    }
    switch (index) {
        case 0:
        {
            // 客服
            //聊天类型:EMConversationTypeChat
//            ChatViewController *chatController = [[ChatViewController alloc]
//                                                         initWithConversationChatter:[DJTUtility YRIsEmptString:_model.StoreMessage.ringLetterAccount]
//                                                         conversationType:EMConversationTypeChat];
//            chatController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:chatController animated:YES];
            
        }
            break;
        case 1:
        {
            [self gotoStore];
            
        }
            break;
        case 2:
        {
            // 关注
            [self CollectionGoods];
        }
            break;
        case 3:
        {
            [self addshopCar];
        }
            break;
        case 4:
        {
            // 立即购买
            
            [self gotoBuy];
            
            
        }
            break;
            default:
            break;
    }
    
}

#pragma mark-  XWShopSelectSizeViewDegate
-(void)XWShopSelectSizeView:(XWShopSelectSizeView*)View ClickAddCar:(UIButton*)sender
{
    
      NSLog(@"添加购物车");
    
}

#pragma mark - 立即购买进入确认订单界面。
-(void)XWShopSelectSizeView:(XWShopSelectSizeView*)View ClickGoBuy:(UIButton*)sender
{
    //
    NSLog(@"立即购买");
    
}
#pragma mark- 关注
-(void)CollectionGoods
{
    
    // 假装请求了
    if ([   _model.whetherCollectList isEqualToString:@"1"]) {
        
        _model.whetherCollectList = @"0";
    }else
    {
        _model.whetherCollectList = @"1";

    }
   
}
#pragma mark- 加入购物车
-(void)addshopCar
{
    
    // 值为-1 且 self.model.commodityPropertyList.count存在型号时必须选择商品型号
     if ([_spec_info isEqualToString:@"-1"]&&self.model.commodityPropertyList.count>0) {
    
    // 加入购物车
    XWShopSelectSizeView *goodSelectView = [[XWShopSelectSizeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    goodSelectView.dataArr = self.model.commodityPropertyList;
    goodSelectView.degate =self;
    goodSelectView.Goodsmodel = self.model.commodityMessageList;
    goodSelectView.currentVc = self;
    [goodSelectView showWith3D:YES];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    XWShopDetetailsCell *cell =[self.mainTable cellForRowAtIndexPath:indexPath];
    __weak XWShopDetetailsCell *weakcell = cell;
    __weak XWShopDetetailsVC *weakself = self;
    goodSelectView.blockUpdateBtnTitle = ^(NSString *btnTitle,NSInteger count) {
        
        self.goodscount = count;
        self.spec_info = btnTitle;
        self.spec_infobl = [NSString stringWithFormat:@"%@ 件数：%ld",btnTitle,count];
        weakcell.cateroySize.text = weakself.spec_infobl ;
        
    };
     }


   /*
    *  在这里向服务器发送添加请求
    */
}
#pragma mark- 立即购买
-(void)gotoBuy
{
    // 值为-1 且 self.model.commodityPropertyList.count存在型号时必须选择商品型号 （）
     if ([_spec_info isEqualToString:@"-1"]&&self.model.commodityPropertyList.count>0) {
    
         
         // 如果客户一次也未查看过商品尺码的情况下 上弹规格尺码
    // 加入购物车
    XWShopSelectSizeView *goodSelectView = [[XWShopSelectSizeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    goodSelectView.dataArr = self.model.commodityPropertyList;
    
    goodSelectView.currentVc = self;
    [goodSelectView showWith3D:YES];
    goodSelectView.degate =self;
    goodSelectView.Goodsmodel = self.model.commodityMessageList;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    XWShopDetetailsCell *cell =[self.mainTable cellForRowAtIndexPath:indexPath];
    __weak XWShopDetetailsCell *weakcell = cell;
    __weak XWShopDetetailsVC *weakself = self;
    goodSelectView.blockUpdateBtnTitle = ^(NSString *btnTitle,NSInteger count) {
        // 选择完尺码回调
        self.goodscount = count;
        self.spec_info = btnTitle;
        self.spec_infobl = [NSString stringWithFormat:@"%@ 件数：%ld",btnTitle,count];
        weakcell.cateroySize.text =  weakself.spec_infobl ;
        
        
    };
    //    return;
}
    /*
     *  在这里跳转订单详情
     */

}
#pragma mark- 客服
-(void)chat
{
    /*
    if (![HPPersonModel shareManager].isLoginKey) {
        
        [self presentViewController:[[HPLoginController alloc]init ] animated:YES completion:nil];
    }
     */
}
#pragma mark- 店铺
-(void)gotoStore
{
    /*
    // 店铺
    HPStoreVC * vc =[[HPStoreVC alloc] init];
    
    vc.goodsID = self.model.StoreMessage.id;
    
    UINavigationController * nav =[[UINavigationController alloc] initWithRootViewController:vc]
    ;
    [self presentViewController:nav animated:NO completion:nil];
     */
    
}
#pragma mark-
#pragma mark- 调增图文详情的位置
-(void)modifyPhotoViewFrameOne:(BOOL)inone
{
    
    // 修改图文详情的位置
    
    //图文详情第一页第二页都存在 所以用的是同一个View ，然后进行位置切换
    if (inone==YES) {
        // 修改图文的Frame 位置为第一page的下半页
        
        self.PhotoWebView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        //开启下拉监听
        self.PhotoWebView.Yesdrop = YES;
        // 禁止水平滚动
        self.detailBaseView.scrollEnabled = YES;
        
    }else
    {
        // 修改图文的Frame 位置为第二page的上半页
        
        self.PhotoWebView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        //关闭下拉监听
        self.PhotoWebView.Yesdrop = NO;
        self.detailBaseView.scrollEnabled = YES;
        
    }
}


#pragma mark- get

-(XWShopDetailBannderView *)bannderView
{
    if (!_bannderView) {
        _bannderView =[[XWShopDetailBannderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH)];
        _bannderView.backgroundColor =[UIColor colorFromHexRGB:@"808080"];
        
        
        
    }
    return _bannderView;
}

-(MyCommentsVC *)commentlistVC
{
    if (!_commentlistVC) {
        _commentlistVC = [[MyCommentsVC alloc] init];
        _commentlistVC.type = HPCommentsTypeForGoods;
         [_detailBaseView addSubview:self.commentlistVC.view];
        _commentlistVC.commodityId = self.commodityId;
    }
    return _commentlistVC;
}
-(void)dealloc
{
    NSLog(@"添加购物车释放");
}
-(XWAddShopBar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[XWAddShopBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45-64, SCREEN_WIDTH, 45)];
        _toolbar.delegate = self;
    }
    return _toolbar;
}


-(XWShopDetetailsModel *)model
{
    if (!_model) {
        _model = [[XWShopDetetailsModel alloc] init];
    }
    return _model;
}




@end
