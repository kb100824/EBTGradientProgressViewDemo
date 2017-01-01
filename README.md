
#通过两种方法为webview添加渐变进度条

#首先把文件夹名称“EBTGradientProgressView”里面的四个文件添加到项目中。

#方法1: 直接引用EBTGradientProgressView这个类库来实现

@property(nonatomic,assign) CGFloat progressValue;

- (void)startAnimating;

- (void)stopAnimating;

#方法2:
 直接引用用EBTWebViewWithGradientProgressView这个类库来实现，XIB或者SB的话需要将Webview的Class设置为"EBTWebViewWithGradientProgressView"就可以。

#以上两种方法具体实现过程请看项目中的Demo

#效果演示图
![Image](https://github.com/KBvsMJ/EBTGradientProgressViewDemo/blob/master/demogif/1.gif)
