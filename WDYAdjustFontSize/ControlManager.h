//
//  ControlManager.h
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ControlManager : NSObject
/// 单例
+ (instancetype)shareInstance;
/// 添加控件
/// @param control 控件
- (void)addControl:(UIView *)control;
/// 删除控件
/// @param control 控件
- (void)deleteControl:(UIView *)control;
/// 更新控件font
- (void)updateControlsFont:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
