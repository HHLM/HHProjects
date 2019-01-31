//
//  HHContactManager.h
//  HiGuestProject
//
//  Created by Mac on 2019/1/8.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHPerson.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^HHContactChangeBlock)(void);

@interface HHContactManager : NSObject

@property (nonatomic, copy) HHContactChangeBlock block;

@property (nonatomic, copy) NSArray *allPersonArray;



/** install*/
+ (HHContactManager *)shareInstall;

/** 更新通讯里*/
- (void)updateContacts;

/**
 获取所有分组
 @return 分组名字
 */
- (NSArray <CNGroup *>*)queryGroups;

/**
 通讯录添加一个分组
 @param name 分组名字
 */
- (void)addGroupWithName:(NSString *)name;

/**
 删除一个分组
 @param group 分组
 */
- (void)deleteWithGroup:(CNMutableGroup *)group;

/**
 添加一个联系人到分组中

 @param contact 联系人
 @param group 分组
 */
- (void)addContact:(CNContact *)contact toGroup:(CNGroup *)group;


/**
 移动联系人到另一个分组中

 @param contact 联系人
 @param group 分组
 */
- (void)removeContact:(CNContact *)contact fromGroup:(CNGroup *)group;

/**
 查询某一组中的数据

 @param groupName 组名
 @return 数组
 */
- (NSArray <CNContact *>*)queryContactsWithGroupName:(NSString *)groupName;


/**
 通过名字检所查询通讯录

 @param name 检索人名字
 @return 联系人数组
 */
- (NSArray <CNContact *>*)queryContactsWithName:(NSString *)name;

/**
 *  查询通讯录所有联系人
 *
 *  @return 返回数组
 */
- (NSArray <CNContact *>*)queryContacts;

/**
 分组之外的数据
 
 @return 数组
 */
- (NSArray <CNContact *> *)queryWithOutGroups;

/**
 *  更新联系人
 *  @param contact 联系人
 */
- (void)updateContact:(CNMutableContact *)contact;

/**
 *  删除联系人
 *  @param contact 联系人
 */
- (void)deleteContact:(CNMutableContact *)contact;

/**
 *  添加联系人
 *  @param contact 联系人
 */
- (void)addContact:(CNMutableContact *)contact;


/**
 获取某分组对用联系人

 @param gropName 分组名称
 @param completcion 处理后数据
 */
- (void)queryGroupContactsWithGropName:(NSString *)gropName
                           completcion:(void (^)(NSArray <HHSectionPerson*>* groups,NSArray <CNContact*>*contacts,NSArray *keys))completcion;

/**
 获取未分组联系人数据

 @param completcion 处理后的数据
 */
- (void)queryNoneGroupContacts:(void (^)(NSArray <HHSectionPerson*>* contacts, NSArray *keys))completcion;


/**
 获取全部通讯录

 @param completcion 回调
 */
- (void)queryAllContacts:(void (^)(NSArray <HHPerson*>* contacts))completcion;


/**
 删除Contact

 @param identifier id
 */
- (void)deleteContactWithIdentifier:(NSString *)identifier;


/**
 更新Contact

 @param person 联系人model
 */
- (void)updateContactWithPerson:(HHPerson *)person;

/**
 查询联系人通过联系人id

 @param identifier 联系人id
 @return Contact
 */
- (CNMutableContact *)queryConntactWithIdentifier:(NSString *)identifier;


/**
 跟新某个联系人的分组

 @param contact 联系人
 @param groupName 分组名字
 */
- (void)updataContat:(CNContact *)contact toGroupWithGroupName:(NSString *)groupName;

/**
 删除某个联系人的分组
 
 @param contact 联系人
 @param groupName 分组名字
 */
- (void)deleteContat:(CNContact *)contact toGroupWithGroupName:(NSString *)groupName;
@end

NS_ASSUME_NONNULL_END
