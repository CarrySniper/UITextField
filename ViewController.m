//
//  ViewController.m
//  UITextField的创建与使用
//
//  Created by CK_chan on 15-2-9.
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
    self.navigationItem.title = @"UITextField登陆页";
    
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 40, 25)];
    accountLabel.backgroundColor = [UIColor clearColor];
    accountLabel.text = @"账号";
    [self.view addSubview:accountLabel];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 40, 25)];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    
    
    self.accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-60, 25)];
    [self.view addSubview:self.accountTextField];
    self.accountTextField.delegate = self;
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 140, self.view.frame.size.width-60, 25)];
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.delegate = self;
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, 300, 30)];
    textField.placeholder = @"textField";
    [self.view addSubview:textField];
    
    textField.delegate = self;
    
    textField.borderStyle = UITextBorderStyleRoundedRect;//圆角
    
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 500, 300, 30)];
    textField1.placeholder = @"textField1";
    [self.view addSubview:textField1];
    
    textField1.delegate = self;textField1.borderStyle = UITextBorderStyleRoundedRect;//圆角
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(70, 200, self.view.frame.size.width-100, 30);
    loginButton.backgroundColor = [UIColor purpleColor];
    [loginButton setTitle:@"登   陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    loginButton.layer.cornerRadius = 6;
    //设置样式属性
    self.accountTextField.borderStyle = UITextBorderStyleRoundedRect;//圆角
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    //设置提示文字属性
    self.accountTextField.placeholder = @"请输入账号（10个中文以内）";
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
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}
static CGFloat keyboardHeight;
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    keyboardHeight = keyboardRect.size.height + 10;
}
//计算键盘抬起高度
- (void)fitKeyboard:(UITextField *)textField{
    
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + (keyboardHeight > 216 ? keyboardHeight : 256)) ;
    
    NSLog(@"aa %f",keyboardHeight);
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
            
        }];
    }
}
- (void)btnClick:(UIButton*)sender{
    
    NSString *accountStr = self.accountTextField.text;
    NSString *passwordStr = self.passwordTextField.text;
    
    NSString *message = [NSString stringWithFormat:@"账号：%@  密码：%@",accountStr,passwordStr];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登陆" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
    [alertView show];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"将要开始编辑？");
    
    
    
    return YES;
}// return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑。");

    [self fitKeyboard:textField];
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"将要结束编辑？");

    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
        
    }];
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑。");
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"将要改变内容？");
    
   [self fitKeyboard:textField];
    
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
