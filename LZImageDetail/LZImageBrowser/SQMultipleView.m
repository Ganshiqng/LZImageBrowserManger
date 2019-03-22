//
//  SQMultipleView.m
//  资运客户端
//
//  Created by rvakva on 2019/3/21.
//  Copyright © 2019年 甘世清. All rights reserved.
//

#import "SQMultipleView.h"
#import "LZImageBrowserHeader.h"
@interface SQMultipleView ()<UITableViewDelegate,UITableViewDataSource>
//展示列表
@property (nonatomic , strong) UITableView * GetOfftableView;
/** 数据 */
@property (nonatomic , copy) NSArray * previewActionTitls;

@end
@implementation SQMultipleView

+(id)SQMultipleBrowserforceTouchActionTitles:(nullable NSArray <NSString *>*)titles
{
    SQMultipleView * SQView = [[SQMultipleView alloc]init];
    SQView.backgroundColor = [UIColor clearColor];
    SQView.previewActionTitls = titles;
    return SQView;
}
-(void)setPreviewActionTitls:(NSArray *)previewActionTitls
{
    self.frame = CGRectMake(0, SCREEN_HEIGHT+SQFootHeight, SCREEN_WIDETH, SCREEN_HEIGHT+SQFootHeight);
    _previewActionTitls = previewActionTitls;
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor =[UIColor whiteColor];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [btn addTarget:self action:@selector(SQqxddViewHid) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    btn.frame = CGRectMake(0, self.frame.size.height-SQFootHeight-50, SCREEN_WIDETH, 50);
   
    [self addSubview:self.GetOfftableView];
    CGFloat height = previewActionTitls.count * 50;
    if (height>300) {
        height = 300;
    }
    self.GetOfftableView.frame = CGRectMake(0, self.frame.size.height-SQFootHeight-60-height, SCREEN_WIDETH, height);
    [self.GetOfftableView reloadData];
    [self.superview layoutIfNeeded];
}
#pragma mark  tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return  _previewActionTitls.count;
}

//表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellindefire = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindefire];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
     cell.textLabel.text = [NSString stringWithFormat:@"%@",[_previewActionTitls objectAtIndex:indexPath.row]];
     cell.textLabel.textAlignment = NSTextAlignmentCenter;
     [cell.textLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(SQ_BrowserSQMultipleViewTouch:)]) {
        [self.delegate SQ_BrowserSQMultipleViewTouch:indexPath.row];
    }
     [self SQqxddViewHid];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self SQqxddViewHid];
}
/** 显示 */
-(void)SQqxddViewShow
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDETH, SCREEN_HEIGHT+SQFootHeight);
    } completion:^(BOOL finished) {
        self.backgroundColor = SQBackground;
    }];
}
/** 隐藏 */
-(void)SQqxddViewHid
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT+SQFootHeight, SCREEN_WIDETH, SCREEN_HEIGHT+SQFootHeight);
    } completion:^(BOOL finished) {

    }];
}

//表
-(UITableView*)GetOfftableView
{
    if (!_GetOfftableView) {
        _GetOfftableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _GetOfftableView.delegate = self;
        _GetOfftableView.dataSource = self;
        _GetOfftableView.tableFooterView = [[UIView alloc] init];
        _GetOfftableView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _GetOfftableView.estimatedRowHeight = 0;
            _GetOfftableView.estimatedSectionFooterHeight = 0;
            _GetOfftableView.estimatedSectionHeaderHeight = 0;
            _GetOfftableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if ([_GetOfftableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_GetOfftableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        if ([_GetOfftableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_GetOfftableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
    }
    return _GetOfftableView;
}

@end
