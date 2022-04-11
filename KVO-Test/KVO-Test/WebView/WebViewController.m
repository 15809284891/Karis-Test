//
//  TACWebViewController.m
//  TACSamples
//
//  Created by karisli(李雪) on 2018/4/10.
//  Copyright © 2018年 Tencent. All rights reserved.
//
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#import "WebViewController.h"
#import "TestWebView.h"
#import "MRLogicInjection.h"
#import "WebViewInjection.h"
@interface WebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) TestWebView *webView;
@property (strong, nonatomic) UIButton *hideBtn;
@property (strong,nonatomic) UIButton *add_removeBt;
@property (strong,nonatomic) UIButton *show_hiddenBt;
@end

@implementation WebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"webView";
    }
    return self;
}


-(TestWebView *)webView{
    if (!_webView) {
        _webView = [[TestWebView alloc] init];
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"app_link_h5" ofType:@"html"]];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        _webView.scrollView.bounces = false;
   
        _webView.allowsLinkPreview = YES;
        _webView.delegate = self;
    }
    return _webView;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"change hidden %@", change);
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpBt];
    [self.view addSubview:self.webView];
//    /**
//     先调用custom，再调用kvo，kvo失效
//     */
//    [self catchExceptionForUIWebView:self.webView];
//    [self.webView addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
    
    
    /**
     先调用kvo，再调用custom，custom失效
     */
    [self.webView addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
    [self catchExceptionForUIWebView:self.webView];
   
 
    self.webView.frame = CGRectMake(0, 300,screenW, self.view.frame.size.height-110);

}

- (void) catchExceptionForUIWebView:(UIWebView*)webview
{

    
    NSArray* logics = @[[WebViewInjection class]];
    MRExtendInstanceLogicWithKey(webview, @"tacwebview", logics);
}

-(UIButton *)createBT{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.titleLabel.textAlignment = NSTextAlignmentCenter;
    bt.backgroundColor = [UIColor lightGrayColor];
    [bt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return bt;
}
-(void)setUpBt{
    UIButton *add_removeBt = [self createBT];
    add_removeBt.frame = CGRectMake(0, 100, (screenW-2)/2.0, 40);
    [add_removeBt setTitle:@"移除" forState:UIControlStateNormal];
    [add_removeBt setTitle:@"添加" forState:UIControlStateSelected];
    [add_removeBt addTarget:self action:@selector(add_remove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add_removeBt];
    _add_removeBt = add_removeBt;
    
    UIButton *show_hiddenBt =  [self createBT];
    show_hiddenBt.frame = CGRectMake(CGRectGetMaxX(add_removeBt.frame)+2, 100, (screenW-2)/2.0, 40);
    [show_hiddenBt setTitle:@"隐藏" forState:UIControlStateNormal];
    [show_hiddenBt setTitle:@"显示" forState:UIControlStateSelected];
      NSLog(@"%d",show_hiddenBt.selected?YES:NO);
    [show_hiddenBt addTarget:self action:@selector(show_hidden:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:show_hiddenBt];
}

-(void)add_remove:(UIButton *)bt{
    bt.selected = !bt.selected;
    if (bt.selected) {
        [_webView removeFromSuperview];
        
    }else{
     
        [self.view addSubview:self.webView];
    }
 
}

-(void)show_hidden:(UIButton *)bt{
    bt.selected = !bt.selected;
    if (bt.selected) {
        [self.webView setHidden:YES];
       
    }else{
        [self.webView setHidden:NO];
 
    }
 
}

#pragma mark ---Delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"网页开始加载");
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    NSLog(@"网页加载完成");
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return nil;
}
@end
