//
//  SQMultipleView.h
//  资运客户端
//
//  Created by rvakva on 2019/3/21.
//  Copyright © 2019年 甘世清. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SQMultipleViewDelegate <NSObject>

/* 选中的项 */
- (void)SQ_BrowserSQMultipleViewTouch:(NSInteger)index;

@end

@interface SQMultipleView : UIView

@property(nonatomic,weak)id<SQMultipleViewDelegate>delegate;
/**
 显示多选

 @param titles 标题
 @return 返回视图
 */
+(id)SQMultipleBrowserforceTouchActionTitles:(nullable NSArray <NSString *>*)titles;

/** 显示 */
-(void)SQqxddViewShow;
/** 隐藏 */
-(void)SQqxddViewHid;
@end

NS_ASSUME_NONNULL_END
