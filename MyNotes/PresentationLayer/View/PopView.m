//
//  PopView.m
//  MyNotes
//
//  Created by dengwei on 16/1/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "PopView.h"


#define DZMarginX 5
#define DZMarginY 13

@interface PopView()

@property (nonatomic, weak) UIImageView *containView;

@end

@implementation PopView

- (UIImageView *)containView{
    if (_containView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _containView = imageView;
    }
    return _containView;
}

+ (instancetype)popView{
    PopView *p = [[PopView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    
    return p;
}

- (void)showInRect:(CGRect)rect{
    self.containView.frame = rect;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    [self.containView addSubview:_contentView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = DZMarginX;
    CGFloat y = DZMarginY;
    CGFloat w = _containView.frame.size.width - DZMarginX * 2;
    CGFloat h = _containView.frame.size.height - DZMarginY * 2;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
        [_delegate popViewDidDismiss:self];
    }
}

-(void)removePopView{
    [self removeFromSuperview];
}

@end
