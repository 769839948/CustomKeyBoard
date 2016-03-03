//
//  CustomKeyboard.h
//  好好修车技师版
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 观微科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomKeyboardDelegate <NSObject>

- (void)buttonPressString:(NSString *)string;

@end

@interface CustomKeyboard : UIView


@property (nonatomic, weak) id<CustomKeyboardDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

- (void)showCustomKeyBoard;

- (void)hidderCustomKeyBoard;

@end
