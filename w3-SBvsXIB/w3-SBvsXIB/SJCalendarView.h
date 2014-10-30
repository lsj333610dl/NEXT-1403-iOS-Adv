//
//  SJCalendarView.h
//  play
//
//  Created by 상진 이 on 2014. 7. 13..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJCalendarView : UIView{
    NSArray *arrayLastDayOfMonth;
    NSMutableArray *arrayDayBtn;
}

@property (nonatomic,assign) NSInteger curYear;
@property (nonatomic,assign) NSInteger curMonth;

- (id)initWithFrame:(CGRect)frame;

-(void)drawCalendarWithYear:(NSInteger)year andMonth:(NSInteger)month; // 달력을 그려주는 함수

- (void)preMonthFrom:(SJCalendarView *)mainCalendar;

- (void)nextMonthFrom:(SJCalendarView *)mainCalendar;

@end
