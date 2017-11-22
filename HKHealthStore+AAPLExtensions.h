//
//  HKHealthStore+AAPLExtensions.h
//  TextHealthKit
//
//  Created by four on 16/8/22.
//  Copyright © 2016年 four. All rights reserved.
//

#import <HealthKit/HealthKit.h>

@interface HKHealthStore (AAPLExtensions)

- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;


@end
