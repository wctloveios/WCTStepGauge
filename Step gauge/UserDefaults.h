//
//  UserDefault.h
//  WilsonProject
//
//  Created by Wilson on 16/1/11.
//  Copyright © 2016年 Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject {
    NSUserDefaults *userDefaults;
}

+ (UserDefaults *) shareUserDefaults;

// 设置值
- (void) setUserDefaultValues:(NSString* )value forKey:(NSString *)key;

// 获取值
- (NSString *) getUserDefaultValuesWithKey:(NSString *)key;


@end
