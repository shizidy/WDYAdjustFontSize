//
//  ControlManager.m
//  WDYAdjustFontSize
//
//  Created by wdyzmx on 2022/1/19.
//

#import "ControlManager.h"
#import "FontManager.h"

@interface ControlManager ()
/// 保存控件
@property (nonatomic, strong) NSMutableDictionary *mdict;
@end

@implementation ControlManager

#pragma mark - 单例
static dispatch_once_t onceToken;
static ControlManager *manager = nil;

+ (instancetype)shareInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

//- (id)copyWithZone:(NSZone *)zone {
//    return manager;
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone {
//    return manager;
//}

#pragma mark - 添加
- (void)addControl:(UIView *)control {
    NSString *hashStr = [NSString stringWithFormat:@"%ld", control.hash];
    if (![self.mdict.allKeys containsObject:hashStr]) {
        self.mdict[hashStr] = control;
    }
}

- (void)deleteControl:(UIView *)control {
    NSString *hashStr = [NSString stringWithFormat:@"%ld", control.hash];
    if ([self.mdict.allKeys containsObject:hashStr]) {
        [self.mdict removeObjectForKey:hashStr];
    }
}
                                    
- (void)updateControlsFont:(CGFloat)fontSize {
    // 更新本地存储
    [FontManager fontOfSize:fontSize];
    // 跟新控件字体
    if (!self.mdict.count) {
        return;
    }
    [self.mdict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:UILabel.class]) {
            UILabel *lb = obj;
            lb.font = [UIFont systemFontOfSize:fontSize];
            CGSize size = [lb sizeThatFits:CGSizeMake(lb.frame.size.width, .1)];
            lb.frame = CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, size.height);
        }
        if ([obj isMemberOfClass:UIButton.class]) {
            UIButton *btn = obj;
            btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
    }];
}

- (NSMutableDictionary *)mdict {
    if (!_mdict) {
        _mdict = [NSMutableDictionary dictionary];
    }
    return _mdict;
}

@end
