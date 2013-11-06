//
//  ViewController.h
//  MyGraph
//
//  Created by Lucas Rosenblatt on 9/30/13.
//  Copyright (c) 2013 Lucas Rosenblatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UIScrollView *scroller;
    IBOutlet UISlider *sliderValue;
    IBOutlet UILabel *sliderValueTxt;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) UILabel *sliderValueTxt;
-(IBAction)SliderValue:(id)sender;



@end

#define kGraphHeight 320
#define kDefaultGraphWidth 900
#define kOffsetX 50
#define kStepX 50
#define kGraphBottom 320
#define kGraphTop 0
#define kStepY 50
#define kOffsetY 50
#define kBarTop 10
#define kBarWidth 40
#define kCircleRadius 3