//
//  ViewController.m
//  EBTGradientProgressViewDemo
//
//  Created by ebaotong on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//

//PS:直接用EBTGradientProgressView来实现进度条


#import "ViewController.h"
#import "EBTGradientProgressView.h"
@interface ViewController ()<UIWebViewDelegate>
{
    
    NSTimer *myTimer;
    BOOL timerBool; //用来控制定时器
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)EBTGradientProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    timerBool = NO;
    
   
    
    
    
   }


- (EBTGradientProgressView *)progressView{

    if (!_progressView) {
        CGRect frame = CGRectMake(0, 44.0f, CGRectGetWidth(self.view.bounds), 2.0f);
        _progressView = [[EBTGradientProgressView alloc] initWithFrame:frame];
        
    }
    return _progressView;
    
}

- (IBAction)btnStart:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://gold.xitu.io/"]]];

    [self.webView reload];
}
- (IBAction)btnStop:(UIButton *)sender {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
        if (self.progressView.progressValue >= 0.99) {
            self.progressView.progressValue = 0.99;
        }
        [self.progressView startAnimating];
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.navigationController.navigationBar addSubview:self.progressView];
    self.progressView.progressValue = 0;
    timerBool = NO;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

   timerBool = YES;
  // [self.progressView stopAnimating];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
      timerBool = YES;
}
@end
