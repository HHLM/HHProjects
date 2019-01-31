//
//  HHContactManager.m
//  HiGuestProject
//
//  Created by Mac on 2019/1/8.
//  Copyright © 2019 Chris.Chen. All rights reserved.
//

#import "HHContactManager.h"

@interface HHContactManager()
@property (nonatomic, strong) CNContactStore *contactStore;
@property (nonatomic) dispatch_queue_t queue;
/** 分组*/
@property (nonatomic, copy) NSArray *groups;
/** 所有通讯录联系人*/
@property (nonatomic, strong) NSMutableArray *allContacts;
@end
@implementation HHContactManager
static HHContactManager *manager = nil;
+ (HHContactManager *)shareInstall {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HHContactManager alloc] init];
    });
    return manager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _contactStore = [[CNContactStore alloc] init];
        _queue = dispatch_queue_create("com.addressBook.queue", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contactStoreDidChange)
                                                     name:CNContactStoreDidChangeNotification
                                                   object:nil];
        //获取所有联系人
        [self.allContacts setArray:[self queryContacts]];
        //获取所有分组
        self.groups = [self queryGroups];
        [self config];
    }return self;
}
- (void)updateContacts {
    if (self.block) {
        self.block();
    }
}
- (void)config {
    [self addGroupWithName:@"客户"];
    [self addGroupWithName:@"朋友"];
    [self addGroupWithName:@"同事"];
    [self addGroupWithName:@"家庭"];
    [self addGroupWithName:@"同学"];
    NSArray *friends = [self queryContactsWithGroupName:@"Friends"];
    for (CNContact *contact in friends) {
        [self removeContact:contact fromGroup:[self groupWithName:@"Friends"]];
        [self addContact:contact toGroup:[self groupWithName:@"朋友"]];
    }
    NSArray *works = [self queryContactsWithGroupName:@"Work"];
    for (CNContact *contact in works) {
        [self removeContact:contact fromGroup:[self groupWithName:@"Work"]];
        [self addContact:contact toGroup:[self groupWithName:@"工作"]];
    }
}
- (NSMutableArray *)allContacts {
    if (!_allContacts) {
        _allContacts = [NSMutableArray array];
    }return _allContacts;
}
//通讯录修改了
- (void)contactStoreDidChange {
    NSLog(@"修改了通讯里----啦啦啦啦");
    [self.allContacts setArray:[self queryContacts]];
    self.groups = [self queryGroups];
}
//MARK:获取通通讯录所有分组
- (NSArray <CNGroup *>*)queryGroups {
    CNContactStore *store = [[CNContactStore alloc] init];
    /** 查询所有的group (predicate参数为nil时候 查询所有)*/
    NSArray <CNGroup *> *array = [store groupsMatchingPredicate:nil error:nil];
    return array;
}

//MARK:通讯录添加一个分组
- (void)addGroupWithName:(NSString *)name {
    if (!self.groups) self.groups = [self queryGroups];
    for (CNGroup *group in self.groups) {
        if ([group.name isEqualToString:name]) { return;}////若已经有了就不在添加
    }
    CNMutableGroup *group = [[CNMutableGroup alloc] init];
    group.name = name;
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addGroup:group toContainerWithIdentifier:nil];
    /** 写入保存*/
    [_contactStore executeSaveRequest:request error:nil];
}
//MARK:删除一个分组
- (void)deleteWithGroup:(CNMutableGroup *)group{
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request deleteGroup:group];
    /** 写入保存*/
    [_contactStore executeSaveRequest:request error:nil];
}
//通过名字查询分组
- (CNGroup *)groupWithName:(NSString *)groupName {
    for (CNGroup *group in self.groups) {
        if ([group.name isEqualToString:groupName]) {
            return group;
        }else {
            continue;
        }
    }
    return nil;
}
//MARK:添加一个联系人到分组中
- (void)addContact:(CNContact *)contact toGroup:(CNGroup *)group {
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request addMember:contact toGroup:group];
    /** 写入保存*/
    [_contactStore executeSaveRequest:request error:nil];
    if (self.block) {
//        self.block();
    }
}
//MARK:移除联系人从一个分组中
- (void)removeContact:(CNContact *)contact fromGroup:(CNGroup *)group {
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    [request removeMember:contact fromGroup:group];
    /** 写入保存*/
    [_contactStore executeSaveRequest:request error:nil];
    if (self.block) {
//        self.block();
    }
}

