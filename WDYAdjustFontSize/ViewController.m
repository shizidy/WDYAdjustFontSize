//
//  ViewController.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import "ViewController.h"
#import "ControlManager.h"
#import "HomeViewController.h"
#import "UILabel+Extension.h"
#import "SliderView.h"
#import "UIFont+Extension.h"
#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kScreenHeight UIScreen.mainScreen.bounds.size.height
#define SliderRate 1.0
#define DefaultFontSize 16

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 0)];
    [self.view addSubview:label];
    label.text = @"安分公司辅导班你设的风控部 是大法官的不规范表达式更方便的发给你水电费搞不懂发给你的分工包水电费白癜风";
    label.font = [UIFont systemFontOfSize:DefaultFontSize];
    label.textColor = UIColor.whiteColor;
    label.backgroundColor = UIColor.redColor;
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(kScreenWidth - 100, 10)];
    label.frame = CGRectMake(50, 100, kScreenWidth - 100, size.height);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, kScreenWidth - 100, 50)];
    [self.view addSubview:btn];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.redColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:DefaultFontSize];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    SliderView *sliderView = [[SliderView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth, 50) callBack:^(UISlider * _Nonnull sender) {
        // 更新字体大小
        CGFloat fontSize = ((sender.value - sender.minimumValue) / SliderRate) * 2 + DefaultFontSize;
        [ControlManager.shareInstance updateControlsFont:fontSize];
    }];
    [self.view addSubview:sliderView];
    
    // Do any additional setup after loading the view.
}

- (void)btnAction:(UIButton *)btn {
    HomeViewController *viewController = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - numberFormat
- (NSString *)numberFormat:(float)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

@end
