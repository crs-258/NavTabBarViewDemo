//
//  UIView+FrameAdjust.m
//  YunShu
//
//  Created by macAdmin on 15/10/18.
//  Copyright (c) 2015年 macAdmin. All rights reserved.
//

#import "UIView+FrameAdjust.h"

@implementation UIView (FrameAdjust)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    self.frame=CGRectMake(x, self.y, self.widthF, self.heightF);
}

-(CGFloat)y{
   return self.frame.origin.y;

}
-(void)setY:(CGFloat)y{
   self.frame=CGRectMake(self.x, y, self.widthF, self.heightF); 
}

-(CGFloat)heightF{
    
    return self.frame.size.height;

}
-(void)setHeightF:(CGFloat)height{
    
    self.frame=CGRectMake(self.x, self.y, self.widthF, height);
}

-(CGFloat)widthF{
    return self.frame.size.width;

}
-(void)setWidthF:(CGFloat)width{
    
    self.frame=CGRectMake(self.x, self.y, width,  self.heightF);
}

@end
