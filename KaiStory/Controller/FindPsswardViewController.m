//
//  FindPsswardViewController.m
//  KaiStory
//
//  Created by yangpeng on 15/2/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "FindPsswardViewController.h"
#import "LoginDataService.h"
#import "Tools.h"
@interface FindPsswardViewController (){

    NSTimer*timer;
   
}

@end

@implementation FindPsswardViewController
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     self.titleView.frame = CGRectMake((FRAME_WIDTH-81)/2, 39, 81, 17);
    self.inputView.frame = CGRectMake((FRAME_WIDTH-self.inputView.bounds.size.width)/2, 107, self.inputView.bounds.size.width, self.inputView.bounds.size.height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

      self.phoneNumber.delegate = self;
 }




- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendCode:(id)sender {
    if (self.phoneNumber.text.length>0) {
    BOOL sucess = [self isPureNumandCharacters:self.phoneNumber.text];
    if(sucess){
        NSDate *sendate = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
        NSString *  locationString=[dateformatter stringFromDate:sendate];
        NSLog(@"loag==%@",locationString);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNumber.text,@"mobile",locationString,@"timestamp" ,nil];
        
        [LoginDataService requestAFURL:@"/sys/send_sms?appid=xx&app_ver=1.0&json_ver=&lng=&lat=" httpMethod:@"POST" params:dic data:nil complection:^(id result) {
            NSLog(@"result==%@",result);
            NSString *code = [result objectForKey:@"code"];
            NSInteger CODE = [code integerValue];
            if (CODE==200) {
                NSLog(@"发送成功");
                
            }else if(CODE == 102){
                NSLog(@"参数错误，为空格式错误等");
                
            }
            else if (CODE == 500){
                
                NSLog(@"服务器错误");
            }
            
        }];
        
        if (mCountDown>0) {
            NSLog(@"%s %d",__FUNCTION__,__LINE__);
            return;
        }
        
        mCountDown =59;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
    }else {
        NSLog(@"请输入正确的用户名和手机号");
    }
    }else{
    
        NSLog(@"手机号码不能为空");
    }
    
}

- (IBAction)cerTainButton:(id)sender {
    if ((self.resetPassword.text=nil)) {
        NSLog(@"请输入新密码");
    }else{
        NSMutableDictionary *passwordDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNumber.text,@"mobile",self.codeMessage.text,@"code",self.resetPassword.text,@"new_password", nil];
    [LoginDataService requestAFURL:@"/user/forget_password" httpMethod:@"POST" params:passwordDic data:nil complection:^(id result) {
        
        NSLog(@"result==%@",result);
        NSString *code = [result objectForKey:@"code"];
        NSInteger CODE = [code integerValue];
        if (CODE==200) {
            
            
        }else if(CODE == 102){
            NSLog(@"参数错误，为空格式错误等");
            
        }
        else if (CODE == 500){
            
            NSLog(@"服务器错误");
            
        }else if (CODE ==103){
            
        NSLog(@"短信码错误");
        
        
        }

    }];
    
    
    
    }
    
}

//定时器方法
- (void)timerFireMethod:(NSTimer*)theTimer{
    mCountDown--;
    if (mCountDown>0) {
        [self.sendCode setUserInteractionEnabled:NO];
        [self.sendCode setTitleColor:[UIColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1] forState:UIControlStateNormal];
        [self.sendCode setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)mCountDown] forState:UIControlStateNormal];
    }
    
    if (mCountDown<0) {
        [timer invalidate];
        [self.sendCode setUserInteractionEnabled:YES];
        [self.sendCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendCode setTitle:@"重新获取" forState:UIControlStateNormal];
        
    }
    
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNumber resignFirstResponder];
    [self.codeMessage resignFirstResponder];
    [self.resetPassword resignFirstResponder];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.phoneNumber) {
        NSString *temp = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (temp.length > 11) {
            textField.text = [temp substringToIndex:11];
            NSLog(@"%s %d",__FUNCTION__,__LINE__);
            return NO;
        }
        NSLog(@"%s %d",__FUNCTION__,__LINE__);
        return YES;
    }
    else{//密码
        return YES;
    }


}
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        NSLog(@"请输入正确的手机号");
        return NO;
        
    }
    NSLog(@"输入正确");
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
