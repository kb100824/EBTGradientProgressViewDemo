//
//  SecondViewController.m
//  EBTGradientProgressViewDemo
//
//  Created by MJ on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//



//ps:直接继承webview实现添加进度条
#import "SecondViewController.h"
#import "EBTWebViewWithGradientProgressView.h"
@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet EBTWebViewWithGradientProgressView *webView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadBtn:(UIButton *)sender {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://gold.xitu.io/"]]];
    
    [self.webView reload];
}
- (IBAction)btnBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
