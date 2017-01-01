//
//  EBTWebViewWithGradientProgressView.m
//  EBTGradientProgressViewDemo
//
//  Created by ebaotong on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//

//进度条高度
#define KWebViewProgressViewHeight 2
//导航栏高度
#define kNavigationBarHeight 44
#import "EBTWebViewWithGradientProgressView.h"
#import "EBTGradientProgressView.h"
@interface EBTWebViewWithGradientProgressView ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    NSTimer *myTimer;
    BOOL timerBool;//用来控制定时器
}
@property(nonatomic,strong)EBTGradientProgressView *progressView;
@end
@implementation EBTWebViewWithGradientProgressView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self= [super initWithFrame:frame]) {
        
        timerBool = NO;
        //不显示水平方向滚动条以及通过代理函数水平方向不能滚动
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.scalesPageToFit = YES;
        self.opaque = NO; //解决底部黑色背景
        self.delegate = self;
    }
    
    return self;
    

}
- (void)awakeFromNib{

    [super awakeFromNib];
    timerBool = NO;
    
    //不显示水平方向滚动条以及通过代理函数水平方向不能滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.backgroundColor = [UIColor clearColor];
    self.scalesPageToFit = YES;
    self.opaque = NO; //解决底部黑色背景
    self.delegate = self;


}

- (EBTGradientProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[EBTGradientProgressView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, self.bounds.size.width, KWebViewProgressViewHeight)];
    }
    return _progressView;

}


-(void)timerAction {
    if (timerBool) {
        if (self.progressView.progressValue >= 1) {
            
            [myTimer invalidate];
            myTimer = nil;
            [self.progressView stopAnimating];
        }
        else {
            self.progressView.progressValue += 0.1;
            [self.progressView startAnimating];
        }
    }
    else {
        self.progressView.progressValue += 0.05;
        //此段代码可有无
//        if (self.progressView.progressValue >= 0.99) {
//            self.progressView.progressValue = 0.99;
//        }
        [self.progressView startAnimating];
    }
    
}


#pragma mark - //获取webview所在的导航控制器

- (UINavigationController *)webviewWithNavigationController
{

    for (UIView *next=[self superview]; next; next=next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController*)nextResponder;
        }
        
    }
    
    return nil;
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSAssert([self webviewWithNavigationController], @"必须为webview添加UINavigationController导航控制器");
    [[self webviewWithNavigationController].navigationBar addSubview:self.progressView];
    self.progressView.progressValue = 0.f;
    timerBool = NO;
    //每秒渲染60次
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    timerBool = YES;
   // [self.progressView stopAnimating];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     timerBool = YES;
   // [self.progressView stopAnimating];

}

#pragma mark - UIScorllerViewDelegate
//防止webview左右滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (point.x>0) {
        scrollView.contentOffset = CGPointMake(0, point.y);
    }
}



@end
