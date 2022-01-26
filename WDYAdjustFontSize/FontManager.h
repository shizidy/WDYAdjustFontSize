//
//  FontManager.h
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontManager : NSObject
/// 设置字体大小
/// @param fontSize fontSize
+ (void)fontOfSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
