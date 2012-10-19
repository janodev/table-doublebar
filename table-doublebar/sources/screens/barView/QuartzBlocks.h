
// BSD License. Author: <jano@jano.com.es>

#ifndef DRAWRECT_BLOCK
#define DRAWRECT_BLOCK
typedef void(^drawRectBlock_t)(CGRect rect);
#endif

@interface QuartzBlocks : NSObject

+(drawRectBlock_t) doubleBarWithRect:(CGRect)rect;

@end
