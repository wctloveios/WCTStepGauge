//
//  ViewController.m
//  Step gauge
//
//  Created by four on 16/4/25.
//  Copyright © 2016年 four. All rights reserved.
//

#import "ViewController.h"
#import "UserDefaults.h"
#import <CoreMotion/CoreMotion.h>



@interface ViewController ()
{
    UILabel *lable;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 100, 30)];
    lable.backgroundColor = [UIColor redColor];
    [self.view addSubview:lable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveStepCountToUserDefault:) name:@"SACE_STEPCOUNT_TO_USERDEFAULT" object:nil];
}

-(void)saveStepCountToUserDefault:(NSNotification*)step{
    
    NSLog(@"sender == %@",step.userInfo[@"step"] );
    UserDefaults *userDe = [UserDefaults shareUserDefaults];
    
    [userDe setUserDefaultValues:step.userInfo[@"step"] forKey:@"stepCount"];
    [userDe setUserDefaultValues:[self getCurrentDateTimeString] forKey:@"oldTime"];
    lable.text = step.userInfo[@"step"];
}

- (NSString *) getCurrentDateTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
