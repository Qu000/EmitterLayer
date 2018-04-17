//
//  ViewController.m
//  emitterLayer
//
//  Created by qujiahong on 2018/4/17.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

/** 粒子动画 */
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;

@end

@implementation ViewController


-(CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        //发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(ScreenWidth-50, ScreenHeight-50);
        //发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 开启三维效果
        // _emitterLayer.preservesDepth = YES;
        
        NSMutableArray *array = [NSMutableArray array];
        
        //创建粒子
        for (NSInteger i=0; i<10; i++) {
            //发射单元
            CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
            //粒子的创建速率，默认为1/s
            emitterCell.birthRate = 1;
            //粒子的存活时间
            emitterCell.lifetime = arc4random_uniform(3) + 1;
            //粒子的生存时间 容差
            emitterCell.lifetimeRange = 1.5;
            //颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            //此处，可用图标
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%ld_30x30", (long)i]];
            //粒子显示的内容
            emitterCell.contents = (id)[image CGImage];
            //粒子的运动速度
            emitterCell.velocity = arc4random_uniform(100) + 50;
            //粒子的速度容差
            emitterCell.velocityRange = 50;
            //粒子在xy平面的发射角度
            emitterCell.emissionLongitude = M_PI + M_PI_2;
            //粒子发射角度的容差
            emitterCell.emissionRange = M_PI_2/6;
            //缩放比例
            emitterCell.scale = 0.3;
            [array addObject:emitterCell];
        }
        emitterLayer.emitterCells = array;
        [self.view.layer addSublayer:emitterLayer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}
- (void)setupUI{
    
    [self setStartBtn];
    
    [self setStopBtn];

}
- (void)setStartBtn{
    UIButton *stopBtn = [[UIButton alloc]init];
    [stopBtn setTitle:@"开启粒子动画" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:[UIColor blackColor]];
    [stopBtn addTarget:self action:@selector(clickStartBtn) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.frame = CGRectMake(50, 50, 150, 30);
    [self.view addSubview:stopBtn];
}
- (void)setStopBtn{
    UIButton *stopBtn = [[UIButton alloc]init];
    [stopBtn setTitle:@"关闭粒子动画" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:[UIColor blackColor]];
    [stopBtn addTarget:self action:@selector(clickStopBtn) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.frame = CGRectMake(ScreenWidth - 50 - 150, 50, 150, 30);
    [self.view addSubview:stopBtn];
}

- (void)clickStartBtn{
    //开始来访动画
    [self.emitterLayer setHidden:NO];
}
- (void)clickStopBtn{
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
}

@end
