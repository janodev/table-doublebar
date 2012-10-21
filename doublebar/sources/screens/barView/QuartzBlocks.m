
// BSD License. Author: <jano@jano.com.es>

#import "QuartzBlocks.h"

@implementation QuartzBlocks


+(drawRectBlock_t) doubleBarWithRect:(CGRect)rect {
    drawRectBlock_t drawRectBlock = ^(CGRect rect) {

        const NSInteger topBarHeight = 35;
        
        rect = CGRectIntegral(rect);
            
        // setup
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        
        // top line 1st half
        UIBezierPath* topLine1stHalf = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, rect.size.width, 1)];
        [[UIColor whiteColor] setFill];
        [topLine1stHalf fill];
    
        { // top gradient
            
            UIColor* topColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha: 1];
            UIColor* bottomColor = [UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha: 1];
            
            // gradient 1st half
            NSArray* gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
            CGFloat gradientLocations[] = {0, 1};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
            
            // rectangle with gradient 1st half
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.origin.x, 1, rect.size.width, 34)];
            CGContextSaveGState(context);
            [rectanglePath addClip];
            CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, 1), CGPointMake(rect.size.width/2, topBarHeight-1), 0);
            CGContextRestoreGState(context);
            CGGradientRelease(gradient);
            CGColorSpaceRelease(colorSpace);
        }
    
        // bottom line 1st half
        UIBezierPath* bottomLine1stHalf = [UIBezierPath bezierPathWithRect: CGRectMake(0, topBarHeight-1, rect.size.width, 1)];
        UIColor *lightGrayColor = [UIColor colorWithRed:204/255. green:204/255. blue:204/255. alpha:1.];
        [lightGrayColor setFill];
        [bottomLine1stHalf fill];

        // top line 2nd half
        UIBezierPath* topLine2ndHalf = [UIBezierPath bezierPathWithRect: CGRectMake(0, topBarHeight, rect.size.width, 1)];
        [[UIColor whiteColor] setFill];
        [topLine2ndHalf fill];

        { // bottom gradient
            
            UIColor* topColor = [UIColor colorWithRed: 237/255. green: 236/255. blue: 235/255. alpha: 1];
            UIColor* bottomColor = [UIColor colorWithRed: 226/255. green: 225/255. blue: 224/255. alpha: 1];
            
            // gradient 2nd half
            NSArray* gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
            CGFloat gradientLocations[] = {0, 1};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
            
            // rectangle with gradient 2nd half
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.origin.x, topBarHeight+1, rect.size.width, rect.size.height)];
            CGContextSaveGState(context);
            [rectanglePath addClip];
            CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width/2, topBarHeight+1), CGPointMake(rect.size.width/2, rect.size.height), 0);
            CGContextRestoreGState(context);
            CGGradientRelease(gradient);
            CGColorSpaceRelease(colorSpace);
        }
        
    };
    return drawRectBlock;
}

@end
