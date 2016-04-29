//
//  ViewController.m
//  Animation
//
//  Created by chenbin on 16/4/29.
//  Copyright © 2016年 CB. All rights reserved.
//  https://zsisme.gitbooks.io/ios-/content/chapter2/the-contents-image.html

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _height = self.view.frame.size.height;
    _width = self.view.frame.size.width;
    _image = [UIImage imageNamed:@"iceMan.jpg"];
    
    self.view.backgroundColor = [UIColor grayColor];
    

}

- (void)function2
{
    
}

/**
 *  图片切割
 */
- (void)addSpriteImage:(UIImage *)image ContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    //set contentsRect
    layer.contentsRect = rect;
}

/**
 *  在View上正确的展示一张图片
 */
- (void)funcation1
{
    UIImage *image = [UIImage imageNamed:@"iceMan.jpg"];
    
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.frame = CGRectMake(0, 0, 200, 200);
    mainView.center = self.view.center;
    [self.view addSubview:mainView];
    
    mainView.layer.contents = (__bridge id)image.CGImage;
    // 两个属性效果都一样, 决定内容在图层的边间中怎么对齐
    //    mainView.contentMode = UIViewContentModeScaleAspectFit;
    mainView.layer.contentsGravity = kCAGravityCenter;
    
    // 在 Retina 屏幕显示正确大小
    //    mainView.layer.contentsScale = image.scale;
    mainView.layer.contentsScale = [UIScreen mainScreen].scale;
    mainView.layer.masksToBounds = YES;
}

- (void)initLayerWithMainView:(UIView *)mainView
{
    CALayer *mainLayer = [CALayer layer];
    mainLayer.frame = CGRectMake(50, 50, 100, 100);
    mainLayer.backgroundColor = [UIColor blueColor].CGColor;
    [mainView.layer addSublayer:mainLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
