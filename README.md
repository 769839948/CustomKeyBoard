# CustomKeyBoard
//
//  CustomKeyboard.m
//  好好修车技师版
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 Zhang. All rights reserved.
//

#import "CustomKeyboard.h"


#define ButtonWidth [[UIScreen mainScreen] bounds].size.width/4
#define ButtonHeight 50

#define UIScreenSize [[UIScreen mainScreen] bounds].size

@interface CustomKeyboard()
{
    UIView *keyBoarView;
    NSArray *buttonArray;
    NSMutableDictionary *dicArray;
    
    UIView *tapView;
    
    CGRect currentFrame;
}

@property (nonatomic, strong) UITapGestureRecognizer *singleGestureRecognizer;

@end

@implementation CustomKeyboard


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        currentFrame = frame;
        [self setUpButton:titleArray frame:frame];
        [self setUpTapView:frame];
        [UIView animateWithDuration:0.5 animations:^{
            
            [self showAnimation];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    return self;
}

- (void)setUpTapView:(CGRect)frame
{
    tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenSize.width, frame.size.height - ButtonHeight * 5)];
    [tapView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]];
    _singleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handerPress:)];
    _singleGestureRecognizer.numberOfTapsRequired = 1;
    [tapView addGestureRecognizer:_singleGestureRecognizer];
    [self addSubview:tapView];
}

- (void)setUpButton:(NSArray *)titleArray frame:(CGRect)frame
{
    dicArray = [[NSMutableDictionary alloc] init];
    CGFloat height = frame.size.height - ButtonHeight * 5;
    for (int i = 0; i < 19; i ++)
    {
        [dicArray setValue:titleArray[i] forKey:[NSString stringWithFormat:@"%d",i]];
        if (i == 15) {
            CGRect frame = CGRectMake(i % 4*ButtonWidth, height + (i/4) * ButtonHeight, ButtonWidth, ButtonHeight * 2);
            UIButton *button = [self setFrame:frame title:@"搜索" tag:i imge:nil];
            //            [button setBackgroundColor:[UIColor blueColor]];
            [self addSubview:button];
        }else {
            CGRect frame = CGRectMake(i % 4*ButtonWidth, height + (i/4) * ButtonHeight, ButtonWidth, ButtonHeight);
            UIButton *button;
            if ([titleArray[i] isEqualToString:@"close"]) {
                button = [self setFrame:frame title:@"关闭" tag:i imge:nil];
            }else if([titleArray[i] isEqualToString:@"delete"]){
                button = [self setFrame:frame title:@"删除" tag:i imge:nil];
            }else if([titleArray[i] isEqualToString:@"-"]){
                button = [self setFrame:frame title:nil tag:i imge:@"sym_keyboard_left"];
            }else if([titleArray[i] isEqualToString:@"+"]){
                button = [self setFrame:frame title:nil tag:i imge:@"sym_keyboard_right"];
            }else{
                button = [self setFrame:frame title:titleArray[i] tag:i imge:nil];
            }
            //            [button setBackgroundColor:[UIColor blueColor]];
            [self addSubview:button];
        }
    }
}


- (UIButton *)setFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag imge:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    return button;
}

- (void)handerPress:(UITapGestureRecognizer *)gesture
{
    if (self.delegate != nil) {
        [_delegate buttonPressString:@"close"];
    }
}

- (void)showCustomKeyBoard
{
    if (self) {
        
    }else{
        //        [self removeFromSuperview];
    }
}


- (void)showAnimation
{
    CABasicAnimation *anima=[CABasicAnimation animation];
    //1.1告诉系统要执行什么样的动画
    anima.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(UIScreenSize.width/2, UIScreenSize.height)];
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(UIScreenSize.width/2, UIScreenSize.height - currentFrame.size.height + currentFrame.size.height/2)];
    
    //1.2设置动画执行完毕之后不删除动画
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //2.添加核心动画到layer
    [self.layer addAnimation:anima forKey:nil];
}

- (void)hidderAnimation
{
    CABasicAnimation *anima=[CABasicAnimation animation];
    //1.1告诉系统要执行什么样的动画
    anima.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(UIScreenSize.width/2, UIScreenSize.height - currentFrame.size.height + currentFrame.size.height/2)];
    anima.toValue=[NSValue valueWithCGPoint:CGPointMake(UIScreenSize.width/2, UIScreenSize.height)];
    
    //1.2设置动画执行完毕之后不删除动
    anima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    anima.fillMode=kCAFillModeForwards;
    //2.添加核心动画到layer
    [self.layer addAnimation:anima forKey:nil];
}

- (void)hidderCustomKeyBoard
{
    [UIView animateWithDuration:5.0 animations:^{
        [self hidderAnimation];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)buttonPress:(UIButton *)sender
{
    //    NSLog(@"%@",[dicArray objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]);
    if (self.delegate != nil) {
        [_delegate buttonPressString:[dicArray objectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]];
    }
}

@end
