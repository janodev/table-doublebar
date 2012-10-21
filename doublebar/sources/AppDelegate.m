
// BSD License. Author: jano@jano.com.es

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    SlidTableVC *vc = [SlidTableVC new];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) applicationWillResignActive:(UIApplication*)application {}
- (void) applicationDidEnterBackground:(UIApplication*)application {}
- (void) applicationWillEnterForeground:(UIApplication*)application {}
- (void) applicationDidBecomeActive:(UIApplication*)application {}
- (void) applicationWillTerminate:(UIApplication*)application {}


@end
