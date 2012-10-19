
// BSD License. Author: <jano@jano.com.es>

#ifndef DRAWRECT_BLOCK
#define DRAWRECT_BLOCK
typedef void(^drawRectBlock_t)(CGRect rect);
#endif

@interface BlockView : UIView
-(id) initWithFrame:(CGRect)frame drawRectBlock:(drawRectBlock_t)block;
@end
