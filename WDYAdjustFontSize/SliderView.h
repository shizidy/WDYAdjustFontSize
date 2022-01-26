//
//  SliderView.h
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SliderValueCallBack)(UISlider *);

@interface SliderView : UIView
/// 初始化方法
/// @param frame frame
/// @param callBack 回调block
- (instancetype)initWithFrame:(CGRect)frame callBack:(SliderValueCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
