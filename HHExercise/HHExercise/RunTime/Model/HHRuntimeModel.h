//
//  HHRuntimeModel.h
//  HHExercise
//
//  Created by Now on 2019/4/8.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol HHRuntimeModelDelegate <NSObject>

- runtimeShowMethod;

@end

@interface HHRuntimeModel : NSObject
{
@private
    NSString *age;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, copy) NSString *work;
@property (nonatomic, weak) id <HHRuntimeModelDelegate>delegate;
- (void)walk;
+ (void)sleep;
- (void)study;
- (void)todoSomething:(NSString *)something,...;
@end

NS_ASSUME_NONNULL_END
