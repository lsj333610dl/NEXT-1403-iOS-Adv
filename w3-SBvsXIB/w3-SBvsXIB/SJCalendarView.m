//
//  SJCalendarView.m
//  play
//
//  Created by 상진 이 on 2014. 7. 13..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import "SJCalendarView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_BORDER [UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1.0f]
#define COLOR_BAR_BG [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]
#define COLOR_BLACK [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f]
#define COLOR_BLUE [UIColor colorWithRed:150/255.0f green:209/255.0f blue:241/255.0f alpha:1.0f]
#define COLOR_RED [UIColor colorWithRed:229/255.0f green:145/255.0f blue:149/255.0f alpha:1.0f]

#define IS_EMPTY_TAG 0
#define ONE_TICKET_TAG 1


@implementation SJCalendarView{
//    UIScrollView *_scrollView;
}

@synthesize curYear;
@synthesize curMonth;



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        arrayDayBtn = [[NSMutableArray alloc]init];
        arrayLastDayOfMonth = @[@0, @31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31];
    }
    return self;
}


-(void)drawCalendarWithYear:(NSInteger)year andMonth:(NSInteger)month
{

    curYear = year;
    curMonth = month;


    //day 사이즈 설정
    double heightDay = self.frame.size.height/6, widthDay = self.frame.size.width/7;

    NSInteger day = 1;

    //이전 달력 지워버림
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [arrayDayBtn removeAllObjects];

    //입력 받은 달의 마지막 날짜
    NSInteger lastDay = (NSInteger)[arrayLastDayOfMonth[(NSUInteger) month] integerValue];

    //윤년 계산, 2월이고, year가 400으로 나누어 떨어지거나 4로 나누어 떨어지고 100으로 나누어 떨어지지 않음
    if ( (month==2) && (!(year % 400) || ((year%100) && !(year%4)) ) ){
        NSLog(@"윤년");
        lastDay=29;
    }

    //month의 시작 요일 구함, 0=일요일 6=토요일
    NSInteger weekIndex = [self weekIndexOfYear:year andMonth:month];

    for (NSInteger row=1; row<7; row++) {
        for (NSInteger col=0; col<7; col++) {

            CGRect btnFrame;
            btnFrame = CGRectMake((CGFloat) (widthDay*col), (CGFloat) (heightDay*(row-1)), (CGFloat) widthDay, (CGFloat) heightDay);


            CALayer *borderBottom = [CALayer layer];
            [borderBottom setBackgroundColor:COLOR_BORDER.CGColor];
            [borderBottom setFrame:CGRectMake(0, btnFrame.size.height, btnFrame.size.width, 1)];


            if ( (row==1 && col<weekIndex) || (day>lastDay)) {
                UILabel *labelMargin = [[UILabel alloc]initWithFrame:btnFrame];
                [self addSubview:labelMargin];
                continue;
            }
            UIButton *dayButton = [[UIButton alloc]initWithFrame:btnFrame];

            [dayButton.titleLabel setFont:[UIFont fontWithName:@"NotoSansKR-Light" size:17.0f]];
            
            [dayButton setTitle:[NSString stringWithFormat:@"%zd",day] forState:UIControlStateNormal];
            [dayButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

            if (col==0) {
                [dayButton setTitleColor:COLOR_RED forState:UIControlStateNormal];
            }

            else if (col==6) {

                [dayButton setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
            }

            else {
                [dayButton setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
            }

            day++;

            [arrayDayBtn addObject:dayButton];
            [self addSubview:dayButton];

        }
    }


    [self selectToday];

}


#pragma mark -
#pragma mark 버튼 액션
- (void)btnAction:(UIButton*)button{

    if (button.tag == IS_EMPTY_TAG) {
        [self showActionSheet:[arrayDayBtn indexOfObject:button]+1];
    }
    else if (button.tag == ONE_TICKET_TAG){
        [self showDetailView:button];
    }
    else {
        //todo 2개이상일때 처리하기
        NSArray *tickets = [button.layer valueForKey:[NSString stringWithFormat:@"tickets"]];
        [self showTicketScrollView:tickets];
    }
}

- (void)showTicketScrollView:(NSArray *)tickets {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowTicketSelectView" object:nil userInfo:@{@"tickets": tickets}];
}


- (void)showDetailView:(UIButton*)button{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowAddVC" object:nil userInfo:@{@"ticket": [button.layer valueForKey:@"tickets"][0]}];
}



- (void)showActionSheet:(NSUInteger)day{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowActionSheet" object:nil userInfo:@{@"day": @(day)}];
}


- (NSInteger)weekIndexOfYear:(NSInteger)year andMonth:(NSInteger)month{

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:1];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];

    return [weekdayComponents weekday] - 1;
}



- (void)preMonthFrom:(SJCalendarView *)mainCalendar{
    if (mainCalendar.curMonth==1) {
        [self drawCalendarWithYear:mainCalendar.curYear-1 andMonth:12];
    }
    else {
        [self drawCalendarWithYear:mainCalendar.curYear andMonth:mainCalendar.curMonth-1];
    }
}

- (void)nextMonthFrom:(SJCalendarView *)mainCalendar{



    if (mainCalendar.curMonth==12) {
        [self drawCalendarWithYear:mainCalendar.curYear+1 andMonth:1];
    }
    else {
        [self drawCalendarWithYear:mainCalendar.curYear andMonth:mainCalendar.curMonth+1];
    }

}

- (void)selectToday{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    if (curMonth==[components month] && curYear==[components year]) {
        [arrayDayBtn[(NSUInteger) ([components day] - 1)] setBackgroundColor:UIColorFromRGB(0xE74C3C)];
        [arrayDayBtn[(NSUInteger) ([components day] - 1)] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}



@end
