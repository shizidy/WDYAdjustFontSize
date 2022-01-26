//
//  SwapMethodManager.h
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwapMethodManager : NSObject
/// runtime方法交换
/// @param class 对象的类
/// @param originalSel 对象原方法
/// @param swizzledSel 对象所要交换的方法
+ (void)swapMethodInClass:(Class)class originalMethod:(SEL)originalSel swizzledMethod:(SEL)swizzledSel;
@end

NS_ASSUME_NONNULL_END
