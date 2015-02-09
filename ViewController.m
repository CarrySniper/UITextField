//
//  ViewController.m
//  UITextField的创建与使用
//
//  Created by 陈家庆 on 15-2-9.
//  Copyright (c) 2015年 shikee_Chan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 30)];
    [self.view addSubview:self.accountTextField];
    self.accountTextField.delegate = self;
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 120, self.view.frame.size.width-20, 30)];
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.delegate = self;
    
    //设置样式属性
    self.accountTextField.borderStyle = UITextBorderStyleRoundedRect;//圆角
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    //设置提示文字属性
    self.accountTextField.placeholder = @"请输入账号";
    self.passwordTextField.placeholder = @"请输入密码";
    
    //设置文字颜色属性
    self.accountTextField.textColor = [UIColor purpleColor];
    self.passwordTextField.textColor = [UIColor purpleColor];
    
    //设置文字字体属性
    self.accountTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    self.passwordTextField.font = [UIFont boldSystemFontOfSize:15.0f];
    
    //设置背景图片属性
    self.accountTextField.background = [UIImage imageNamed:@""];
    self.passwordTextField.background = [UIImage imageNamed:@""];
    
    //设置左右视图属性
    self.accountTextField.leftView = [[UIView alloc]init];
    self.passwordTextField.leftView = [[UIView alloc]init];
    
    self.accountTextField.rightView = [[UIView alloc]init];
    self.passwordTextField.rightView = [[UIView alloc]init];
    
    //设置最小字体属性
    self.accountTextField.minimumFontSize = 5;
    self.passwordTextField.minimumFontSize = 5;
    
    //设置清除按钮显示模式属性
    self.accountTextField.clearButtonMode = UITextFieldViewModeAlways;//总是
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置左右视图按钮显示模式属性
    self.accountTextField.leftViewMode = UITextFieldViewModeWhileEditing;//当处于编辑状态
    self.passwordTextField.leftViewMode = UITextFieldViewModeWhileEditing;
    
    self.accountTextField.rightViewMode = UITextFieldViewModeUnlessEditing;//除了编辑状态情况下
    self.passwordTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
    
    /*
     ***输入属性
     */
    //设置输入键盘样式属性
    self.accountTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
    
    //设置输入键盘样式属性
    self.accountTextField.returnKeyType = UIReturnKeyNext;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    
    //密码内容安全输入
    self.passwordTextField.secureTextEntry = YES;
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"将要开始编辑？");
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑。");
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"将要结束编辑？");
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑。");
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"将要改变内容？");
    
    NSUInteger maxLength = 10;
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            NSLog(@"将要-------%@",position);
            if (toBeString.length > maxLength) {
                textField.text = [toBeString substringToIndex:maxLength];
                return NO;
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > maxLength && range.length!=1) {
            textField.text = [toBeString substringToIndex:maxLength];
            return NO;
        }
    }
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"将要清除内容？");
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"将要点击Return键？");
    
    if ([self.accountTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}// called when 'return' key pressed. return NO to ignore.

/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
