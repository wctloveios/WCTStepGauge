//
//  HealthManager.h
//  TextHealthKit
//
//  Created by four on 16/8/22.
//  Copyright © 2016年 four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
@interface HealthManager : NSObject


@property (nonatomic,strong) HKHealthStore *healthStore;


+(id)shareInstance;

/*!
 *  @author Lcong, 15-04-20 18:04:38
 *
 *  @brief  获取当天实时步数
 *
 *  @param handler 回调
 */
- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:38
 *
 *  @brief  获取当天实时步行+跑步距离
 *
 *  @param handler 回调
 */
- (void)getRealTimeDistanceCompletionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:34
 *
 *  @brief  获取一定时间段步数
 *
 *  @param predicate 时间段
 *  @param handler   回调
 */
- (void)getStepCount:(NSPredicate *)predicate completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:34
 *
 *  @brief  获取一定时间段跑步+步行距离
 *
 *  @param predicate 时间段
 *  @param handler   回调
 */
- (void)getDistance:(NSPredicate *)predicate completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:32
 *
 *  @brief  获取卡路里
 *
 *  @param predicate    时间段
 *  @param quantityType 样本类型
 *  @param handler      回调
 */
- (void)getKilocalorieUnit:(NSPredicate *)predicate quantityType:(HKQuantityType*)quantityType completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @author Lcong, 15-04-20 18:04:17
 *
 *  @brief  当天时间段
 *
 *  @return ,,,
 */
+ (NSPredicate *)predicateForSamplesToday;
@end
