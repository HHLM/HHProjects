//
//  main.m
//  debug-objc
//
//  Created by Closure on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Person* p = [Person new];
        
        id __weak p1;
        {
            NSLog(@"000");
            p1 = p;
            NSLog(@"111");
            NSLog(@"%p, p = %p", &p1, &p);
        }
        NSLog(@"222");
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
