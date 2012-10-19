
// BSD License. Author: <jano@jano.com.es>

#import "BlockView.h"

@interface BlockView()
@property (nonatomic,copy) drawRectBlock_t drawRectBlock;
@end

@implementation BlockView

-(id) initWithFrame:(CGRect)frame drawRectBlock:(drawRectBlock_t)block
{
    if (self = [super initWithFrame:frame]){
        if (block) self.drawRectBlock = block;
    }
    return self;
}


-(void) drawRect:(CGRect)rect 
{
    if (self.drawRectBlock) {
        self.drawRectBlock(rect);
    } else {
        [super drawRect:rect];
    }
}


@end
