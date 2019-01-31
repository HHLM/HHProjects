//
//  HHPerson.h
//  HiGuestProject
//
//  Created by Mac on 2019/1/9.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "NSString+Ext.h"
NS_ASSUME_NONNULL_BEGIN
@class HHPhone,HHSectionPerson;
@interface HHPerson : NSObject

/**
 构造函数

 @param contact 联系人信息
 @return 模型
 */
- (instancetype)initWithCNContact:(CNContact *)contact;

/**
 model 转成 CNMutableContact
 
 @return CNMutableContact
 */
- (CNMutableContact *)personToMutableContact;
/** 主键id */
@property (nonatomic, copy) NSString *pkid;

/** 联系人id*/
@property (nonatomic, copy) NSString *identifier;

/** 姓名*/
@property (nonatomic, copy) NSString *fullName;

/** 姓名拼音*/
@property (nonatomic, copy) NSString *pinyin;

/** 电话 json字符串形式 */
@property (nonatomic, copy) NSString *phoneNumber;

/** 电话号码*/
@property (nonatomic, copy) NSArray *phoneNumbers;

/** 分组名称*/
@property (nonatomic, copy) NSString *groupName;

/** 来电标记 */
@property (nonatomic, copy) NSString *mark;

/** 年龄段 */
@property (nonatomic, copy) NSString *age;

/** 客户状态 */
@property (nonatomic, copy) NSString *consumption_state;

/** 消费能力 */
@property (nonatomic, copy) NSString *consumption_ability;

/** 标签 */
@property (nonatomic, copy) NSString *tag;

/** 初识时间 */
@property (nonatomic, copy) NSString *first_acquaintance_time;

/** 姓*/
@property (nonatomic, copy) NSString *familyName;

/** 名*/
@property (nonatomic, copy) NSString *givenName;

/** 中间名*/
@property (nonatomic, copy) NSString *middleName;

/** 电话号码数组 */
@property (nonatomic, copy) NSArray <HHPhone *> *phones;

/** 是否选中*/
@property (nonatomic, assign) BOOL isSelect;

/** 是否有更新*/
@property (nonatomic, assign) BOOL show;

/** 是否有编辑 编辑标志 为YES就要上传到服务器，成功后 修改状态为NO */
@property (nonatomic, assign) BOOL isEdit;

/** 是否删除 标记一下 为YES 需要和服务器交互删除对应联系人 成功后删除本地这个联系人*/
@property (nonatomic, assign) BOOL isDelete;

@end

@interface HHPhone : NSObject
/** 电话 */
@property (nonatomic, copy) NSString *phone;

/** 标签*/
@property (nonatomic, copy) NSString *label;


/**
 便利构造 （Contacts）
 
 @param labeledValue 标签和值
 @return 对象
 */
- (instancetype)initWithLabeledValue:(CNLabeledValue *)labeledValue;


@end
/// 排序分组模型
@interface HHSectionPerson : NSObject

/** key A,B,C,D... */
@property (nonatomic, copy) NSString *key;

/** key对用的联系人数组*/
@property (nonatomic, copy) NSArray <HHPerson *> *persons;



@end

/// 排序分组模型
@interface HHGroupPerson : NSObject

/** 是否选中*/
@property (nonatomic, assign) BOOL select;

/** 是否有更新*/
@property (nonatomic, assign) BOOL show;

/** 通讯里分组的名字*/
@property (nonatomic, copy) NSString *key;

/** 分组key [A,B,C,D...] */
@property (nonatomic, copy) NSArray *keys;

/** 通讯录当前分组 所有联系人 未处理*/
@property (nonatomic, copy) NSArray <CNContact *> *contacts;

/** 分组处理后的数据*/
@property (nonatomic, copy) NSArray <HHSectionPerson *> *sections;


@end

NS_ASSUME_NONNULL_END
