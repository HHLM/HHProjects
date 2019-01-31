//
//  ViewController.m
//  HHContactsManager
//
//  Created by Now on 2019/1/22.
//  Copyright © 2019 你在哪里呀. All rights reserved.
//

#import "ViewController.h"
#import <JQFMDB.h>
#import "HHManager/HHPerson.h"
#import "HHManager/HHContactManager.h"

static NSString *const tableName = @"Contacts";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
#if DEV
    NSLog(@"我是Debug-dev");
#elif TEST
    NSLog(@"我是Debug-test");
#elif DEBUG
    NSLog(@"我是Debug");
#endif
}

- (void)config {
    [[JQFMDB shareDatabase] jq_alterTable:tableName dicOrModel:[HHPerson class]];
    NSLog(@"%@",NSHomeDirectory());
    self.dataArray = [NSMutableArray array];
    [[HHContactManager shareInstall]  queryAllContacts:^(NSArray<HHPerson *> * _Nonnull contacts) {
        [self->_dataArray setArray:contacts];
        [self->_tableView reloadData];
    }];

    
}
- (IBAction)addContacts:(id)sender {
    for (int i = 0; i < 90; i ++) {
        [[JQFMDB shareDatabase] jq_inTransaction:^(BOOL *rollback) {
            for (HHPerson *person in self->_dataArray) {
                
                //            if ([[JQFMDB shareDatabase] jq_lookupTable:tableName dicOrModel:[HHPerson class] whereFormat:@"where  identifier = '%@'",person.identifier].count > 0) {
                //                NSLog(@"%@--已经存在",person.fullName);
                ////                [JQFMDB shareDatabase] jq_updateTable:tableName dicOrModel:person whereFormat:<#(NSString *), ...#>;
                //            }else {
                [[JQFMDB shareDatabase] jq_insertTable:tableName dicOrModel:person];
                //            }
                
            }
        }];
    }
}
- (IBAction)removeContacts:(id)sender {
//    [[JQFMDB shareDatabase] jq_deleteTable:tableName];
//    return;
    NSArray *array = [[JQFMDB shareDatabase] jq_lookupTable:tableName dicOrModel:[HHPerson class] whereFormat:@"where fullName  like '%%丸子' or phoneNumber like '%%1398%%'"];
    for (HHPerson *perspon in array) {
        NSLog(@"%@--%@",perspon.fullName,perspon.phoneNumber);
    }
}
- (IBAction)creatTable:(id)sender {
     [[JQFMDB shareDatabase] jq_createTable:tableName dicOrModel:[HHPerson class]];
//    [self updateContacts];
}
- (void)updateContacts {
    
 }
/** 添加一个联系人到通讯录 */
- (void)addContacts {
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    contact.familyName = [NSString stringWithFormat:@"神州9号"];
    contact.middleName = @"";
    contact.givenName = @"";
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *phoneNumber in @[@"13987654321",@"1312345678"]) {
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:[CNPhoneNumber phoneNumberWithStringValue:phoneNumber?:@""]];
        [array addObject:homePhone];
    }
    contact.phoneNumbers = array;
    
    [[HHContactManager shareInstall] addContact:contact];
}
#pragma mark UITableVieDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    HHPerson *person = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",person.fullName];
    cell.detailTextLabel.text = [NSString stringForArray:person.phoneNumbers withKey:@","];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
