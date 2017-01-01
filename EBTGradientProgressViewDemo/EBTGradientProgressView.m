//
//  EBTGradientProgressView.m
//  EBTGradientProgressViewDemo
//
//  Created by ebaotong on 2016/12/16.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "EBTGradientProgressView.h"

@interface EBTGradientProgressView ()<CAAnimationDelegate>
{
    CALayer *progressViewMaskLayer;
    BOOL isAnimating;
}
@end
@implementation EBTGradientProgressView
+ (Class)layerClass
{
    return [CAGradientLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        CAGradientLayer *gradientLayer =(id)[self layer];
        gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
        NSMutableArray *colorArray = [NSMutableArray array];
        for (NSInteger i = 0; i<=120; i+=5) {
            UIColor *color = [UIColor colorWithHue:1.0*i/120.f
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
            [colorArray addObject:(id)color.CGColor];
        }
        gradientLayer.colors = [NSArray arrayWithArray:[colorArray copy]];
        progressViewMaskLayer = [CALayer layer];
        progressViewMaskLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        progressViewMaskLayer.backgroundColor = [UIColor blackColor].CGColor;
        gradientLayer.mask = progressViewMaskLayer;
    }
    
    return self;

}
- (void)awakeFromNib{
    [super awakeFromNib];
   
    CAGradientLayer *gradientLayer =(id)[self layer];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    NSMutableArray *colorArray = [NSMutableArray array];
    for (NSInteger i = 0; i<=120; i+=5) {
        UIColor *color = [UIColor colorWithHue:1.0*i/120.f
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [colorArray addObject:(id)color.CGColor];
    }
    gradientLayer.colors = [NSArray arrayWithArray:[colorArray copy]];
    progressViewMaskLayer = [CALayer layer];
    progressViewMaskLayer.frame = CGRectMake(0, 0, 0, 2);
    progressViewMaskLayer.backgroundColor = [UIColor blackColor].CGColor;
    gradientLayer.mask = progressViewMaskLayer;
}
- (void)setProgressValue:(CGFloat)progressValue{
   
    _progressValue = MIN(1.0, progressValue);
    //标记要刷新frame异步调用layoutSubviews
    [self setNeedsLayout];
   

}
- (void)layoutSubviews
{
    CGRect maskRect = progressViewMaskLayer.frame;
    maskRect.size.width = CGRectGetWidth(self.bounds)*_progressValue;
    progressViewMaskLayer.frame = maskRect;
    
    
}
//不断交替颜色
- (NSArray *)replaceColors:(NSArray *)colors {
    
    NSMutableArray *mutable = [colors mutableCopy];
    id last = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:last atIndex:0];
    return [NSArray arrayWithArray:[mutable copy]];
}
//添加colors属性动画
- (void)perfectAnimation
{
    CAGradientLayer *layer = (id)[self layer];
    NSArray *fromColors = [layer colors];
    NSArray *toColors = [self replaceColors:fromColors];
    [layer setColors:toColors];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [basicAnimation setFromValue:fromColors];
    [basicAnimation setToValue:toColors];
    [basicAnimation setDuration:0.08];
    [basicAnimation setRemovedOnCompletion:YES];
    [basicAnimation setFillMode:kCAFillModeForwards];
    [basicAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [basicAnimation setDelegate:self];
    [layer addAnimation:basicAnimation forKey:@"animationGradient"];
}
- (void)startAnimating{
    if (!isAnimating)
    {
        isAnimating = YES;
        [self perfectAnimation];
    }
}

- (void)stopAnimating{
    if (isAnimating) {
        
        isAnimating = NO;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [progressViewMaskLayer removeAnimationForKey:@"animationGradient"];
        } completion:^(BOOL finished) {
            
             [self removeFromSuperview];
        }];
        
       
    }
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    if (isAnimating) {
        
        [self perfectAnimation];
    }
}
@end
