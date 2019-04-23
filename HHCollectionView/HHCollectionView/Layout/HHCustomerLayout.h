//
//  HHCustomerLayout.h
//  HHCollectionView
//
//  Created by Now on 2019/4/20.
//  Copyright © 2019 任他疾风起. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHCustomerLayout : UICollectionViewLayout
/** cell大小 */
@property (nonatomic, assign) CGSize itemSize;
/** 行间距 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 左右间距 */
@property (nonatomic, assign) CGFloat interitemSpacing ;
/** 偏移 */
@property (nonatomic, assign) UIEdgeInsets contentInset;
@end

NS_ASSUME_NONNULL_END
