//
//  MeetingVC.m
//  Unit
//
//  Created by Eric Tran on 10/11/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SACalendar.h"

@interface MeetingVC: UIViewController <SACalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarView;

@end

@implementation MeetingVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:self.calendarView.frame];
    
    calendar.delegate = self;
    
    [self.view addSubview:calendar];
}

// Prints out the selected date
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSLog(@"%02i/%02/%i", day, month, year);
}

// Prints out the month and year displaying on the calendar
-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
    NSLog(@"%02, %i", month, year);
}

-(BOOL)prefersStatusBarHidden { return YES; }

@end