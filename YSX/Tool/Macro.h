//
//  Macro.h
//  阅书轩
//
//  Created by Lib on 2017/2/4.
//  Copyright © 2017年 adirects. All rights reserved.
//

/// 屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/// 屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


/// 版本号
#define BUNDLE_ID [[NSBundle mainBundle] objectForInfoDictionaryKey:"CFBundleShortVersionString"]

/// RGBA颜色
#define RGBA_COLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/// 随机颜色
#define RANDOM_COLOR RGBA_COLOR(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)

/// weakSelf
#define WEAK_SELF(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
/// strongSelf
#define STRONG_SELF(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

/// 归档到沙盒
#define CACHE_FILE [NSString stringWithFormat:@"%@.data", NSStringFromClass([self class])]

/// 自定义日志输入(NSLog)
#ifdef DEBUG
#define LibLog(s, ... ) NSLog( @"[%@ in line %d]=> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LibLog(s, ... )
#endif

/// 单例.h
#define SINGLETON_H(name) + (instancetype)shared##name;
/// 单例.m
#define SINGLETON_M(name)\
static id _instance;\
\
+ (instancetype)shared##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[super alloc] init];\
});\
return _instance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}
