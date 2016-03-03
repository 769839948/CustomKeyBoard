自定义键盘按钮
====
使用方法
-------
```
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
```
 ![image](https://github.com/769839948/CustomKeyBoard/blob/master/CustomeKeyBoard/screenshots/vim-screenshot.jpg)
 ![image](https://github.com/769839948/CustomKeyBoard/blob/master/CustomeKeyBoard/screenshots/vim_1.gif)
 ![image](https://github.com/769839948/CustomKeyBoard/blob/master/CustomeKeyBoard/screenshots/vim_1.gif)
