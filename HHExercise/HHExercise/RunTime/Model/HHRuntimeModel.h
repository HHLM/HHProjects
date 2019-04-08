//
//  HHRuntimeModel.h
//  HHExercise
//
//  Created by Now on 2019/4/8.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHRuntimeModel : NSObject
{
@private
    NSString *age;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, copy) NSString *work;
- (void)walk;
+ (void)sleep;
- (void)study;
@end

NS_ASSUME_NONNULL_END
