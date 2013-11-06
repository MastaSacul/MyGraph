//
//  ViewController.m
//  MyGraph
//
//  Created by Lucas Rosenblatt on 9/30/13.
//  Copyright (c) 2013 Lucas Rosenblatt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//Start
@synthesize sliderValueTxt;
-(IBAction)SliderValue:(id)sender
{
    sliderValueTxt .text= [[NSString alloc] initWithFormat:@"%d ", (int)sliderValue.value];
}
//End

- (void)viewDidLoad
{
    [super viewDidLoad];
    scroller.contentSize = CGSizeMake(kDefaultGraphWidth, kGraphHeight);
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    NSLog(@"Position of touch: %.3f, %.3f", pos.x, pos.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
