//
//  HomeViewController.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/20.
//

#import "HomeViewController.h"
#import "FontManager.h"
#import "SliderView.h"
#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kScreenHeight UIScreen.mainScreen.bounds.size.height
#define SliderRate 1.0
#define DefaultFontSize 16

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth - 100, 0)];
    [self.view addSubview:label];
    label.text = @"安分公司辅导班你设的风控部 是大法官的不规范表达式更方便的发给你水电费搞不懂发给你的分工包水电费白癜风";
    label.font = [UIFont systemFontOfSize:DefaultFontSize];
    label.textColor = UIColor.whiteColor;
    label.backgroundColor = UIColor.redColor;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    SliderView *sliderView = [[SliderView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth, 50) callBack:^(UISlider * _Nonnull sender) {
        // 更新字体大小
        [FontManager fontOfSize:(sender.value - sender.minimumValue) / SliderRate * 2 + DefaultFontSize];
    }];
    [self.view addSubview:sliderView];
    // Do any additional setup after loading the view.
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
