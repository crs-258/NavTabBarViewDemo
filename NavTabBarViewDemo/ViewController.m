//
//  ViewController.m
//  NavTabBarViewDemo
//
//  Created by 陈荣山 on 16/3/15.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "ViewController.h"
#import "LMNavTabBarView.h"

//获取屏幕的宽和高
#define PDEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define PDEVICEHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<LMNavTabBarViewDelegate>
{
    
    NSArray *colorArr;

}

@property(nonatomic,strong)LMNavTabBarView *navtabBarView;
@property(nonatomic,strong) UIScrollView *contentScrollView;//滚动的内容页
@property(nonatomic,strong) NSMutableArray *contentPagesViewArray;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    colorArr=@[[UIColor redColor],[UIColor grayColor],[UIColor purpleColor],[UIColor greenColor]];
    
    NSArray * titleArr=@[@"button1",@"button1",@"button1"];//顶部的按钮数组
    self.contentPagesViewArray=[NSMutableArray new];
    self.view.frame=CGRectMake(0, 20, PDEVICEWIDTH, PDEVICEHEIGHT-20);
    __weak __typeof(self)weakSelf = self;
    self.navigationController.view.userInteractionEnabled=YES;
    self.navtabBarView=[[LMNavTabBarView alloc] initWithView:weakSelf titleArr:titleArr];
    [self.view addSubview:self.navtabBarView];
    
    [self loadScrollViewWithPage:0];
    
    
}
#pragma LMNavTabBarViewDelegate
-(float)buttonMarginWidth{
    
    return 65;
}
-(void)lm_scrollViewDidScroll:(UIScrollView *)_scrollView{
    //每页相应的视图内容
    int page=_scrollView.contentOffset.x/PDEVICEWIDTH;
    
    [self loadScrollViewWithPage:page];
}

-(void)loadScrollViewWithPage:(int)page{
    if (page<0||page>self.contentPagesViewArray.count) {
        return;
    }
    for (int i=0; i<self.contentPagesViewArray.count; i++) {
        UIView *view=[self.contentPagesViewArray objectAtIndex:i];
        if (view.tag==page) {
            return;
        }
    }
    UIView *viewContent=[[UIView alloc] initWithFrame:CGRectMake(self.navtabBarView.contentScrollBtnView.frame.size.width *page, 0, PDEVICEWIDTH, self.navtabBarView.contentScrollBtnView.frame.size.height)];
    int indexCorlor =arc4random() %4;
    viewContent.backgroundColor=[colorArr objectAtIndex:indexCorlor];
    viewContent.tag=page;
    [self.navtabBarView.contentScrollBtnView addSubview:viewContent];
    [self.contentPagesViewArray addObject:viewContent];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
