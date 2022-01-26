//
//  UIFont+Extension.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/22.
//

#import "UIFont+Extension.h"
#import <objc/runtime.h>
#import "SwapMethodManager.h"

@implementation UIFont (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SwapMethodManager swapMethodInClass:object_getClass(self) originalMethod:@selector(systemFontOfSize:) swizzledMethod:@selector(hooked_systemFontOfSize:)];
    });
}

+ (UIFont *)hooked_systemFontOfSize:(CGFloat)fontSize {
    NSMutableDictionary *mdict = [[NSUserDefaults standardUserDefaults] objectForKey:@"fontSizeDict"];
    for (int i = 0; i < mdict.allKeys.count; i++) {
        NSString *key = mdict.allKeys[i];
        NSString *value = mdict[key];
        if ([value isEqualToString:@"1"]) {
            return [self hooked_systemFontOfSize:key.floatValue];
        }
    }
    return [self hooked_systemFontOfSize:fontSize];
}

@end