//MARK:通过分组名字查询当前组的所有联系人
- (NSArray <CNContact *>*)queryContactsWithGroupName:(NSString *)groupName {
    if (!self.groups) self.groups = [self queryGroups];
    NSString *groupIdentifier = @"";
    for (CNGroup *group in self.groups) {
        if ([group.name isEqualToString:groupName]) {
            groupIdentifier = group.identifier;
            break;
        }
    }
    CNContactStore *store = [[CNContactStore alloc] init];
    // 检索条件 通过分组id
    NSPredicate *predicate = [CNContact predicateForContactsInGroupWithIdentifier:groupIdentifier];;
    // 提取数据
    NSArray *contact = [store unifiedContactsMatchingPredicate:predicate keysToFetch:[self keys] error:nil];
    return contact;
}

//MARK:通过名字检所查询通讯录
- (NSArray <CNContact *>*)queryContactsWithName:(NSString *)name {
    CNContactStore *store = [[CNContactStore alloc] init];
    // 检索条件
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    // 提取数据
    NSArray *contact = [store unifiedContactsMatchingPredicate:predicate keysToFetch:[self keys] error:nil];
    return contact;
}
//MARK:查询通讯录所有联系人
- (NSArray <CNContact *>*)queryContacts {
    
#if 0
    NSMutableArray *datas = [NSMutableArray array];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:self.keys];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        //HHPerson *person = [[HHPerson alloc] initWithCNContact:contact];
        [datas addObject:contact];
    }];
    return datas;
#else
    CNContactStore *store = [[CNContactStore alloc] init];
    //查询所有联系人
    NSArray *contacts = [store unifiedContactsMatchingPredicate:nil
                                                   keysToFetch:[self keys]
                                                         error:nil];
    return contacts;
#endif
    
}
//MARK:获取分组之外的数据
- (NSArray <CNContact *>*)queryWithOutGroups; {
    NSMutableArray *allContacts = [NSMutableArray arrayWithArray:self.allContacts];
    [allContacts removeObjectsInArray:[self queryContactsWithGroupName:@"同学"]];
    [allContacts removeObjectsInArray:[self queryContactsWithGroupName:@"朋友"]];
    [allContacts removeObjectsInArray:[self queryContactsWithGroupName:@"同事"]];
    [allContacts removeObjectsInArray:[self queryContactsWithGroupName:@"客户"]];
    [allContacts removeObjectsInArray:[self queryContactsWithGroupName:@"家庭"]];
    return allContacts;
}

//MARK:添加联系人
- (void)addContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    // 写入联系人
    [_contactStore executeSaveRequest:saveRequest error:nil];
}
//MARK:更新通讯录联系人
- (void)updateContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateContact:contact];
    // 重新写入
    [_contactStore executeSaveRequest:saveRequest error:nil];
}

