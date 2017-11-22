//
//  ViewController.m
//  TextHealthKit
//
//  Created by four on 16/8/22.
//  Copyright © 2016年 four. All rights reserved.
//

#import "ViewController.h"

#import "HealthManager.h"


@interface ViewController ()
//{
//    HKHealthStore *healthStore;
//    NSString *cuttentDate;
//    int stepTotal;
//}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
//    [self text];
//    
//    [self get];
//    
//    stepTotal = 0;
//    
//    cuttentDate = [self getCurrentDateString];
    [[HealthManager shareInstance] getKilocalorieUnit:[HealthManager predicateForSamplesToday] quantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned] completionHandler:^(double value, NSError *error) {
        if(error)
        {
            NSLog(@"error = %@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
        }
        else
        {
            NSLog(@"当天消耗卡路里＝ %.2lf卡",value);
        }
    }];
    
    [[HealthManager shareInstance] getRealTimeStepCountCompletionHandler:^(double value, NSError *error) {
        
        NSLog(@"当天行走步数 = %.0lf步",value);
    }];
    
    [[HealthManager shareInstance] getRealTimeDistanceCompletionHandler:^(double value, NSError *error) {
        
        NSLog(@"当天行走距离 = %.02lf公里",value/1000.0);
    }];

}
///**
// *  检测设备
// */
//- (void)text{
//    BOOL isHealthDataAvailable =  [HKHealthStore isHealthDataAvailable];
//    if (isHealthDataAvailable == NO) {
//        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"该设备不支持健康" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [view show];
//        return;
//    }
//}
///**
// *  授权
// */
//- (void)get{
//    healthStore = [[HKHealthStore alloc] init];
//    NSSet *readObjectTypes = [NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],nil];
//    [healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError *error) {
//        if (success == YES)  {
//            //授权成功
//            NSLog(@"授权成功");
//            [self getStep];
//        } else {
//            //授权失败
//            NSLog(@"授权失败");
//        }
//    }];
//}
//
///**
// *  获取步行数
// */
//- (void)getStep{
//    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
//    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
//        if(!error && results) {
//            for(HKQuantitySample *samples in results) {
//                NSLog(@"%@ 至 %@ : %@", samples.startDate, samples.endDate, samples.quantity);
//                NSString *dateStr = [[NSString stringWithFormat:@"%@",samples.startDate] substringToIndex:10];
//                if ([dateStr isEqualToString:cuttentDate]) {
//                    NSString *stepCount = [NSString stringWithFormat:@"%@",samples.quantity];
//                    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//                    int remainSecond =[[stepCount stringByTrimmingCharactersInSet:nonDigits] intValue];
//                    NSLog(@" num %d ",remainSecond);
//                    stepTotal += remainSecond;
//                }
//                NSLog(@"总的数量%d",stepTotal);
//            }
//        } else {
//            //error
//        }
//    }];
//    [healthStore executeQuery:sampleQuery];
//}
//
//- (NSString *) getCurrentDateString {
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    
//    NSString *strTime = [formatter stringFromDate:date];
//    
//    return strTime;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
