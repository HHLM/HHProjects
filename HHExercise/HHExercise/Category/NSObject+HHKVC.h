//
//  NSObject+HHKVC.h
//  HHExercise
//
//  Created by Now on 2019/4/4.
//  Copyright © 2019 where are you. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HHKVC)
- (void)hh_setValue:(nullable id)value forKey:(NSString *)key;

- (nullable id)hh_valueForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