//MARK:删除某个人
- (void)deleteContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteContact:contact];
    // 写入操作
    [_contactStore executeSaveRequest:saveRequest error:nil];
    if (self.block) {
        self.block();
    }
}
//*!!!:排序
- (void)sortNameWithDatas:(NSArray *)datas completcion:(void (^)(NSArray <HHSectionPerson*>* contacts, NSArray *keys))completcion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (CNContact *contact in datas)
    {
        // 拼音首字母
        HHPerson *person = [[HHPerson alloc] initWithCNContact:contact];
        NSString *firstLetter = nil;
        NSLog(@"%@",person.fullName);
        if (person.fullName.length == 0)
        {
            firstLetter = @"#";
        }
        else
        {
            NSString *pinyinString = [NSString pinyinForString:person.fullName];
            person.pinyin = pinyinString;
            NSString *upperStr = [[pinyinString substringToIndex:1] uppercaseString];
            NSString *regex = @"^[A-Z]$";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            firstLetter = [predicate evaluateWithObject:upperStr] ? upperStr : @"#";
        }
        
        if (dict[firstLetter]) {
            [dict[firstLetter] addObject:person];
        }
        else {
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:person, nil];
            dict[firstLetter] = arr;
        }
    }
    
    NSMutableArray *keys = [[[dict allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    if ([keys.firstObject isEqualToString:@"#"]) {
        [keys addObject:keys.firstObject];
        [keys removeObjectAtIndex:0];
    }
    
    NSMutableArray *persons = [NSMutableArray array];
    
    [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HHSectionPerson *person = [HHSectionPerson new];
        person.key = key;
        // 组内按照拼音排序
        NSArray *personsArr = [dict[key] sortedArrayUsingComparator:^NSComparisonResult(HHPerson *person1, HHPerson *person2) {
            
            NSComparisonResult result = [person1.pinyin compare:person2.pinyin];
            return result;
        }];
        
        person.persons = personsArr;
        
        [persons addObject:person];
    }];
    
    if (completcion)
    {
        completcion(persons, keys);
    }
}
//MARK:获取某分组对用联系人
- (void)queryGroupContactsWithGropName:(NSString *)gropName
                           completcion:(void (^)(NSArray <HHSectionPerson*>* groups,NSArray <CNContact*>*contacts,NSArray *keys))completcion; {
    NSArray <CNContact*> *groups = [self queryContactsWithGroupName:gropName];
    [self sortNameWithDatas:groups completcion:^(NSArray<HHSectionPerson *> *contacts, NSArray *keys) {
        completcion(contacts,groups,keys);
    }];
}

//MARK:获取全部通讯录
- (void)queryAllContacts:(void (^)(NSArray <HHPerson*>* contacts))completcion {
    NSMutableArray *allPersons = [NSMutableArray array];
    for (CNContact *contact in self.allContacts) {
        HHPerson *person = [[HHPerson alloc] initWithCNContact:contact];
        [allPersons addObject:person];
        self.allPersonArray = allPersons;
        completcion(allPersons);
    }
}
//MARK:获取未分组联系人数据
- (void)queryNoneGroupContacts:(void (^)(NSArray <HHSectionPerson*>* contacts, NSArray *keys))completcion; {
    [self sortNameWithDatas:[self queryWithOutGroups] completcion:^(NSArray<HHSectionPerson *> *contacts, NSArray *keys) {
        completcion(contacts,keys);
    }];
}
- (CNMutableContact *)queryConntactWithIdentifier:(NSString *)identifier {
    CNContact *contact = [_contactStore unifiedContactWithIdentifier:identifier keysToFetch:[self keys] error:nil];
    return [contact mutableCopy];
}
/**
 删除Contact
 
 @param identifier id
 */
- (void)deleteContactWithIdentifier:(NSString *)identifier {
    CNContact *contact = [_contactStore unifiedContactWithIdentifier:identifier keysToFetch:[self keys] error:nil];
    [self deleteContact:[contact mutableCopy]];
}

- (void)updataContat:(CNContact *)contact toGroupWithGroupName:(NSString *)groupName {
    CNGroup *group = [self groupWithName:groupName];
    [self addContact:contact toGroup:group];
}

- (void)deleteContat:(CNContact *)contact toGroupWithGroupName:(NSString *)groupName {
    CNGroup *group = [self groupWithName:groupName];
    [self removeContact:contact fromGroup:group];
}
- (void)updateContactWithPerson:(HHPerson *)person; {
    CNContact *contact = [_contactStore unifiedContactWithIdentifier:person.identifier keysToFetch:[self keys] error:nil];
    CNMutableContact *mContact = [contact mutableCopy];
    mContact.familyName = person.fullName;
    mContact.givenName = @"";
    mContact.middleName = @"";
    NSMutableArray *array = [NSMutableArray array];
    for (HHPhone *phone in person.phones) {
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:phone.phone?:@""]];
        [array addObject:homePhone];
    }
    mContact.phoneNumbers = array;
   
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
}


- (NSArray *)keys {
    return @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName], //全名
             CNContactGivenNameKey,                 //名
             CNContactMiddleNameKey,                //中间名
             CNContactFamilyNameKey,                //姓
             CNContactPhoneNumbersKey,              //号码
             //             CNContactOrganizationNameKey,          //公司
             //             CNContactDepartmentNameKey,            //部门
             //             CNContactJobTitleKey,                  //职位
             CNContactNoteKey,                      //备注
             //             CNContactPhoneticGivenNameKey,         //名字拼音或音标
             //             CNContactPhoneticFamilyNameKey,        //姓拼音或音标
             //             CNContactPhoneticMiddleNameKey,        //中间名拼音或音标
             CNContactImageDataKey,                 //图片
             //             CNContactDatesKey,                     //日期
             CNContactThumbnailImageDataKey,        //缩略图
             //             CNContactEmailAddressesKey,            //邮箱地址
             //             CNContactPostalAddressesKey,           //地址
             //             CNContactBirthdayKey,                  //生日
             //             CNContactNonGregorianBirthdayKey,      //农历
             //             CNContactInstantMessageAddressesKey,   //及时通讯
             //             CNContactSocialProfilesKey,            //社交
             //             CNContactRelationsKey,                 //关联人
             //             CNContactUrlAddressesKey,              //URL
             //             CNContactNamePrefixKey,                //姓名前缀
             //             CNContactPreviousFamilyNameKey,        //婚前姓
             //             CNContactNameSuffixKey,                //姓名后缀
             //             CNContactNicknameKey,                  //昵称
             //             CNContactImageDataAvailableKey,        //图片是否允许访问
             //             CNContactTypeKey                       //类型
             //             CNContactPhoneticOrganizationNameKey,  //公司拼音或音标
             ];
}

@end
