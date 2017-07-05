//
//  MyCommentsVC.m
//  HPShop
//
//  Created by 李学文 on 2017/2/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "MyCommentsVC.h"
#import "HPCommentsCell.h"
#import "HPCommentMode.h"
#import "HPCommentContentCell.h"
#import "EwenTextView.h"
static NSString * HPCommentsCellID = @"HPCommentsCellID";
static NSString * HPCommentContentCellID = @"HPCommentContentCellID";
@interface MyCommentsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pagecount;
    
}
@property (nonatomic,strong)EwenTextView *commentTextView;//评论框
@property(strong, nonatomic) NSMutableArray * dataArr;
@property(strong, nonatomic) UITableView * mainTable;
@property(strong, nonatomic) NSString * commentStr;//评论内容
@property(strong, nonatomic) HPCommentReplyMode * currentCommentmode;//点击回复cell对应的mode
@property(strong, nonatomic) NSIndexPath * selectCommentIndexPath;
@end

@implementation MyCommentsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatNav];
    [self CreatMainTable];
     [self.view addSubview:self.commentTextView];
    __weak typeof(self) weakself = self;
    self.commentTextView.EwenTextViewBlock = ^(NSString *test){
        NSLog(@"%@",test);
        weakself.commentStr = test;
//        weakself.currentCommentmode.inputComment = test;
         [weakself CommentReply:weakself.currentCommentmode];
        
    };

}


/**
 *  导航设置   左右按钮 背景
 */

