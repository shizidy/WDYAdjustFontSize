//
//  UIButton+Extension.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import "UIButton+Extension.h"
#import "SwapMethodManager.h"
#import "ControlManager.h"

@implementation UIButton (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SwapMethodManager swapMethodInClass:[self class] originalMethod:@selector(didMoveToSuperview) swizzledMethod:@selector(hooked_didMoveToSuperview)];
        
        [SwapMethodManager swapMethodInClass:[self class] originalMethod:@selector(removeFromSuperview) swizzledMethod:@selector(hooked_removeFromSuperview)];
        
        [SwapMethodManager swapMethodInClass:[self class] originalMethod:@selector(setAttributedText:) swizzledMethod:@selector(hooked_setAttributedText:)];
    });
}

- (void)hooked_didMoveToSuperview {
    [self hooked_didMoveToSuperview];
    // 添加控件
    [[ControlManager shareInstance] addControl:self];
}

- (void)hooked_removeFromSuperview {
    [self hooked_removeFromSuperview];
    // 删除控件
    [[ControlManager shareInstance] deleteControl:self];
}

- (void)hooked_setAttributedText:(NSAttributedString *)attributedText {
    [self hooked_setAttributedText:attributedText];
    //
}

@end
