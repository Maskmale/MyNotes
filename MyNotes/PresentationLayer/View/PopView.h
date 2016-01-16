//
//  PopView.h
//  MyNotes
//
//  Created by dengwei on 16/1/14.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopView;

@protocol PopViewDelegate <NSObject>

@optional
- (void)popViewDidDismiss:(PopView *)popView;

@end

@interface PopView : UIView

@property (nonatomic, weak) id<PopViewDelegate> delegate;

@property (nonatomic, weak) UIView *contentView;

+(instancetype)popView;

-(void)showInRect:(CGRect)rect;

-(void)removePopView;

@end
