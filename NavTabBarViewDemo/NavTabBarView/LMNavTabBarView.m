//
//  LMNavTabBarView.m
//  ShengHui
//
//  Created by 陈荣山 on 16/2/14.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "LMNavTabBarView.h"
@interface LMNavTabBarView()<UIScrollViewDelegate>
/**
 *  顶部可点击按钮的数组
 */
@property(nonatomic,strong)NSArray *reciveTitleArr;



/**
 *  按钮距离左右的边距
 */
@property(nonatomic)float buttonMarginWidht;
@property(nonatomic)float buttonWidht;
@end
@implementation LMNavTabBarView

-(instancetype)initWithView:(UIViewController *)superVC titleArr:(NSArray *)titleArr{
    
    self = [super initWithFrame:superVC.view.frame];
    
    if (self) {
        self.reciveTitleArr=titleArr;
        self.delegate=superVC;
        self.navScrollBtnView = [self navScrollButtonView:nil];
        self.navScrollBtnView.userInteractionEnabled=YES;
        [self setContentScrollView];
        
        
        [self addSubview:self.contentScrollBtnView];
        
        [self addSubview:self.navScrollBtnView];
    }
    
    self.backgroundColor=[UIColor whiteColor];
    return self;
    
}

-(void)setContentScrollView{
    
    self.contentScrollBtnView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navScrollBtnView.y+self.navScrollBtnView.heightF, self.widthF, self.heightF-(self.navScrollBtnView.y+self.navScrollBtnView.heightF))];
    
    self.contentScrollBtnView.backgroundColor=[UIColor whiteColor];
    self.contentScrollBtnView.showsHorizontalScrollIndicator = NO;
    self.contentScrollBtnView.showsVerticalScrollIndicator = NO;
    self.contentScrollBtnView.delegate = self;
    self.contentScrollBtnView.pagingEnabled = YES;
    self.contentScrollBtnView.userInteractionEnabled = YES;
    self.contentScrollBtnView.bounces=NO;
//    self.contentScrollBtnView.layer.borderWidth=1;
    self.contentScrollBtnView.backgroundColor=DEF_ViewBgColor;
    self.contentScrollBtnView.contentSize=CGSizeMake(PDEVICEWIDTH*self.reciveTitleArr.count, 0);
}

-(UIScrollView *)navScrollButtonView:(UIViewController *)superVC{
    
    UIScrollView *scorllBtnView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, PDEVICEWIDTH, 44)];
    scorllBtnView.backgroundColor=[UIColor whiteColor];
    
    //底部分割线
    self.navBtnBottomLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 42, scorllBtnView.widthF, 2)];
    self.navBtnBottomLine.backgroundColor=DEF_CellSpliteLineColor;
    [scorllBtnView addSubview:self.navBtnBottomLine];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(buttonMarginWidth)]) {
        self.buttonMarginWidht=[self.delegate buttonMarginWidth];
    }
    float buttonHeight=42;
    float buttonWidth=(PDEVICEWIDTH-self.buttonMarginWidht*2)/self.reciveTitleArr.count;
    
    
    //btnarry存储所有按钮
    self.btnarry=[NSMutableArray new];
    
    for (int i=0; i<self.reciveTitleArr.count; i++) {
        float buttonOrginX=self.buttonMarginWidht+buttonWidth*i;
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(buttonOrginX, 0, buttonWidth, buttonHeight)];
        
        [button setTitle:[self.self.reciveTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(selectTitleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [scorllBtnView addSubview:button];
        
        if (i==0) {
            self.preSelectBtn=button;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, 42, button.frame.size.width, 2)];
            self.shadowImageView.backgroundColor=[UIColor redColor];
            [scorllBtnView addSubview:self.shadowImageView];
        }
        [self.btnarry addObject:button];
    }
    return scorllBtnView;
}

-(void)selectTitleButtonAction:(UIButton *)sender{
    
    if (self.preSelectBtn!=sender) {
        //点击的不是同一个按钮
        [self.preSelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.preSelectBtn=sender;
        [UIView animateWithDuration:0.2 animations:^{
            [self.shadowImageView setFrame:CGRectMake(sender.frame.origin.x, self.shadowImageView.frame.origin.y, sender.widthF,self.shadowImageView.frame.size.height)];
            
            [self.contentScrollBtnView setContentOffset:CGPointMake(sender.tag*PDEVICEWIDTH, 0)];
            
        }];
    }
}
#pragma UIScrollViewDelegate

//减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    int  currentIndexPage=_scrollView.contentOffset.x/PDEVICEWIDTH;
    UIButton *currentBtn=[self.btnarry objectAtIndex:currentIndexPage];
    [self selectTitleButtonAction:currentBtn];
}
//只要滚动了就会触发
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    float  userContentOffsetX=_scrollView.contentOffset.x;
    
    if (userContentOffsetX>PDEVICEWIDTH*(self.reciveTitleArr.count-1)) {
        return;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(lm_scrollViewDidScroll:)]) {
        [self.delegate lm_scrollViewDidScroll:_scrollView];
    }
}

@end
