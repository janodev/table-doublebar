
// BSD License. Author: jano@jano.com.es

#import "UTRunner.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        debug(@"Running tests.");
        UTRunner *runner = [UTRunner new];
        [runner runAllClasses];
        [runner printReport];
        return 0;
    }
}
