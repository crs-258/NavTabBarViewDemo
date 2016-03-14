//
//  LMNavTabBarView.h
//  ShengHui
//
//  Created by 陈荣山 on 16/2/14.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LMNavTabBarViewDelegate <NSObject>

/**
 *上导航按钮距离两边外间距
 *
 *  @return 返回左按钮或者右按钮距离左右两边的距离
 */
@required
-(float)buttonMarginWidth;



@optional
/**
 *  //主要是滚动的话就该动作传递出去,可在该方法里面制定相应的内容页
 *
 *  @param _scrollView 滚动的UIScrollView
 */
-(void)lm_scrollViewDidScroll:(UIScrollView *)_scrollView;


@end
@interface LMNavTabBarView : UIScrollView
/**
 *  顶部对应的button的view
 */
@property(nonatomic,strong)UIScrollView *navScrollBtnView;

@property(nonatomic,strong)UIScrollView *contentScrollBtnView;//每个按钮对应的内容也
/**
 *  底导航底部的分割线
 */
@property(nonatomic,strong)UIImageView *navBtnBottomLine;

@property(nonatomic,strong)NSMutableArray *btnarry;//存放所有按钮
@property (nonatomic, strong)UIImageView *shadowImageView;//移动的图片
@property (nonatomic, strong)UIButton *preSelectBtn;//上一次选中的按钮
//@property (nonatomic, strong)UIButton *currentSelectBtn;//当前选中的按钮
@property(nonatomic,weak)id<LMNavTabBarViewDelegate> delegate;
-(instancetype)initWithView:(UIViewController *)superVC titleArr:(NSArray *)titleArr;


@end
