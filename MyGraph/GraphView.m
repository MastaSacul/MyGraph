//
//  GraphView.m
//  MyGraph
//
//  Created by Lucas Rosenblatt on 9/30/13.
//  Copyright (c) 2013 Lucas Rosenblatt. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

float data[] = {244, 230, 130, 76, 450, 321, 134, 245, 32, 56, 54, 98, 245, 345, 244, 200, 13, 76, 400, 321, 134, 245, 32, 56, 54, 98, 245, 345};
//244, 230, 13, 76, 400, 321, 134, 245, 32, 56, 54, 98, 245, 345
//244, 2300, 13, 76, 400, 321, 134, 245, 32, 56, 54, 98, 245, 345
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
- (void)drawBar:(CGRect)rect context:(CGContextRef)ctx
{
     Prepare the resources
    CGFloat components[12] = {0.2314, 0.5686, 0.4, 1.0,  // Start color
        0.4727, 1.0, 0.8157, 1.0, // Second color
        0.2392, 0.5686, 0.4118, 1.0}; // End color
    CGFloat locations[3] = {0.0, 0.33, 1.0};
    size_t num_locations = 3;
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
     
    
    // Create and apply the clipping path
    CGContextBeginPath(ctx);
    CGContextSetGrayFillColor(ctx, 0.2, 0.7);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    
     Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
    
    // Release the resources
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
     
}

- (void)drawLineGraphWithContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    int maxGraphHeight = kGraphHeight - kOffsetY;
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);
    
    for (int i = 1; i < sizeof(data); i++)
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);

}
*/

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    NSLog(@"Position of touch: %.3f, %.3f", pos.x, pos.y);
}


- (void)drawRect:(CGRect)rect
{
    //Data Parser :
    float smallest = data[0];
    float largest = data[0];
    float parsedData[sizeof(data)];
    for(int i = 0; i < sizeof(data); i++){
        if(data[i] <= smallest) {
            smallest = data[i];
            NSLog(@"%f", smallest);
        }
    }
    for(int i = 0; i < sizeof(data); i++){
        if(data[i] >= largest) {
            largest = data[i];
            NSLog(@"%f", largest);
        }
    }
    NSLog(@"smallest:%f", smallest);
    NSLog(@"largest:%f", largest);
    for(int i = 0; i <sizeof(data); i++) {
        parsedData[i] = data[i] / largest;
        NSLog(@"%d Point: %f",i,parsedData[i]);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
/*
    int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    
    for (int i = 0; i < howMany; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
     */
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    int maxGraphHeight = kGraphBottom - kOffsetY;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, kOffsetX, kGraphBottom - maxGraphHeight * parsedData[0]);
    
    for (int i = 1; i < sizeof(parsedData); i++)
    {
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom - maxGraphHeight * parsedData[i]);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextStrokePath(context);
    
    for (int i = 0; i < sizeof(parsedData); i++) {
        CGContextRef e = UIGraphicsGetCurrentContext();
        
        CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(e, red);
        CGContextBeginPath(e);
        CGContextMoveToPoint(e, kOffsetX + i * kStepX,kGraphBottom);
        CGContextAddLineToPoint(e, kOffsetX + i * kStepX, kGraphBottom + 5);
        CGContextStrokePath(e);
        NSString *xaxis = [NSString stringWithFormat:@"%d",i];
        [xaxis drawAtPoint:CGPointMake(kOffsetX + i * kStepX, kGraphBottom + 10) withFont:[UIFont boldSystemFontOfSize:16.0]];
    }
    
    for (int i = 0; i <= yAxisPoints; i++) {
        CGContextRef y = UIGraphicsGetCurrentContext();
        
        CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(y, red);
        CGContextBeginPath(y);
        CGContextMoveToPoint(y, 50,kGraphBottom - i * ((kGraphBottom - distanceFromTop)/yAxisPoints));
        CGContextAddLineToPoint(y, 45, kGraphBottom - i * ((kGraphBottom - distanceFromTop)/yAxisPoints));
        CGContextStrokePath(y);
        float beforeInt = (largest/yAxisPoints) * i;
        int afterInt = (int) beforeInt;
        NSString *yaxis = [NSString stringWithFormat:@"%d",afterInt];
        [yaxis drawAtPoint:CGPointMake(10, kGraphBottom - i * ((kGraphBottom - distanceFromTop)/yAxisPoints) - (.5 * ((kGraphBottom - distanceFromTop)/yAxisPoints))) withFont:[UIFont boldSystemFontOfSize:16.0]];
    }
    
    /* Draw the bars
    float maxBarHeight = kGraphHeight - kBarTop - kOffsetY;
    
    for (int i = 0; i < sizeof(data); i++)
    {
        float barX = kOffsetX + kStepX + i * kStepX - kBarWidth / 2;
        float barY = kBarTop + maxBarHeight - maxBarHeight * data[i];
        float barHeight = maxBarHeight * data[i];
        
        CGRect barRect = CGRectMake(barX, barY, kBarWidth, barHeight);
        [self drawBar:barRect context:context];
    }
     */
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
    CGContextSetStrokeColor(c, red);
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, distanceFromSide,distanceFromTop);
    CGContextAddLineToPoint(c, distanceFromSide, kGraphBottom);
    CGContextStrokePath(c);
    
    CGContextRef d = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColor(d, red);
    CGContextBeginPath(d);
    CGContextMoveToPoint(d, distanceFromSide,kGraphBottom);
    CGContextAddLineToPoint(d, lengthOfGraph, kGraphBottom);
    CGContextStrokePath(d);
    /*
    NSString *max = [NSString stringWithFormat:@"%d",largest];
    NSString *half = [NSString stringWithFormat:@"%d",largest / 2];
    NSString *min = [NSString stringWithFormat:@"%d",largest * 0];
    [max drawAtPoint:CGPointMake(20, 50) withFont:[UIFont boldSystemFontOfSize:16.0]];
    [half drawAtPoint:CGPointMake(20, 180) withFont:[UIFont boldSystemFontOfSize:16.0]];
    [min drawAtPoint:CGPointMake(40, 320) withFont:[UIFont boldSystemFontOfSize:16.0]];
     */
}


@end
