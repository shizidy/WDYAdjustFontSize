//
//  SliderView.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import "SliderView.h"

#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kScreenHeight UIScreen.mainScreen.bounds.size.height
#define SliderRate 1.0
#define DefaultFontSize 16
#define SliderHeight 10
#define SliderBGWidth 300
#define SliderWidth 330

@interface SliderView ()
/// slider
@property (nonatomic, strong) UISlider *slider;
/// tap手势
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
/// slider控件value回调
@property (nonatomic, copy) SliderValueCallBack callBack;
/// @{@"字体size": @"slider value"}  字体size对应slider value
@property (nonatomic, strong) NSDictionary *unitDict;
@property (nonatomic, strong) NSArray *unitArr;
@end

@implementation SliderView

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame callBack:(SliderValueCallBack)callBack {
    self = [super initWithFrame:frame];
    if (self) {
        self.callBack = callBack;
        
        UIImageView *sliderBgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_detail_sliderBgImg"]];
        [self addSubview:sliderBgImgView];
        sliderBgImgView.frame = CGRectMake(frame.size.width / 2 - SliderBGWidth / 2, 5, SliderBGWidth, SliderHeight);
        
        self.slider = [[UISlider alloc] init];
        self.slider.minimumValue = 1;
        self.slider.maximumValue = 4;
        self.slider.minimumTrackTintColor = [UIColor clearColor];
        self.slider.maximumTrackTintColor = [UIColor clearColor];
        self.slider.multipleTouchEnabled = NO;
        [self.slider setThumbImage:[UIImage imageNamed:@"icon_detail_slider_thum"] forState:UIControlStateNormal];
        [self addSubview:self.slider];
        self.slider.frame = CGRectMake(0, 0, SliderWidth, SliderHeight);
        self.slider.center = sliderBgImgView.center;
        [self.slider addTarget:self
                    action:@selector(valueChanged:)
          forControlEvents:UIControlEventValueChanged];
        [self.slider addTarget:self
                    action:@selector(sliderTouchDown:)
          forControlEvents:UIControlEventTouchDown];
        [self.slider addTarget:self
                    action:@selector(sliderTouchUp:)
          forControlEvents:UIControlEventTouchUpInside];
        // 字体size值为该字典key slider value值为该字典value
        self.unitDict = @{
            @"16": @"1",
            @"18": @"2",
            @"20": @"3",
            @"22": @"4"
        };
        
        self.unitArr = @[
            @"16",
            @"18",
            @"20",
            @"22"
        ];
        
        [self.slider setValue:[self sliderInitialValue]];
        
        for (int i = 0; i < self.unitArr.count; i++) {
            CGFloat ptx = (kScreenWidth - SliderBGWidth) / 2 + (SliderBGWidth / 3) * i;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
            label.center = CGPointMake(ptx, self.slider.center.y + 25);
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.unitArr[i];
            label.backgroundColor = UIColor.redColor;
            [self addSubview:label];
        }
        self.backgroundColor = UIColor.orangeColor;
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:self.tapGesture];
    }
    return self;
}

- (CGFloat)sliderInitialValue {
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"fontSizeDict"]];
    __block NSString *value = nil;
    if (mdict) {
        [mdict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@"1"]) {
                value = self.unitDict[key];
            }
        }];
    }
    return value ? value.floatValue : 1;
}

#pragma mark - 滑动slider修改
- (void)valueChanged:(UISlider *)sender {
    // 只取整数值，固定间距
    NSString *tempStr = [self numberFormat:sender.value];
    if (tempStr.floatValue == sender.value) {
        return;
    }
    [sender setValue:tempStr.integerValue];
    // 调用block
    self.callBack(self.slider);
}

#pragma mark - Slider Action
- (void)sliderTouchDown:(UISlider *)sender {
    self.tapGesture.enabled = NO;
}

- (void)sliderTouchUp:(UISlider *)sender {
    self.tapGesture.enabled = YES;
}

#pragma mark - 手势点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    CGFloat margin = kScreenWidth / 2 - SliderBGWidth / 2;
    CGFloat unitWidth = SliderWidth / 3;
    CGFloat res = (point.x - margin) / unitWidth;
    [self.slider setValue:[self numberFormat:res].floatValue + 1];
    // 调用block
    self.callBack(self.slider);
//    CGFloat rate = res - [self numberFormat:res].floatValue;
}

#pragma mark - numberFormat
- (NSString *)numberFormat:(float)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
