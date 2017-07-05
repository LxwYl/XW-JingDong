//
//  XWPhotoWebView.m
//  HPShop
//
//  Created by 李学文 on 2017/3/27.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "XWPhotoWebView.h"

#define TITLE_H 0
#define LINE_H 1.5
@interface XWPhotoWebView ()<WKUIDelegate,WKNavigationDelegate>
/*
 * 标题视图
 */
@property(strong, nonatomic) UIView * titleView;
/*
 * 记录选中的标题
 */
@property(strong, nonatomic) UIButton * selectBtn;
/*
 * 内容 webView
 */
@property(strong, nonatomic) WKWebView * wkWebView_h;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig_h;
/*
 * 线
 */
@property(strong, nonatomic) UIImageView * line;
@end
@implementation XWPhotoWebView


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    if (self) {
        [self CreatTitleView];
        [self CreatWebView];
        
    }
    
    return self;
}

#pragma mark-
#pragma mark- 创建titleView
-(void)CreatTitleView
{
    NSArray * titlearr = @[@"图文详情",@"价格参数",@"包装售后"];
    self.titleView.frame =CGRectMake(0, 64, self.width, TITLE_H);
    for (int i =0; i<titlearr.count; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
       
        [button addTarget:self action:@selector(ClicktitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[titlearr objectAtIndex:i] forState:UIControlStateNormal ];
        [button setTitleColor:[UIColor colorFromHexRGB:@"9e9e9e"] forState:UIControlStateNormal];
          [button setTitleColor:[UIColor colorFromHexRGB:@"ff7e00"] forState:UIControlStateSelected];
        button.titleLabel.font =[UIFont systemFontOfSize:13];
        
        CGFloat  W = self.width/3;
   
        
        button.frame = CGRectMake(W*i, 0, W,TITLE_H);
        
        button.tag = 50 + i;
        [self.titleView addSubview:button];

        if (i==0) {
            
            _selectBtn = button;
            self.line =[[UIImageView alloc] initWithFrame:CGRectMake(0, TITLE_H-1.5, 26, LINE_H)];
            [self.titleView addSubview:self.line];
            
            self.line.centerX = button.centerX;
            button.selected = YES;
            self.line.backgroundColor =[UIColor colorFromHexRGB:@"ff7e00"];
        }
    }
}
#pragma mark- 标题切换
-(void)ClicktitleBtn:(UIButton *)sender
{
    _selectBtn.selected = !_selectBtn.selected;
    
    sender.selected = !sender.selected;
    
    _selectBtn = sender;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.line.centerX = sender.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    // 刷新webView
}




#pragma mark- get 
-(UIView *)titleView
{
    if (!_titleView) {
      
        _titleView = [[UIView alloc] init];
        [self addSubview:_titleView];
        
    }
   
   return  _titleView;
}

#pragma mark- 创建WebView
-(void)CreatWebView
{
    
    [self startLoad];
    
    // 添加下拉刷新
    
    
    
}


//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");

}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

//与h5交互，回来这里的方法，根据返回的字段进行一些操作。
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{

    
    NSDictionary *dic_zf = [NSDictionary dictionary];
    
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        
        dic_zf = message.body;
    }else
    {
        dic_zf = [self dictionaryWithJsonString:message.body];
    }

    
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSError *err;
    KDLOG(@"jsonData===%@",jsonData);
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:nil];
    KDLOG(@"dic===%@",dic);
    
    return dic;
    
}
#pragma mark- 下拉监听
-(void)dropDownAction
{
    //结束下拉
    [self.wkWebView_h.scrollView.mj_header endRefreshing];
    if ([self.delegate respondsToSelector:@selector(XWPhotoWebViewDropdown:)]) {
        
        if (self.Yesdrop==YES) {
            
             [self.delegate XWPhotoWebViewDropdown:self];
        }
       
    }
}

#pragma mark - start load web
-(void)setGoodsId:(NSString *)goodsId
{
    _goodsId =@"http://www.jianshu.com";//goodsId;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com"]];

    request.timeoutInterval = 15.0f;
    [self.wkWebView_h loadRequest:request];

}
- (void)startLoad {
    
    
}

- (WKWebView *)wkWebView_h {
    if (!_wkWebView_h) {
        _wkWebView_h = [[WKWebView alloc] initWithFrame:CGRectMake(0, TITLE_H+64, SCREEN_WIDTH, SCREEN_HEIGHT-TITLE_H-64) configuration:self.wkConfig_h];
        _wkWebView_h.navigationDelegate = self;
        _wkWebView_h.UIDelegate = self;
        [self addSubview:_wkWebView_h];
        //添加下拉刷新控件
        _wkWebView_h.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^ {
            //进入刷新状态后会自动调用这个块
            [self dropDownAction];
        }];
        
        
    }
    return _wkWebView_h;
}
- (WKWebViewConfiguration *)wkConfig_h {
    if (!_wkConfig_h) {
        _wkConfig_h = [[WKWebViewConfiguration alloc] init];
        _wkConfig_h.allowsInlineMediaPlayback = YES;
        _wkConfig_h.allowsPictureInPictureMediaPlayback = YES;
    }
    return _wkConfig_h;
}
#pragma mark- 计算文字长度
- (CGFloat)widthFromString:(NSString*)text withFont:(UIFont*)font constraintToHeight:(CGFloat)height
{
    CGRect rect;
    
    float iosVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iosVersion >= 7.0) {
        rect = [text boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    }else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, height) lineBreakMode:NSLineBreakByWordWrapping];
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    return rect.size.width ;
}
@end
