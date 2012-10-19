
#import "SlidTableVC.h"

// number of rows in the table
const NSUInteger kRowNumber = 20;

// size of the top half of the header, that disappears when the table is scrolled
const NSInteger kHiddenPixels = 35;


@interface SlidTableVC ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic,assign) CGRect initialTableRect;
@property (nonatomic,assign) CGRect initialHeaderRect;
@end


@implementation SlidTableVC


// TODO: don't let the 1st row of the table scroll under the bar until the bar is hidden
/*
-(void) handleDragGesture:(UIPanGestureRecognizer *)recognizer
{
    static CGFloat originX;
    
    switch (recognizer.state) {
            
        // Finger landed. Save the initial position..
        case UIGestureRecognizerStateBegan:{
            originX = self.tableView.frame.origin.x;
            break;
        }
            
        // Finger is being dragged.
        case UIGestureRecognizerStateChanged:{
            break;
        }
            
        // Finger lifted.
        case UIGestureRecognizerStateEnded:{
            CGPoint translation = [recognizer translationInView:self.tableView];
            CGPoint velocity = [recognizer velocityInView:self.tableView];
            CGFloat inertia = velocity.x * .1;
            CGFloat finalX = originX + translation.x + inertia;
            break;
        }
        default:{
            break;
        }
    }
}
*/


#pragma mark UIScrollViewDelegateMethods


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    // 0 at the initial position, negative down, positive up
    CGPoint offset = aScrollView.contentOffset;

    if (offset.y>=0 && offset.y<=kHiddenPixels)
    {
        // move header
        CGRect newRect = self.initialHeaderRect;
        newRect.origin.y -= offset.y;
        self.headerView.frame = newRect;
        
        // move and resize table
        newRect = self.initialTableRect;
        newRect.origin.y -= offset.y;
        newRect.size.height += offset.y;
        self.tableView.frame = newRect;
    }
    else if (self.headerView.frame.origin.y!=0 || self.headerView.frame.origin.y!=kHiddenPixels)
    {
        // outside the scrolling area but frame is not on 0 or 35,
        // which means we skipped scroll because drag was to fast
        
        if (offset.y<0){
            // set initial position on header and table
            self.headerView.frame = self.initialHeaderRect;
            self.tableView.frame = self.initialTableRect;
        }
        else if (offset.y>kHiddenPixels)
        {
            // set scrolled up position on header
            CGRect rect = self.initialHeaderRect;
            rect.origin.y = -1*kHiddenPixels;
            self.headerView.frame = rect;
            
            // set scrolled up position on table            
            rect = self.initialTableRect;
            rect.size.height += kHiddenPixels;
            rect.origin.y -= kHiddenPixels;
            self.tableView.frame = rect;
        }
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kRowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UIViewController


-(void) setupGUI {

    // hide the nav bar
    self.navigationController.navigationBar.hidden = YES;
    
    // yellow table background
    self.tableView.backgroundColor = [UIColor colorWithRed:254/255. green:252/255. blue:229/255. alpha:1.0];
    
    // create the top bar using Quartz
    // or do this: self.headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];
    CGRect rect = CGRectMake(0, 0, 320, 80);
    drawRectBlock_t drawRectBlock = [QuartzBlocks doubleBarWithRect:rect];
    self.headerView = [[BlockView alloc] initWithFrame:rect drawRectBlock:drawRectBlock];
    [self.view addSubview:self.headerView];
    
    // save the original sizes
    self.initialTableRect = self.tableView.frame;
    self.initialHeaderRect = self.headerView.frame;
    
    /*
    // gesture recognizer to read drag gestures
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragGesture:)];
    [recognizer setMinimumNumberOfTouches:1];
    [recognizer setMaximumNumberOfTouches:1];
    [self.tableView addGestureRecognizer:recognizer];
    */
}


-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupGUI];
}


@end