-(void)CreatNav
{
    
    
    //导航背景
    
  //  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fqrwBackground"] forBarMetrics:UIBarMetricsDefault];
    // self.navigationController.navigationBar.translucent = YES;
    
    // 标题
    UILabel * titleView =[[UILabel alloc] init];
    
    titleView.text = @"我的评价";
    
    titleView.font =[UIFont systemFontOfSize:18];
    
    titleView.textAlignment = NSTextAlignmentCenter;
    
    titleView.textColor =[UIColor colorFromHexRGB:@"C32E00"];
    
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
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];

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
    
    [self.mainTable registerNib:[UINib nibWithNibName:NSStringFromClass([HPCommentsCell class]) bundle:nil] forCellReuseIdentifier:HPCommentsCellID];
    
     [self.mainTable registerNib:[UINib nibWithNibName:NSStringFromClass([HPCommentContentCell class]) bundle:nil] forCellReuseIdentifier:HPCommentContentCellID];
    [self.view addSubview:self.mainTable];
       
    __weak typeof(self) weakSelf = self;
    self.mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (self.type==HPCommentsTypeForMe) {
            [weakSelf loadrequestMeData];
        }
        else
        {
            [weakSelf loadrequestGoodsDetailData];
        }
        
        
    }];
    
    self.mainTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (self.type==HPCommentsTypeForMe) {
        
            [weakSelf uprequestMeData];
        }
        else
        {
            [weakSelf uprequestGoodsDetailData];
        }
       
    }];
    
    [self.mainTable.mj_header beginRefreshing];
}
#pragma mark- 我的评论
-(void)loadrequestMeData
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];
//   [param setObject:[HPPersonModel shareManager].loginKey forKey:@"loginKey"];
    [param setObject:@"0" forKey:@"start"];
    [param setObject:@"10" forKey:@"pageSize"];

    pagecount = 0;
    [XWNetWorkManager XW_requestWithType:XWHttpRequestTypePost urlString:[NSString stringWithFormat:@"%@/%@",BASEURL,@""] parameters:param successBlock:^(id response) {
      
        NSLog(@"response：%@",response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
                NSArray  * arr =[[response objectForKey:@"map"] objectForKey:@"evaluateList"];
                [self.dataArr removeAllObjects];
                self.dataArr  = [HPCommentMode mj_objectArrayWithKeyValuesArray:arr];
                pagecount = self.dataArr.count;
                
            }else
            {
//                [AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        
        [self.mainTable.mj_header endRefreshing];
           [self.mainTable reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
//         [AppDelegate showHUDAndHide:@"网络异常" view:self.view];
     [self.mainTable.mj_header endRefreshing];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}

-(void)uprequestMeData
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];

    [param setObject:@(pagecount) forKey:@"start"];
    [param setObject:@(10) forKey:@"pageSize"];
//   [param setObject:[HPPersonModel shareManager].loginKey forKey:@"loginKey"];
    
    [XWNetWorkManager XW_requestWithType:XWHttpRequestTypePost urlString:[NSString stringWithFormat:@"%@/%@",BASEURL,@""] parameters:param successBlock:^(id response) {
        
        NSLog(@"response：%@",response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
                NSArray  * arr =[[response objectForKey:@"map"] objectForKey:@"evaluateList"];
            
                [self.dataArr addObjectsFromArray: [HPCommentMode mj_objectArrayWithKeyValuesArray:arr]];
                pagecount = self.dataArr.count;
                
            }else
            {
//                [AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        [self.mainTable.mj_footer endRefreshing];
        [self.mainTable reloadData];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
//         [AppDelegate showHUDAndHide:@"网络异常" view:self.view];
         [self.mainTable.mj_footer endRefreshing];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    

}

#pragma mark- 商品详情评论
-(void)loadrequestGoodsDetailData
{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];
//    [param setObject:[DJTUtility YRIsEmptString:[HPPersonModel shareManager].loginKey] forKey:@"loginKey"];
    [param setObject:[DJTUtility YRIsEmptString:self.commodityId] forKey:@"commodityId"];
    [param setObject:@"0" forKey:@"start"];
    [param setObject:@"10" forKey:@"pageSize"];
    
    pagecount = 0;
    [XWNetWorkManager XW_requestWithType:XWHttpRequestTypePost urlString:[NSString stringWithFormat:@"%@/%@",BASEURL,@""] parameters:param successBlock:^(id response) {
        
        NSLog(@"response：%@",response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
                NSArray  * arr =[[response objectForKey:@"map"] objectForKey:@"evaluateList"];
                [self.dataArr removeAllObjects];
                self.dataArr  = [HPCommentMode mj_objectArrayWithKeyValuesArray:arr];
                pagecount = self.dataArr.count;
                
            }else
            {
//                [AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        
        [self.mainTable.mj_header endRefreshing];
        [self.mainTable reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
//         [AppDelegate showHUDAndHide:@"网络异常" view:self.view];
        [self.mainTable.mj_header endRefreshing];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}
-(void)uprequestGoodsDetailData
{
    
    
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];
//    [param setObject:[HPPersonModel shareManager].loginKey forKey:@"loginKey"];
    [param setObject:[DJTUtility YRIsEmptString:self.commodityId] forKey:@"commodityId"];
    [param setObject:@(pagecount) forKey:@"start"];
    [param setObject:@"10" forKey:@"pageSize"];
    

    [XWNetWorkManager XW_requestWithType:XWHttpRequestTypePost urlString:[NSString stringWithFormat:@"%@/%@",BASEURL,@""] parameters:param successBlock:^(id response) {
        
        NSLog(@"response：%@",response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
                NSArray  * arr =[[response objectForKey:@"map"] objectForKey:@"evaluateList"];
       
              //  [HPCommentMode mj_objectArrayWithKeyValuesArray:arr]
                [self.dataArr addObjectsFromArray:[HPCommentMode mj_objectArrayWithKeyValuesArray:arr]];
                pagecount = self.dataArr.count;
                
            }else
            {
                //[AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        
        [self.mainTable.mj_footer endRefreshing];

        [self.mainTable reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
//        [AppDelegate showHUDAndHide:@"网络异常" view:self.view];
        [self.mainTable.mj_footer endRefreshing];

    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}
/**
 *  mainTable 代理方法实现
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HPCommentMode * mode = [self.dataArr objectAtIndex:section];
    return mode.EvaluateReplyList.count +1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0) {
        HPCommentContentCell *cell = [tableView dequeueReusableCellWithIdentifier:HPCommentContentCellID];
         HPCommentMode * mode = [self.dataArr objectAtIndex:indexPath.section];
        HPCommentReplyMode * model = [mode.EvaluateReplyList objectAtIndex:indexPath.row-1];
        cell.model = model;
        return cell;
    }
    
    HPCommentsCell *cell =[tableView dequeueReusableCellWithIdentifier:HPCommentsCellID];
       [cell ceshi];


    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HPCommentMode *mode =[self.dataArr objectAtIndex:indexPath.section];
    
    if (self.type==HPCommentsTypeForMe) {
        //
       
        [cell SetCommentMode:mode andType:HPCommentsCellTypeHaveGoods];
    }else
    {
         [cell SetCommentMode:mode andType:HPCommentsCellTypeOnlyPhoto];
       
    }

   
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // HPCommentsCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    CGFloat H=0;
    if (indexPath.row>0) {
        
        return 22;
    }

//   HPCommentsCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    HPCommentMode *mode =[self.dataArr objectAtIndex:indexPath.section];
    if (mode.photo.count>0) {
        H = (SCREEN_WIDTH - 26)/3;
    }
    H = H+ 130+79;
    if (self.type==HPCommentsTypeForGoods) {
        H = H-130;
    }
    return H;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 我的评论可以进行回复操作
    if (indexPath.row>0&&self.type==HPCommentsTypeForMe) {
        HPCommentMode * mode = [self.dataArr objectAtIndex:indexPath.section];
        HPCommentReplyMode * model = [mode.EvaluateReplyList objectAtIndex:indexPath.row-1];

      //记录点击回复的 行 和 mode
        _currentCommentmode = model;
        
       // self.commentTextView.textView.text = model.inputComment;
        _selectCommentIndexPath = indexPath;
        [self.commentTextView.textView becomeFirstResponder];
       
    }
}


-(void)CommentReply:(HPCommentReplyMode*)model
{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];

    [param setObject:@"1" forKey:@"authorId"];
   // [param setObject:[HPPersonModel shareManager].loginKey forKey:@"loginKey"];
    [param setObject:[DJTUtility YRIsEmptString:model.evaluateId] forKey:@"evaluateId"];

    [param setObject:@"0" forKey:@"replyMark"];
    [param setObject:self.commentStr forKey:@"replyContent"];
 
    [XWNetWorkManager XW_requestWithType:XWHttpRequestTypePost urlString:[NSString stringWithFormat:@"%@/%@",BASEURL,@""] parameters:param successBlock:^(id response) {
      
        NSLog(@"response：%@",response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            
            if ([[response objectForKey:@"success"] integerValue]==1) {
                
       //回复成功添加数据
                
                HPCommentReplyMode * replymode = [[HPCommentReplyMode alloc] init];
                replymode.evaluateId = model.evaluateId;
                replymode.authorName = @"李学文";
                replymode.replyContent = self.commentStr;
                replymode.replyMark = @"0";
                
                HPCommentMode * mode = [self.dataArr objectAtIndex:_selectCommentIndexPath.section];
                [mode.EvaluateReplyList addObject:replymode];
                //一个section刷新
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:_selectCommentIndexPath.section];
                [self.mainTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }else
            {
//                [AppDelegate showHUDAndHide:[response objectForKey:@"content"] view:self.view timer:0.4];
            }
        }
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
//       [AppDelegate showHUDAndHide:@"网络异常" view:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- get
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr =[[NSMutableArray alloc] init];
    }
    return _dataArr;
}
-(EwenTextView *)commentTextView
{
    if (!_commentTextView) {
        _commentTextView = [[EwenTextView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 49)];
        _commentTextView.backgroundColor = [UIColor clearColor];
        [_commentTextView setPlaceholderText:@"请输入文字"];
       
            }
    return _commentTextView;

}

@end
