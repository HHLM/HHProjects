//
//  HHPerson.m
//  HiGuestProject
//
//  Created by Mac on 2019/1/9.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import "HHPerson.h"
#import "HHContactManager.h"
@implementation HHPerson
- (instancetype)initWithCNContact:(CNContact *)contact; {
    self = [super init];
    if (self) {
        self.identifier = contact.identifier;
        self.fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
        self.familyName = contact.familyName;
        self.givenName = contact.givenName;
        if (!self.fullName || self.fullName.length < 1) {
            self.fullName = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        }
        if (!self.fullName || self.fullName.length < 1) {
            self.fullName = @"无名氏";
        }
        self.middleName = contact.middleName;
        if ([contact isKeyAvailable:CNContactPhoneNumbersKey]) {
            NSMutableArray *phones = [NSMutableArray array];
            NSMutableArray *numbers = [NSMutableArray array];
            for (CNLabeledValue *labeledValue in contact.phoneNumbers) {
                HHPhone *phoneModel = [[HHPhone alloc] initWithLabeledValue:labeledValue];
                [phones addObject:phoneModel];
                [numbers addObject:phoneModel.phone];
            }
            self.phones = phones;
            self.phoneNumbers = numbers;
            self.phoneNumber = [NSString stringForArray:numbers withKey:@","];
//            [NSString jsonStringForData:numbers];
            NSLog(@"%@---%@",numbers,self.phoneNumber);
            self.pinyin = [NSString pinyinForString:self.fullName];
        }
    }return self;
}
- (CNMutableContact *)personToMutableContact {
    CNMutableContact *contact = [[HHContactManager shareInstall] queryConntactWithIdentifier:self.identifier];
    contact.familyName = self.fullName;
    contact.middleName = @"";
    contact.givenName = @"";
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *phoneNumber in self.phoneNumbers) {
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:phoneNumber?:@""]];
        [array addObject:homePhone];
    }
    contact.phoneNumbers = array;
    return contact;
}
@end
@implementation HHPhone
- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue {
    self = [super init];
    if (self) {
        CNPhoneNumber *phoneValue = labeledValue.value;
        NSString *phone = phoneValue.stringValue;
        self.phone = [NSString filterSpecialString:phone];
        self.label = [CNLabeledValue localizedStringForLabel:labeledValue.label];
    }return self;
}


@end
@implementation HHSectionPerson


@end
@implementation HHGroupPerson


@end
