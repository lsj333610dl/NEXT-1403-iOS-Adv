//
//  SJCalendarViewController.m
//  play
//
//  Created by 상진 이 on 2014. 7. 7..z
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import "SJCalendarViewController.h"
#import "SJCalendarView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_MAIN UIColorFromRGB(0xE74C3C)
#define COLOR_BAR_BG [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]
#define CALENDAR_WIDTH _calendarView1.frame.size.width
#define MENU_HEIGHT 180
#define TICKETALERT_IMGSIZE 240

@interface SJCalendarViewController (){
    SJCalendarView *calendarView;
}

@end

@implementation SJCalendarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];

    calendarView = [[SJCalendarView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UISwipeGestureRecognizer *rightSGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(preMonth)];
    [rightSGR setDirection:UISwipeGestureRecognizerDirectionRight];
    [calendarView addGestureRecognizer:rightSGR];
    
    
    UISwipeGestureRecognizer *leftSGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextMonth)];
    [leftSGR setDirection:UISwipeGestureRecognizerDirectionLeft];
    [calendarView addGestureRecognizer:leftSGR];
    
    
    [self.view addSubview:calendarView];
    [self drawCurCalendar];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)addBottomBorderTo:(CALayer *)layer Color:(UIColor *)color{

    CALayer *bottomLayer = [CALayer new];
    [bottomLayer setFrame:CGRectMake(0, layer.frame.size.height, layer.frame.size.width, 1)];
    [bottomLayer setBackgroundColor:color.CGColor];
    [layer addSublayer:bottomLayer];
}



- (void)drawCurCalendar{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];

    currentYear = [components year];
    currentMonth = [components month];

    [calendarView drawCalendarWithYear:currentYear andMonth:currentMonth];
    
    NSLog(@"%zd,%zd",calendarView.curYear,calendarView.curMonth);
}






- (void)preMonth {
    [calendarView preMonthFrom:calendarView];
    
    NSLog(@"%zd년 %zd월",calendarView.curYear,calendarView.curMonth);
}

- (void)nextMonth {
    [calendarView nextMonthFrom:calendarView];
    NSLog(@"%zd년 %zd월",calendarView.curYear,calendarView.curMonth);
    
}








#pragma mark - Etc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
