#NavTabBarViewDemo：这是一个比较简单的上导航按钮来回切换页面的小Demo
1、在显示的上导航按钮的ViewController导入#import "LMNavTabBarView.h"
eg：
   NSArray * titleArr=@[@"button1",@"button1",@"button1"];//顶部的按钮数组
    self.contentPagesViewArray=[NSMutableArray new];
    self.view.frame=CGRectMake(0, 20, PDEVICEWIDTH, PDEVICEHEIGHT-20);
    __weak __typeof(self)weakSelf = self;
    self.navigationController.view.userInteractionEnabled=YES;
    self.navtabBarView=[[LMNavTabBarView alloc] initWithView:weakSelf titleArr:titleArr];
    [self.view addSubview:self.navtabBarView];
    
    [self loadScrollViewWithPage:0];
 
 设置按钮距离两边屏幕边缘的距离，实现相应的协议
#pragma LMNavTabBarViewDelegate
-(float)buttonMarginWidth{
    
    return 65;
}
-(void)lm_scrollViewDidScroll:(UIScrollView *)_scrollView{
    //每页相应的视图内容
    int page=_scrollView.contentOffset.x/PDEVICEWIDTH;
    
    [self loadScrollViewWithPage:page];
}
//往每一个按钮对应的contentView中添加所需要显示的内容页
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
