//
//  ViewController.m
//  CustomeKeyBoard
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Zhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomKeyboard.h"
#import "UITextField+ExtentRange.h"

#define ButtonWidth [[UIScreen mainScreen] bounds].size.width/4
#define ButtonHeight 40

#define UIScreenSize [[UIScreen mainScreen] bounds].size

@interface ViewController ()<UITextFieldDelegate,CustomKeyboardDelegate>

@property (nonatomic, strong) CustomKeyboard *keyBoard;

@property (nonatomic, strong) UIButton *button;


@property (nonatomic, strong) UITextField *inputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _inputField = [[UITextField alloc] init];
    _inputField.layer.borderWidth = 1;
    _inputField.layer.borderColor = [[UIColor blueColor] CGColor];
    _inputField.placeholder = @"请输入";
    _inputField.delegate = self;
    _inputField.layer.cornerRadius = 10;
    _inputField.frame = CGRectMake(10, 50, UIScreenSize.width-130, 40);
    _inputField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_inputField];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(UIScreenSize.width-100, 50, 80, 40)];
    _button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _button.layer.borderWidth = 1.0;
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitle:@"取消输入" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)buttonPress:(UIButton *)sender
{
    [self enderEdilt];
}

#pragma mark - 创建自定义键盘
- (void)setUpKeyBoard
{
    NSArray *array = @[@"B",@"C",@"P",@"U",@"1",@"2",@"3",@"-",@"4",@"5",@"6",@"+",@"7",@"8",@"9",@"search",@"close",@"0",@"delete",@"search",];
    _keyBoard = [[CustomKeyboard alloc] initWithFrame:CGRectMake(0, 90, UIScreenSize.width, UIScreenSize.height - 90) titleArray:array];
    _keyBoard.backgroundColor = [UIColor whiteColor];
    _keyBoard.delegate = self;
    //    _keyBoard.backgroundColor = [UIColor redColor];
    [self.view addSubview:_keyBoard];
}

- (void)enderEdilt
{
    [_inputField endEditing:YES];
    [_keyBoard hidderCustomKeyBoard];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setUpKeyBoard];
}

#pragma mark - CustomKeyBoardDelegate
- (void)buttonPressString:(NSString *)string
{
    NSRange range = [_inputField selectedRange];
    if ([string isEqualToString:@"close"]) {
        [self enderEdilt];
    }else if ([string isEqualToString:@"delete"] && range.location > 0){
        NSMutableString *textFile = [[NSMutableString alloc] initWithString:_inputField.text];
        [textFile deleteCharactersInRange:NSMakeRange(range.location - 1, 1)];
        
        _inputField.text = textFile;
        [_inputField setSelectedRange:NSMakeRange(range.location - 1, 0)];
    }else if ([string isEqualToString:@"-"] && range.location > 0){
        NSRange range = [_inputField selectedRange];
        [_inputField setSelectedRange:NSMakeRange(range.location - 1, 0)];
    }else if ([string isEqualToString:@"+"] && range.location < _inputField.text.length){
        NSRange range = [_inputField selectedRange];
        [_inputField setSelectedRange:NSMakeRange(range.location + 1, 0)];
        
    }else if(![string isEqualToString:@"delete"] && ![string isEqualToString:@"-"] && ![string isEqualToString:@"+"]&&![string isEqualToString:@"search"]) {
        NSRange range = [_inputField selectedRange];
        NSMutableString *textFile = [[NSMutableString alloc] initWithString:_inputField.text];
        [textFile insertString:string atIndex:range.location];
        _inputField.text = textFile;
        [_inputField setSelectedRange:NSMakeRange(range.location + 1, 0)];
    }else if ([string isEqualToString:@"search"]){
        [self enderEdilt];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
