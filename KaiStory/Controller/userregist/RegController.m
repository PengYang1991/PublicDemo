//
//  RegController.m
//  KaiStory
//
//  Created by yanzehua on 15/4/18.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "RegController.h"
#import "Tools.h"
#import "UserInfo.h"
#import "UIColor+HexStringToColor.h"
#import "LoginDataService.h"
#import "MyDataService.h"

@implementation RegController

-(void) initLayout
{
    int const backImgMarginLeft = 56;
    int const backImgMarginTop = 24;
    int const backImgWidth = 547;
    int const backImgHeight = 430;
    
    UIImageView* backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(backImgMarginLeft*RESIZE_RATIO, backImgMarginTop*RESIZE_RATIO, backImgWidth*RESIZE_RATIO, backImgHeight*RESIZE_RATIO) ];
    [backImgView setImage:[UIImage imageNamed:@"信息框5排"]];
    [self.contentView addSubview:backImgView];
    
    int const lableFontSize = 26;
    NSString* labelFontColorStr = @"656f6d";
    
    int const userLabelMarginLeft = 100;
    int const userLabelMarginTop = backImgMarginTop + 36;
    int const userLabelWidth = 26*3;
    int const userLabelHeight = 26;
    UILabel* userLabel = [[UILabel alloc] initWithFrame:CGRectMake(userLabelMarginLeft*RESIZE_RATIO, userLabelMarginTop*RESIZE_RATIO, userLabelWidth*RESIZE_RATIO, userLabelHeight*RESIZE_RATIO)];
    userLabel.font = [UIFont systemFontOfSize:userLabelHeight*RESIZE_RATIO];
    userLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    userLabel.text = @"用户名";
    [self.contentView addSubview:userLabel];
    
    int const babyLabelMarginLeft = 100;
    int const babyLabelMarginTop = backImgMarginTop + 120;
    int const babyLabelWidth = 26*4;
    int const babyLabelHeight = 26;
    UILabel* babyLabel = [[UILabel alloc] initWithFrame:CGRectMake(babyLabelMarginLeft*RESIZE_RATIO, babyLabelMarginTop*RESIZE_RATIO, babyLabelWidth*RESIZE_RATIO, babyLabelHeight*RESIZE_RATIO)];
    babyLabel.font = [UIFont systemFontOfSize:babyLabelHeight*RESIZE_RATIO];
    babyLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    babyLabel.text = @"宝宝昵称";
    [self.contentView addSubview:babyLabel];
    
    int const phoneLabelMarginLeft = 100;
    int const phoneLabelMarginTop = backImgMarginTop + 204;
    int const phoneLabelWidth = 26*3;
    int const phoneLabelHeight = 26;
    UILabel* phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabelMarginLeft*RESIZE_RATIO, phoneLabelMarginTop*RESIZE_RATIO, phoneLabelWidth*RESIZE_RATIO, phoneLabelHeight*RESIZE_RATIO)];
    phoneLabel.font = [UIFont systemFontOfSize:phoneLabelHeight*RESIZE_RATIO];
    phoneLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    phoneLabel.text = @"手机号";
    [self.contentView addSubview:phoneLabel];
    
    int const captchaLabelMarginLeft = 100;
    int const captchaLabelMarginTop = backImgMarginTop + 288;
    int const captchaLabelWidth = 26*3;
    int const captchaLabelHeight = 26;
    UILabel* captchaLabel = [[UILabel alloc] initWithFrame:CGRectMake(captchaLabelMarginLeft*RESIZE_RATIO, captchaLabelMarginTop*RESIZE_RATIO, captchaLabelWidth*RESIZE_RATIO, captchaLabelHeight*RESIZE_RATIO)];
    captchaLabel.font = [UIFont systemFontOfSize:phoneLabelHeight*RESIZE_RATIO];
    captchaLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    captchaLabel.text = @"验证码";
    [self.contentView addSubview:captchaLabel];
    
    int const pwdLabelMarginLeft = 100;
    int const pwdLabelMarginTop = backImgMarginTop + 372;
    int const pwdLabelWidth = 26*3;
    int const pwdLabelHeight = 26;
    UILabel* pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(pwdLabelMarginLeft*RESIZE_RATIO, pwdLabelMarginTop*RESIZE_RATIO, pwdLabelWidth*RESIZE_RATIO, pwdLabelHeight*RESIZE_RATIO)];
    pwdLabel.font = [UIFont systemFontOfSize:phoneLabelHeight*RESIZE_RATIO];
    pwdLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    pwdLabel.text = @"密码";
    [self.contentView addSubview:pwdLabel];
    
    int const userTxtMarginLeft = 220;
    int const userTxtMarginTop = userLabelMarginTop;
    int const userTxtWidth = 300;
    int const userTxtHeight = 26;
    self.userTxt = [[UITextField alloc] initWithFrame:CGRectMake(userTxtMarginLeft*RESIZE_RATIO, userTxtMarginTop*RESIZE_RATIO, userTxtWidth*RESIZE_RATIO, userTxtHeight*RESIZE_RATIO)];
    self.userTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.userTxt.placeholder = @"请输入用户名";
    self.userTxt.delegate = self;
    [self.contentView addSubview:self.userTxt];
    
    int const babyTxtMarginLeft = 220;
    int const babyTxtMarginTop = babyLabelMarginTop;
    int const babyTxtWidth = 300;
    int const babyTxtHeight = 26;
    self.babyTxt = [[UITextField alloc] initWithFrame:CGRectMake(babyTxtMarginLeft*RESIZE_RATIO, babyTxtMarginTop*RESIZE_RATIO, babyTxtWidth*RESIZE_RATIO, babyTxtHeight*RESIZE_RATIO)];
    self.babyTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.babyTxt.placeholder = @"请输入宝宝昵称";
    self.babyTxt.delegate = self;
    [self.contentView addSubview:self.babyTxt];
    
    int const phoneTxtMarginLeft = 220;
    int const phoneTxtMarginTop = phoneLabelMarginTop;
    int const phoneTxtWidth = 300;
    int const phoneTxtHeight = 26;
    self.phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(phoneTxtMarginLeft*RESIZE_RATIO, phoneTxtMarginTop*RESIZE_RATIO, phoneTxtWidth*RESIZE_RATIO, phoneTxtHeight*RESIZE_RATIO)];
    self.phoneTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTxt.placeholder = @"请输入手机号";
    self.phoneTxt.delegate = self;
    [self.contentView addSubview:self.phoneTxt];
    
    int const captchaTxtMarginLeft = 220;
    int const captchaTxtMarginTop = captchaLabelMarginTop;
    int const captchaTxtWidth = 300;
    int const captchaTxtHeight = 26;
    self.captchaTxt = [[UITextField alloc] initWithFrame:CGRectMake(captchaTxtMarginLeft*RESIZE_RATIO, captchaTxtMarginTop*RESIZE_RATIO, captchaTxtWidth*RESIZE_RATIO, captchaTxtHeight*RESIZE_RATIO)];
    self.captchaTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.captchaTxt.placeholder = @"请输入验证码";
    self.captchaTxt.keyboardType = UIKeyboardTypePhonePad;
    self.captchaTxt.delegate = self;
    [self.contentView addSubview:self.captchaTxt];
    
    int const captchaBtnMarginLeft = 440;
    int const captchaBtnMarginTop = captchaLabelMarginTop;
    int const captchaBtnWidth = 150;
    int const captchaBtnHeight = 34;
    self.captchaBtn = [[UIButton alloc] initWithFrame:CGRectMake(captchaBtnMarginLeft*RESIZE_RATIO, captchaBtnMarginTop*RESIZE_RATIO, captchaBtnWidth*RESIZE_RATIO, captchaBtnHeight*RESIZE_RATIO)];
    [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.captchaBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:20*RESIZE_RATIO];
    [self.captchaBtn setBackgroundImage:[UIImage imageNamed:@"验证码背景.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.captchaBtn];
    [self.captchaBtn addTarget:self action:@selector(captchaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *userDeFaults = [NSUserDefaults standardUserDefaults];
    NSString *lastCaptchaSecStr = [userDeFaults objectForKey:@"captchaTime"];
    NSInteger lastCaptchaSec = [lastCaptchaSecStr integerValue];
    NSDate* currentDate = [NSDate date];
    NSInteger currentSec =currentDate.timeIntervalSince1970;
    if(currentSec - lastCaptchaSec <= 60)
    {
        NSLog(@"CURRENT %@ %ld",currentDate,currentSec);
        self.captchaCount = 60- (currentSec - lastCaptchaSec);
        [self.captchaBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",self.captchaCount] forState:UIControlStateNormal];
        self.captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    }
    
    int const pwdTxtMarginLeft = 220;
    int const pwdTxtMarginTop = pwdLabelMarginTop;
    int const pwdTxtWidth = 300;
    int const pwdTxtHeight = 26;
    self.pwdTxt = [[UITextField alloc] initWithFrame:CGRectMake(pwdTxtMarginLeft*RESIZE_RATIO, pwdTxtMarginTop*RESIZE_RATIO, pwdTxtWidth*RESIZE_RATIO, pwdTxtHeight*RESIZE_RATIO)];
    self.pwdTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.pwdTxt.placeholder = @"请输入6位以上密码";
    self.pwdTxt.secureTextEntry = YES;
    //self.pwdTxt.keyboardType = UIKeyboardTypePhonePad;
    self.pwdTxt.delegate = self;
    [self.contentView addSubview:self.pwdTxt];
    
    
    int const btnMarginLeft = 56;
    int const btnMarginTop =  backImgMarginTop + backImgHeight + 254;
    int const btnWidth = 547;
    int const btnHeight = 90;
    UIButton* regBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnMarginLeft*RESIZE_RATIO,btnMarginTop*RESIZE_RATIO,btnWidth*RESIZE_RATIO,btnHeight*RESIZE_RATIO)];
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [regBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:30*RESIZE_RATIO];
    [regBtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:regBtn];
    [regBtn addTarget:self action:@selector(regBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) initSexLayout
{
    int const backImgMarginTop = 24;
    int const backImgHeight = 430;
    int const sexInfoTop = backImgMarginTop+backImgHeight+30;
    int const sexInfoHeight = 30;
    
    int const boyImgBtnMarginLeft = 135;
    int const girlImgBtnMarginLeft = 361;
    int const btnImgSize = 30;
    int const btnFontSize = 30;
    int const boyBtnMarginLeft = boyImgBtnMarginLeft + 30;
    int const girlBtnMarginLeft = girlImgBtnMarginLeft + 30;
    NSString* boyBtnFontColor = @"45b29a";
    NSString* girlBtnFontColor = @"ff6869";
    int const btnWidth = 100;
    int const btnHeight = 30;
    
    self.boyImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(boyImgBtnMarginLeft*RESIZE_RATIO, sexInfoTop*RESIZE_RATIO, btnImgSize*RESIZE_RATIO, btnImgSize*RESIZE_RATIO)];
    [self.boyImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_back.png"] forState:UIControlStateNormal];
    self.girlImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(girlImgBtnMarginLeft*RESIZE_RATIO, sexInfoTop*RESIZE_RATIO, btnImgSize*RESIZE_RATIO, btnImgSize*RESIZE_RATIO)];
    [self.girlImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_back.png"] forState:UIControlStateNormal];
    UIButton* boyBtn = [[UIButton alloc]initWithFrame:CGRectMake(boyBtnMarginLeft*RESIZE_RATIO, sexInfoTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    [boyBtn setTitle:@"男宝宝" forState:UIControlStateNormal];
    [boyBtn setTitleColor:[UIColor ColorWithHexString:boyBtnFontColor]forState:UIControlStateNormal];
    boyBtn.titleLabel.font = [UIFont systemFontOfSize:30*RESIZE_RATIO];
    UIButton* girlBtn = [[UIButton alloc]initWithFrame:CGRectMake(girlBtnMarginLeft*RESIZE_RATIO, sexInfoTop*RESIZE_RATIO, btnWidth*RESIZE_RATIO, btnHeight*RESIZE_RATIO)];
    [girlBtn setTitle:@"女宝宝" forState:UIControlStateNormal];
    [girlBtn setTitleColor:[UIColor ColorWithHexString:girlBtnFontColor]forState:UIControlStateNormal];
    girlBtn.titleLabel.font = [UIFont systemFontOfSize:30*RESIZE_RATIO];
    
    [self.boyImgBtn addTarget:self action:@selector(boyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.girlImgBtn addTarget:self action:@selector(girlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [boyBtn addTarget:self action:@selector(boyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [girlBtn addTarget:self action:@selector(girlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.babySex = [Tools getBabySex];

    [self updateUserSex];
    
    [self.contentView addSubview:self.boyImgBtn];
    [self.contentView addSubview:self.girlImgBtn];
    [self.contentView addSubview:boyBtn];
    [self.contentView addSubview:girlBtn];
}


-(void) initBirthdayInfo
{
    int const backImgMarginLeft = 56;
    int const backImgMarginTop = 24+430+100;
    int const backImgWidth = 547;
    int const backImgHeight = 104;
    
    UIImageView* backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(backImgMarginLeft*RESIZE_RATIO, backImgMarginTop*RESIZE_RATIO, backImgWidth*RESIZE_RATIO, backImgHeight*RESIZE_RATIO) ];
    [backImgView setImage:[UIImage imageNamed:@"信息框1排"]];
    [self.contentView addSubview:backImgView];
    
    int const birthdayLabelMarginLeft = 100;
    int const birthdayLabelMarginTop = backImgMarginTop + 36;
    int const birthdayLabelWidth = 26*4;
    int const birthdayLabelHeight = 26;
    int const lableFontSize = 26;
    NSString* labelFontColorStr = @"656f6d";
    UILabel* birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake( birthdayLabelMarginLeft*RESIZE_RATIO,  birthdayLabelMarginTop*RESIZE_RATIO,  birthdayLabelWidth*RESIZE_RATIO,  birthdayLabelHeight*RESIZE_RATIO)];
    birthdayLabel.font = [UIFont systemFontOfSize: birthdayLabelHeight*RESIZE_RATIO];
    birthdayLabel.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    birthdayLabel.text = @"宝贝生日";
    [self.contentView addSubview:birthdayLabel];
    
    int const birthdayTxtMarginLeft = 220;
    int const birthdayTxtMarginTop = birthdayLabelMarginTop;
    int const birthdayTxtWidth = 300;
    int const birthdayTxtHeight = 26;
    self.birthdayTxt = [[UITextField alloc] initWithFrame:CGRectMake(birthdayTxtMarginLeft*RESIZE_RATIO, birthdayTxtMarginTop*RESIZE_RATIO, birthdayTxtWidth*RESIZE_RATIO, birthdayTxtHeight*RESIZE_RATIO)];
    self.birthdayTxt.textColor = [UIColor ColorWithHexString:labelFontColorStr];
    self.birthdayTxt.placeholder = @"请选择宝宝的生日";
    self.birthdayTxt.delegate = self;
    [self.contentView addSubview:self.birthdayTxt];
    
}

-(void) updateUserSex
{
    if(1 == self.babySex)
    {
        [self.boyImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_boy.png"] forState:UIControlStateNormal];
        [self.girlImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_back.png"] forState:UIControlStateNormal];
    }else
    {
        [self.boyImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_back.png"] forState:UIControlStateNormal];
        [self.girlImgBtn setBackgroundImage:[UIImage imageNamed:@"radio_girl.png"] forState:UIControlStateNormal];
    }
}

-(void) initPopUpView
{
    self.popupView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, FRAME_HEIGHT)];
    self.popupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBirthday:)];
    [self.popupView addGestureRecognizer:tapGesture];
    
    int const containerHeight= 500;
    UIView* containerView = [[UIView alloc]initWithFrame:CGRectMake(0, FRAME_HEIGHT - containerHeight*RESIZE_RATIO-64, FRAME_WIDTH, containerHeight*RESIZE_RATIO)];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"BG.png"]];
    containerView.backgroundColor = bgColor;
    [self.popupView addSubview:containerView];
    
    int const datePickerMarginLeft = 0;
    int const datePickerMarginTop = 0;
    int const datePickerHeight = 300;
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(datePickerMarginLeft*RESIZE_RATIO, datePickerMarginTop*RESIZE_RATIO, FRAME_WIDTH, datePickerHeight*RESIZE_RATIO)];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    [containerView addSubview:self.datePicker];
    
    
    int const btnMarginLeft = 56;
    int const btnMarginTop =  350;
    int const btnWidth = 547;
    int const btnHeight = 90;
    UIButton* chooseBirthdayBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnMarginLeft*RESIZE_RATIO,btnMarginTop*RESIZE_RATIO,btnWidth*RESIZE_RATIO,btnHeight*RESIZE_RATIO)];
    [chooseBirthdayBtn setTitle:@"确定" forState:UIControlStateNormal];
    [chooseBirthdayBtn setTitleColor:[UIColor ColorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    chooseBirthdayBtn.titleLabel.font = [UIFont systemFontOfSize:30*RESIZE_RATIO];
    [chooseBirthdayBtn setBackgroundImage:[UIImage imageNamed:@"登陆按钮.png"] forState:UIControlStateNormal];
    [chooseBirthdayBtn addTarget:self action:@selector(chooseBirthday:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:chooseBirthdayBtn];
}

-(void) showPopUpView
{
    [self.view addSubview: self.popupView];
}

-(void) hidePopUpView
{
    [self.popupView removeFromSuperview];
}

-(void)chooseBirthday:(id)sender
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:self.datePicker.date];
    self.birthdayTxt.text = dateStr;
    [self hidePopUpView];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.birthdayTxt)
    {
        [self showPopUpView];
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ColorWithHexString:@"e2f2ee"];
    self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, FRAME_WIDTH, FRAME_HEIGHT)];
    self.contentView.contentSize =CGSizeMake(FRAME_WIDTH, 800*RESIZE_RATIO);
    
    [self initLayout  ];
    [self initSexLayout ];
    [self initBirthdayInfo ];
    [self initPopUpView ];
    [self.view addSubview:self.contentView];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick:)];
    [self.contentView addGestureRecognizer:tapGesture];
    [self.userTxt becomeFirstResponder];
    
}

-(void)captchaBtnClick:(id)sender
{
    NSString* phoneNum = self.phoneTxt.text;
    if(phoneNum.length == 11)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNum,@"mobile" ,nil];
        [LoginDataService requestAFURL:@"/sys/send_sms?appid=xx&app_ver=1.0&json_ver=&lng=&lat=" httpMethod:@"POST" params:dict data:nil complection:^(id result) {
        NSLog(@"result==%@",result);
        NSString *code = [result objectForKey:@"code"];
        NSInteger CODE = [code integerValue];
        if (CODE==200) {
            NSLog(@"发送成功");
        }else{
            NSLog(@"短信码错误");
        }
         }];
        
        self.captchaCount = 59;
        self.captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        NSUserDefaults *userDeFaults = [NSUserDefaults standardUserDefaults];
        NSDate* currentDate = [NSDate date];
        NSInteger currentSec =currentDate.timeIntervalSince1970;
        [userDeFaults setObject:[NSString stringWithFormat:@"%ld",currentSec] forKey:@"captchaTime"];
        [self.captchaBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.captchaCount] forState:UIControlStateNormal];
        NSLog(@"CURRENT %@ %ld",currentDate,currentSec);
    }
}

