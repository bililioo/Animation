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

@property (nonatomic, strong) UIView *clockView;

@property (nonatomic, strong) UIView *hourView;

@property (nonatomic, strong) UIView *minView;

@property (nonatomic, strong) UIView *secView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _height = self.view.frame.size.height;
    _width = self.view.frame.size.width;
    _image = [UIImage imageNamed:@"4.16.png"];
    
    self.view.backgroundColor = [UIColor grayColor];
    
//    [self initClockView];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    UIView *imageView = [[UIView alloc] init];
    imageView.frame = CGRectMake(0, 0, 150, 100);
    imageView.center = self.view.center;
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    
    imageView.layer.shadowOpacity = 0.5f;
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, imageView.bounds);
    imageView.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
}

- (void)makeShadow
{
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = [UIColor whiteColor];
    borderView.frame = CGRectMake(0, 0, 100, 100);
    borderView.center = self.view.center;
    borderView.layer.cornerRadius = 5;
    borderView.layer.borderWidth = 2;
    borderView.layer.borderColor = [UIColor yellowColor].CGColor;
    [self.view addSubview:borderView];
    
    borderView.layer.shadowOpacity = 0.5f;
    borderView.layer.shadowOffset = CGSizeMake(0, 20);
    borderView.layer.shadowRadius = 5;
    borderView.layer.shadowColor = [UIColor redColor].CGColor;
}

- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.hourView.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minView.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secView.transform = CGAffineTransformMakeRotation(secsAngle);
}

/**
 *  时钟图片
 */
- (void)initClockView
{
    _clockView = [[UIView alloc] init];
    _clockView.frame = CGRectMake(0, 0, 200, 200);
    _clockView.layer.contentsGravity = kCAGravityCenter;
    _clockView.center = self.view.center;
    [self.view addSubview:_clockView];
    
    _hourView = [[UIView alloc] init];
    _hourView.frame = CGRectMake(0, 0, 90, 90);
    _hourView.layer.contentsGravity = kCAGravityCenter;
    _hourView.center = self.view.center;
    [self.view addSubview:_hourView];
    
    _minView = [[UIView alloc] init];
    _minView.frame = CGRectMake(0, 0, 90, 90);
    _minView.layer.contentsGravity = kCAGravityCenter;
    _minView.center = self.view.center;
    [self.view addSubview:_minView];
    
    _secView = [[UIView alloc] init];
    _secView.frame = CGRectMake(0, 0, 90, 90);
    _secView.layer.contentsGravity = kCAGravityCenter;
    _secView.center = self.view.center;
    [self.view addSubview:_secView];
    
    [self addSpriteImage:self.image ContentRect:CGRectMake(0, 0, 0.5, 1) toLayer:self.clockView.layer];
    
    [self addSpriteImage:self.image ContentRect:CGRectMake(0.53, 0, 0.16, 1) toLayer:self.minView.layer];
    
    [self addSpriteImage:self.image ContentRect:CGRectMake(0.69, 0, 0.16, 1) toLayer:self.hourView.layer];
    
    [self addSpriteImage:self.image ContentRect:CGRectMake(0.85, 0, 0.16, 1) toLayer:self.secView.layer];
    
    self.secView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.hourView.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    // 把clock图层放到最上面
//    self.clockView.layer.zPosition = 1.0f;
    
    self.clockView.layer.cornerRadius = 10;
    self.clockView.layer.borderWidth = 2;
    self.clockView.layer.borderColor = [UIColor redColor].CGColor;
    self.clockView.layer.masksToBounds = YES;
}

/**
 *  绘画layer
 */
- (void)function2
{
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(0, 0, 100, 100);
    blueLayer.position = self.view.center;
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:blueLayer];
    
    // 让blueLayer实现下面的代理方法
    [blueLayer display];
}

/**
 *  绘画
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 10.f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
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
    [self.view.layer addSublayer:mainLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
