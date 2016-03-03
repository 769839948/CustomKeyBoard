//
//  UITextField+ExtentRange.h
//  Test
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end
