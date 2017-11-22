//
//  AppDelegate.m
//  Step gauge
//
//  Created by four on 16/4/25.
//  Copyright © 2016年 four. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "UserDefaults.h"

@interface AppDelegate ()
{
    int _stepCount;
    CMMotionManager *_motionManger;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = navi;
    
    
    // 通知app上传步行数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataStepCount:) name:@"UPDATA_STEPCOUNT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startStepCount:) name:@"START_STEPCOUNT" object:nil];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 停止计算 通知程序把用户步行数上传
    [_motionManger stopAccelerometerUpdates];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDATA_STEPCOUNT" object:nil];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"START_STEPCOUNT" object:nil];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)startUpdateAccelerometer
{
    //step1:初始化
    _motionManger = [[CMMotionManager alloc]init];
    
    //step:2检测传感器是否可用，设置采样频率，运行方式
    if(!_motionManger.accelerometerAvailable){
        //设备故障
    }else {
        //正常
        /* 设置采样的频率，单位是秒 */
        NSTimeInterval updateInterval = 0.05; // 每秒采样20次
        _motionManger.accelerometerUpdateInterval = updateInterval;
        
        //        //开始更新，后台线程开始运行。这是pull方式。
        //        [_motionManger startAccelerometerUpdates];
        
        //开始更新，后台线程开始运行。这是push方式。
        [_motionManger startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            NSLog(@"%f---%f----%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
            
            CGFloat sqrtValue =sqrt(accelerometerData.acceleration.x*accelerometerData.acceleration.x+accelerometerData.acceleration.y*accelerometerData.acceleration.y+accelerometerData.acceleration.z*accelerometerData.acceleration.z);
            
            // 走路产生的震动率
            if (sqrtValue > 1.552188 )
            {
                //开始计步
                _stepCount += 1;
                
                NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",_stepCount],@"step", nil];
                //通知保存值
                NSNotification *noti = [NSNotification notificationWithName:@"SACE_STEPCOUNT_TO_USERDEFAULT" object:nil userInfo:dic];
                
                [[NSNotificationCenter defaultCenter] postNotification:noti];
            }
            
        }];
    }
}




#pragma mark - 进入后台上传步行数据
- (void) upDataStepCount:(NSNotification *)noti {
    
    NSLog(@"开始进入后台");
    UserDefaults *userDe = [UserDefaults shareUserDefaults];

    NSLog(@"stepCount======%@\noldtime======%@",[userDe getUserDefaultValuesWithKey:@"stepCount"],[userDe getUserDefaultValuesWithKey:@"oldTime"]);
    
    //上传数据到服务器
    
    
    
}

-(void)startStepCount:(NSNotification *)noti {
    
    _stepCount=0;
    UserDefaults *user = [UserDefaults shareUserDefaults];
    // 先判断今天有没有数据，同时满足是同一天
    if (![user getUserDefaultValuesWithKey:@"stepCount"] && [[user getUserDefaultValuesWithKey:@"oldTime"] isEqualToString:[self getCurrentDateTimeString]])
        _stepCount= 0;
    else
        _stepCount = [[user getUserDefaultValuesWithKey:@"step"] intValue];
    
    [self startUpdateAccelerometer];
}

- (NSString *) getCurrentDateTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

#pragma mark -累加步行数
@end