//定时器方法
- (void)timerFireMethod:(NSTimer*)theTimer{
    self.captchaCount--;
    if (self.captchaCount>0) {
        [self.captchaBtn setUserInteractionEnabled:NO];
        [self.captchaBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.captchaCount] forState:UIControlStateNormal];
    }else
    {
        [self.captchaTimer invalidate];
        [self.captchaBtn setUserInteractionEnabled:YES];
        [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

-(void)boyBtnClick:(id)sender
{
    [self resignAllResponder];
    self.babySex = 1;
    [self updateUserSex];
}

-(void)girlBtnClick:(id)sender
{
    [self resignAllResponder];
    self.babySex = 0;
    [self updateUserSex];
    
}

-(BOOL) checkAvail
{
    if(self.userTxt.text.length==0)
        return NO;
    if(self.babyTxt.text.length==0)
        return NO;
    if(self.phoneTxt.text.length==0)
        return NO;
    if(self.captchaTxt.text.length==0)
        return NO;
    if(self.pwdTxt.text.length==0)
        return NO;
    if(self.birthdayTxt.text.length==0)
        return NO;
    return YES;
}
-(void) requestUserInfo:(NSString*) userId accessToken:(NSString*) accessToken
{
    NSString *url = @"/api/user/index";
    NSString *appid=@"1.0";
    NSString *app_ver = @"1.0";
    NSString *json_ver = @"0.1";
    
    NSString *ln = @"33.332";
    NSString *lat = @"199.3232";
    
    NSMutableDictionary *dir = [NSMutableDictionary dictionaryWithObjectsAndKeys:appid,@"appid",app_ver,@"app_ver",json_ver,@"json_ver",ln,@"lng",lat,@"lat",userId,@"user_id",accessToken,@"token",nil];
    [MyDataService requestAFURL:url httpMethod:@"POST" params:dir data:nil complection:^(id result) {
        NSLog(@"___________result=======%@",result);
        NSString *codeStr = [result objectForKey:@"code"];
        NSInteger code = [codeStr integerValue];
        if(200 == code)
        {
            NSDictionary *res = [result objectForKey:@"result"];
            NSDictionary *userinfo = [res objectForKey:@"userinfo"];
            UserInfo* user = [[UserInfo alloc]initWithDict:userinfo];
            
            //  保存状态数据
            NSUserDefaults *userDeFaults = [NSUserDefaults standardUserDefaults];
            [userDeFaults setValue:user.user_name forKey:@"userName"];
            [userDeFaults setValue:user.baby_name forKey:@"babyName"];
            [userDeFaults setValue:user.mobile forKey:@"mobile"];
            [userDeFaults setValue:user.age forKey:@"babyAge"];
            [userDeFaults setValue:user.birthday forKey:@"birthday"];
            [userDeFaults setValue:user.listen_count forKey:@"listenCount"];
            [userDeFaults setValue:user.continue_listen_day forKey:@"continueListenDay"];
            [userDeFaults setValue:user.continue_listen_day forKey:@"listenTotalTime"];
            [userDeFaults setValue:user.favor_count forKey:@"favorCount"];
            [userDeFaults setValue:@"1" forKey:@"loginStatus"];
            [userDeFaults setValue:accessToken forKey:@"accessToken"];
            [userDeFaults setValue:userId forKey:@"userId"];
            NSLog(@"UserSex %@",user.sex);
            if([user.sex isEqualToString:@"m"])
            {
                [Tools setBabySex:1];
            }else
            {
                [Tools setBabySex:0];
            }
            [userDeFaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:^(){}];
        }
    }
     
     ];
    
}

-(void)regBtnClick:(id)sender
{
    [self resignAllResponder];
    if ([self checkAvail]) {
        NSString* babySex = @"f";
        if (self.boyImgBtn.selected) {
            babySex = @"m";
        }
        NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.userTxt.text,@"user_name",self.phoneTxt.text,@"mobile",self.captchaTxt.text,@"code",self.babyTxt.text,@"baby_name",self.pwdTxt.text,@"password",babySex,@"sex",self.birthdayTxt.text,@"birthday", nil];
        
        [LoginDataService requestAFURL:@"/user/register?appid=xx&app_ver=1.0&json_ver=&lng=&lat=" httpMethod:@"POST" params:dics data:nil complection:^(id result) {
            
            NSLog(@"SFS==%@",result);
            NSString *code = [result objectForKey:@"code"];
            NSInteger CODE = [code integerValue];
            if (CODE==200) {
                NSLog(@"发送成功");
                NSDictionary *tokenDic = [result objectForKey:@"result"];
                NSDictionary *token = [tokenDic objectForKey:@"token"];
                NSString *accestoken = [token objectForKey:@"access_token"];
                NSString *userId = [token objectForKey:@"user_id"];

                // 请求用户的基础信息
                [self requestUserInfo:userId accessToken:accestoken];
                
            }else if(CODE == 102){
                NSLog(@"参数错误，为空格式错误等");
                return ;
            }
            else if (CODE == 500){
                
                NSLog(@"服务器错误");
                return ;
                
            }else if (CODE ==103){
                
                NSLog(@"短信码错误");
                
                return;
            }else if(CODE ==101){
                
                NSLog(@"手机号已被注册");
            }
        }];
        
        
    }else{
        
        NSLog(@"请把资料填写完整");
        return;
        
    }

}

-(void) resignAllResponder
{
    [self.userTxt resignFirstResponder];
    [self.babyTxt resignFirstResponder];
    [self.phoneTxt resignFirstResponder];
    [self.pwdTxt resignFirstResponder];
    [self.captchaTxt resignFirstResponder];
}

-(void) backgroundClick:(id)sender
{
    [self resignAllResponder];
}

-(void)backBtnAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end