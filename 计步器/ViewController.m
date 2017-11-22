//
//  ViewController.m
//  计步器
//
//  Created by four on 16/4/26.
//  Copyright © 2016年 four. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "UserDefaults.h"

@interface ViewController (){
    UserDefaults *_userDefaults;
    int _oldTime;
}
@property (strong, nonatomic) CMPedometer *pedonmeter;

@property (strong, nonatomic) UILabel *stepLabel1;
@property (strong, nonatomic) UILabel *stepLabel2;
@property (strong, nonatomic) UILabel *stepLabel3;
@property (strong, nonatomic) UILabel *distanceLabel1;
@property (strong, nonatomic) UILabel *distanceLabel2;
@property (strong, nonatomic) UILabel *distanceLabel3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _oldTime = 0;
    
    //连个lable显示内容
    _stepLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    _stepLabel1.backgroundColor = [UIColor redColor];
    _stepLabel1.text =[NSString stringWithFormat:@"上次走了%@步",[_userDefaults getUserDefaultValuesWithKey:@"step"]];
    [self.view addSubview:_stepLabel1];
    
    _stepLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 200, 50)];
    _stepLabel2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_stepLabel2];
    _stepLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 200, 50)];
    _stepLabel3.backgroundColor = [UIColor redColor];
    [self.view addSubview:_stepLabel3];
    
    _distanceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, 200, 50)];
    _distanceLabel1.backgroundColor = [UIColor blueColor];
    _distanceLabel1.text =[NSString stringWithFormat:@"上次走了%@米",[_userDefaults getUserDefaultValuesWithKey:@"dis"]];
    [self.view addSubview:_distanceLabel1];
    
    _distanceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 500, 200, 50)];
    _distanceLabel2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_distanceLabel2];
    _distanceLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 600, 200, 50)];
    _distanceLabel3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_distanceLabel3];
    
    _oldTime = [[_userDefaults getUserDefaultValuesWithKey:@"oldTime"] intValue];
    
    //判断是否支持记步
    if (![CMPedometer isStepCountingAvailable]) {
        //不支持
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备不支持记步" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }else{
        [self initview:_oldTime];
    }
}


-(void)initview:(int)oldTime{
    _pedonmeter = [[CMPedometer alloc] init];
    if ([CMPedometer isStepCountingAvailable]) {
        [_pedonmeter queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-24*60*60] toDate:[NSDate dateWithTimeIntervalSinceNow:[self getTime]] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error)
            {
                NSLog(@"error===%@",error);
            }
            else {
                NSLog(@"步数===%@",pedometerData.numberOfSteps);
                NSLog(@"距离===%@",pedometerData.distance);
                _stepLabel2.text = [NSString stringWithFormat:@"这次走了%@步",pedometerData.numberOfSteps];
                _distanceLabel2.text = [NSString stringWithFormat:@"这次走了%@米",pedometerData.distance];
                
//                //走了才加上之前的
//                if([pedometerData.numberOfSteps intValue]> 0)
//                {
//                    [_pedonmeter startPedometerUpdatesFromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate dateWithTimeIntervalSinceNow:[self getTime]]] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//                        if (error) {
//                            NSLog(@"更新错误 %@", error);
//                            return ;
//                        }
//                        NSLog(@"%@", pedometerData);
//                        _distanceLabel3.text = [NSString stringWithFormat:@"%@",pedometerData];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            int oldStep = [[_userDefaults getUserDefaultValuesWithKey:@"step"] intValue];
//                            int oldDis = [[_userDefaults getUserDefaultValuesWithKey:@"dis"]intValue];
//                            int newStep = [pedometerData.numberOfSteps intValue];
//                            int newDis = [pedometerData.distance intValue];
//                            
//                            NSString *newStepStr = [NSString stringWithFormat:@"%i",(newStep + oldStep)];
//                            NSString *newDisStr = [NSString stringWithFormat:@"%i",(newDis + oldDis)];
//                            
//                            _stepLabel3.text = [NSString stringWithFormat:@"当前走了%@部",newStepStr];
//                            _distanceLabel3.text = [NSString stringWithFormat:@"当前走了%@米",newDisStr];
//                        });
//                    }];
//                }
            }
        }];
    }else{
        NSLog(@"不可用===");
    }
}

//获取当前时间
- (NSString *) getCurrentDateTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

-(double)getTime{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
    return time;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
