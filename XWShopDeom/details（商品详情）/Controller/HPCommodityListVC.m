//
//  HPCommodityListVC.m
//  HPShop
//
//  Created by 李学文 on 2017/2/8.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPCommodityListVC.h"
#import "HPCommodityListCell.h"
static NSString *HPCommodityListCellID = @"HPCommodityListCellID";
@interface HPCommodityListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray * dataArr;
@property(strong, nonatomic) UITableView * mainTable;
@end

@implementation HPCommodityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatMainTable];
    [self CreatNav];
}


/**
 *  导航设置   左右按钮 背景
 */

-(void)CreatNav
{
    
    
    //导航背景
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fqrwBackground"] forBarMetrics:UIBarMetricsDefault];
    // self.navigationController.navigationBar.translucent = YES;
    
    // 标题
    UILabel * titleView =[[UILabel alloc] init];
    
    titleView.text = @"商品清单";
    
    titleView.font =[UIFont systemFontOfSize:18];
    
    titleView.textAlignment = NSTextAlignmentCenter;
    
    titleView.textColor =[UIColor whiteColor];
    
    titleView.frame =CGRectMake(0, 7, 100, 30);
    
    self.navigationItem.titleView =titleView;
    
    // 左边按钮
    
    UIButton *leftbut =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbut setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    
    [leftbut addTarget:self action:@selector(ClicknavleftBut) forControlEvents:UIControlEventTouchUpInside];
    [leftbut sizeToFit];
    
    
    // 右边按钮
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:leftbut];
    UIButton *rightnav =[UIButton buttonWithType:UIButtonTypeCustom];
    rightnav.backgroundColor =[UIColor clearColor];
    [rightnav addTarget:self action:@selector(ClicknavrightBut) forControlEvents:UIControlEventTouchUpInside];
    
    [  rightnav setBackgroundImage:[UIImage imageNamed:@"syis"] forState:UIControlStateNormal];
    [rightnav sizeToFit];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:rightnav];
    
}
-(void)ClicknavrightBut
{
    
    
}
-(void)ClicknavleftBut
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  数据加载
 */

-(void)requestData
{
    
}

/**
 *  创建maintable
 */
#pragma mark-
#pragma mark- 创建tableview

-(void)CreatMainTable
{
    self.mainTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    self.mainTable.delegate = self ;
    
    self.mainTable.dataSource = self ;
    
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    self.mainTable.backgroundColor =[UIColor colorFromHexRGB:@"f8f8f9"];
    
    [self.mainTable registerNib:[UINib nibWithNibName:NSStringFromClass([HPCommodityListCell class]) bundle:nil] forCellReuseIdentifier:HPCommodityListCellID];
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.mainTable];
    
    
    
    
}
/**
 *  创建searchbarcontroller
 */
-(void)CreatSearbarcontroller
{
    
}

/**
 *  mainTable 代理方法实现
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HPCommodityListCell *cell =[tableView dequeueReusableCellWithIdentifier:HPCommodityListCellID];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
