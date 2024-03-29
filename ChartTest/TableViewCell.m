//
//  TableViewCell.m
//  ChartTest
//
//  Created by 徐继垚 on 15/10/12.
//  Copyright © 2015年 徐继垚. All rights reserved.
//


#import "TableViewCell.h"
#import "UUChart.h"
#include <objc/runtime.h>

@interface TableViewCell ()<UUChartDataSource>
{
   
    UUChart *chartView;
}
@end


@implementation TableViewCell
static char indexPathKey;

- (NSIndexPath *)indexPatch {
    
    return (NSIndexPath *)objc_getAssociatedObject(self, &indexPathKey);
}


- (void)buildChart:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.selectionStyle = NO;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{

    if (self.indexPatch.section==0) {
        switch (self.indexPatch.row) {
            case 0:
                return [self getXTitles:5];
            case 1:
                return [self getXTitles:11];
            case 2:
                return [self getXTitles:7];
            case 3:
                return [self getXTitles:7];
            default:
                break;
        }
    }else{
        switch (self.indexPatch.row) {
            case 0:
                return [self getXTitles:11];
            case 1:
                return [self getXTitles:7];
            default:
                break;
        }
    }
    return [self getXTitles:20];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
    NSArray *ary4 = @[@"23",@"42",@"25",@"15",@"30",@"42",@"32",@"40",@"42",@"25",@"33"];
    
    if (self.indexPatch.section==0) {
        switch (self.indexPatch.row) {
            case 0:
                return @[ary];
            case 1:
                return @[ary4];
            case 2:
                return @[ary1,ary2];
            default:
                return @[ary1,ary2,ary3];
        }
    }else{
        if (self.indexPatch.row) {
            return @[ary1,ary2];
        }else{
            return @[ary4];
        }
    }
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (self.indexPatch.section==0 && (self.indexPatch.row==0|self.indexPatch.row==1)) {
        return CGRangeMake(60, 10);
    }
    if (self.indexPatch.section==1 && self.indexPatch.row==0) {
        return CGRangeMake(60, 10);
    }
    if (self.indexPatch.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    if (self.indexPatch.row==2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}
@end
