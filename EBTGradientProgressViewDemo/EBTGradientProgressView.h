//
//  EBTGradientProgressView.h
//  EBTGradientProgressViewDemo
//
//  Created by ebaotong on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBTGradientProgressView : UIView

///进度值
@property(nonatomic,assign) CGFloat progressValue;
///开始动画
- (void)startAnimating;
///停止动画
- (void)stopAnimating;


@end
