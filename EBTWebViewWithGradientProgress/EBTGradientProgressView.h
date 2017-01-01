//
//  EBTGradientProgressView.h
//  EBTGradientProgressViewDemo
//
//  Created by ebaotong on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBTGradientProgressView : UIView


@property(nonatomic,assign) CGFloat progressValue;

- (void)startAnimating;
- (void)stopAnimating;


@end
