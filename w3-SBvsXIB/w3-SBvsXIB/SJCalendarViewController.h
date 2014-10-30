//
//  SJCalendarViewController.h
//  play
//
//  Created by 상진 이 on 2014. 7. 7..
//  Copyright (c) 2014년 entusapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJCalendarView;

@interface SJCalendarViewController : UIViewController{
    
    NSMutableArray *year,*month;
    UIStoryboard *MainStoryboard;
    NSInteger currentPage, currentYear, currentMonth;
    CGRect leftFrame, centerFrame, rightFrame;
    UIPickerView *yearMonthPickerView;
}
//@property (strong, nonatomic) IBOutlet UILabel *vcTitleLabel;
//@property (strong, nonatomic) IBOutlet UIButton *menuButton;

@property (strong, nonatomic) IBOutlet UIView *dayLabelView;
//@property (strong, nonatomic) IBOutlet SJCalendarView *calendarView1;
//@property (strong, nonatomic) IBOutlet SJCalendarView *calendarView2;
//@property (strong, nonatomic) IBOutlet SJCalendarView *calendarView3;
//
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong, nonatomic) IBOutlet UIView *topView;
//
//@property (strong, nonatomic) IBOutlet UIView *titleBar;
//@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
//@property (strong, nonatomic) IBOutlet UIButton *btnNextMonth;
//@property (strong, nonatomic) IBOutlet UIButton *btnPreMonth;
//@property (strong, nonatomic) IBOutlet UIView *contentsView;
//@property NSNumber *selectedDay;
//@property BOOL hideStatusBar;
//@property BOOL isShowMenu;

@end
