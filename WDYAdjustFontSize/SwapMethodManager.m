//
//  SwapMethodManager.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import "SwapMethodManager.h"
#import <objc/runtime.h>

@implementation SwapMethodManager

+ (void)swapMethodInClass:(Class)class originalMethod:(SEL)originalSel swizzledMethod:(SEL)swizzledSel {
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    
    BOOL willAddMethod =
    class_addMethod(class,
                    originalSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (willAddMethod) {
        class_replaceMethod(class,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
