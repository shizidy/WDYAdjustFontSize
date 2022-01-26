//
//  FontManager.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/20.
//

#import "FontManager.h"

@implementation FontManager

+ (void)fontOfSize:(CGFloat)fontSize {
    NSString *fontSizeStr = [NSString stringWithFormat:@"%.f", fontSize];
    
    NSMutableDictionary *mdict = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"fontSizeDict"]) {
        mdict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"fontSizeDict"]];
        [mdict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            mdict[key] = @"0";
        }];
    } else {
        mdict = [NSMutableDictionary dictionary];
    }
    
    mdict[fontSizeStr] = @"1";
    [[NSUserDefaults standardUserDefaults] setObject:mdict forKey:@"fontSizeDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
