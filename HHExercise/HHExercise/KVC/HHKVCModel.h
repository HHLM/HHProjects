//
//  HHKVCModel.h
//  HHExercise
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHKVCModel : NSObject
{
    @public
    NSString *name;
//    NSString *age;
//    NSString *_age;
//    NSString *isAge;
}
@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *sonName;

@property (nonatomic, copy) NSString *dogName;

@property (nonatomic, copy) NSString *nickName;


@property (nonatomic, strong) NSArray *books;


@property (nonatomic, strong) NSSet *bookSet;

@property (nonatomic, assign) NSUInteger count;
@end

NS_ASSUME_NONNULL_END
