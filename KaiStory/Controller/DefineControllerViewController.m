//
//  DefineControllerViewController.m
//  KaiStory
//
//  Created by yangpeng on 15/4/21.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "DefineControllerViewController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "CategoryViewController.h"
@interface DefineControllerViewController (){
    UIImageView *imageViews;


}

@end

@implementation DefineControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ColorWithHexString:@"e4f2ee"];
    [self creatsleepAction];
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkseletecells:) name:@"cumstom" object:nil];
 }
-(void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatsleepAction{
    
    NSInteger bttop = 76+64;
    NSInteger btleft = 32;
    NSInteger btwidth = 565;
    NSInteger btheight = 73;
    NSInteger lablesize = 38;
    UIButton *addstroy = [UIButton buttonWithType:UIButtonTypeCustom];
    addstroy.frame = CGRectMake(btleft*RESIZE_RATIO,
                                bttop*RESIZE_RATIO,
                                btwidth*RESIZE_RATIO,
                                btheight*RESIZE_RATIO);
    
    [addstroy setBackgroundImage:[UIImage imageNamed:@"xuangushipng"] forState:UIControlStateNormal];
    [addstroy setTitle:@"添加故事" forState:UIControlStateNormal];
    addstroy .titleLabel.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
    [self.view addSubview:addstroy];
    [addstroy addTarget:self action:@selector(addActions:) forControlEvents:UIControlEventTouchUpInside];

    NSInteger imtop =bttop +40+73;
    NSInteger imleft = 40;
    NSInteger imwidth = 565;
    NSInteger imheight = 421;
    
    imageViews = [[UIImageView alloc]initWithFrame:CGRectMake(imleft*RESIZE_RATIO,
                                                                           imtop*RESIZE_RATIO,
                                                                           imwidth*RESIZE_RATIO,
                                                                           imheight*RESIZE_RATIO)];
    imageViews.image = [UIImage imageNamed:@"gushikuang"];
    
    [self.view addSubview:imageViews];
    
    NSInteger toLeft =190;
    NSInteger totop = 80;
    NSInteger towidth = 212;
    NSInteger tohight = 158;

    UIImageView *touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(toLeft*RESIZE_RATIO,
                                                                             totop*RESIZE_RATIO,
                                                                             towidth*RESIZE_RATIO,
                                                                              tohight*RESIZE_RATIO)];
    
    
    
    

    touxiangImage.image = [UIImage imageNamed:@"kaishubiao"];
    
    [imageViews addSubview:touxiangImage];
    
    NSInteger laleft =0;
    NSInteger latop = totop +60+tohight;
    NSInteger lawidth = imwidth;
    NSInteger laheight = 20;
    NSInteger sizes = 26;
    UILabel *tilable  = [[UILabel alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                                 latop*RESIZE_RATIO,
                                                                 lawidth*RESIZE_RATIO,
                                                                 laheight*RESIZE_RATIO)];
    
    
    
    tilable.text = @"你 定 制 了 25 分 钟 的 故 事";
    tilable.font = [UIFont systemFontOfSize:sizes*RESIZE_RATIO];
    tilable.textColor = [UIColor ColorWithHexString:@"88d295"];
    tilable.textAlignment = NSTextAlignmentCenter;
    [imageViews addSubview:tilable];
    
    NSInteger timeleft = 0;
    NSInteger timetop = latop+laheight+6;
    NSInteger timewidth =imwidth;
    NSInteger timeheight = 20;
    UILabel *tilables  = [[UILabel alloc]initWithFrame:CGRectMake(timeleft*RESIZE_RATIO,
                                                                 timetop*RESIZE_RATIO,
                                                                 timewidth*RESIZE_RATIO,
                                                                 timeheight*RESIZE_RATIO)];
    
    
    
    tilables.text = @"请 点 击 “添 加 故 事”按 钮 开 启 定 制 时 光";
    tilables.font = [UIFont systemFontOfSize:sizes*RESIZE_RATIO];
    tilables.textColor = [UIColor ColorWithHexString:@"88d295"];
    tilables.textAlignment = NSTextAlignmentCenter;
    [imageViews addSubview:tilables];
    
    
    NSInteger sleeppoem = imtop+68+imheight;
    NSInteger sleepleft = 40;
    NSInteger  sleepwidth = 561;
    NSInteger sleepheight  = 211;
    UIImageView *sleepPoem = [[UIImageView alloc]initWithFrame:CGRectMake(sleepleft*RESIZE_RATIO,
                                                                          sleeppoem*RESIZE_RATIO,
                                                                          sleepwidth*RESIZE_RATIO,
                                                                          sleepheight*RESIZE_RATIO)];
    sleepPoem.userInteractionEnabled = YES;
    sleepPoem.image = [UIImage imageNamed:@"shikuang"];
    sleepPoem.userInteractionEnabled = YES;
    [self.view addSubview:sleepPoem];
    
    NSInteger sleeplefts = sleepwidth-26-40;
    NSInteger sltop = 26;
    NSInteger slwidth =40;
    NSInteger slheight = 41;
    UIButton *addpoem = [UIButton buttonWithType:UIButtonTypeCustom];
    addpoem.frame = CGRectMake(sleeplefts*RESIZE_RATIO,
                               sltop*RESIZE_RATIO,
                               slwidth*RESIZE_RATIO,
                               slheight*RESIZE_RATIO);
    
    [addpoem setBackgroundImage:[UIImage imageNamed:@"jiahao1"] forState:UIControlStateNormal];
    [sleepPoem addSubview:addpoem];
    [addpoem addTarget:self action:@selector(addpoemActions:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger leftla = 60;
    NSInteger topla = 105;
    NSInteger  widthla = 320;
    NSInteger  height = 40;
    NSInteger labsizes = 32;
    UILabel *addpoems = [[UILabel alloc]initWithFrame:CGRectMake(leftla*RESIZE_RATIO,
                                                                 topla*RESIZE_RATIO,
                                                                 widthla*RESIZE_RATIO,
                                                                 height*RESIZE_RATIO)];
    
    addpoems.textColor = [UIColor ColorWithHexString:@"88d295"];
    addpoems.text = @"要 不 要 加 首 睡 前 诗";
    addpoems.font =[UIFont systemFontOfSize:labsizes*RESIZE_RATIO];
    
    [sleepPoem addSubview:addpoems];
    
    NSInteger lft =leftla+widthla+10;
    NSInteger tops =sltop+slheight+20;
    NSInteger imawidth = 128;
    NSInteger imaheight = 50;
    
    UIImageView *plaineimage = [[UIImageView alloc]initWithFrame:CGRectMake(lft*RESIZE_RATIO,
                                                                            tops*RESIZE_RATIO,
                                                                            imawidth*RESIZE_RATIO,
                                                                            imaheight*RESIZE_RATIO)];
    plaineimage.image = [UIImage imageNamed:@"feiji"];
    
    [sleepPoem addSubview:plaineimage];


   
}
- (void)addActions:(id)sender{
    
    CategoryViewController *category = [[CategoryViewController alloc]initWithConfig:@"哄睡" withBackBtn:YES];
    
//    [self.navigationController pushViewController:category animated:YES];
    [self presentViewController:category animated:YES completion:^{
        
    }];


}

- (void)addpoemActions:(id)sender{




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)creatFlashView{
    NSInteger left=0;
    NSInteger top = 64;
    NSInteger with =FRAME_WIDTH;
    NSInteger height =FRAME_HEIGHT-64;
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(left, top, with, height)];
    backgroundView.image = [UIImage imageNamed:@"zhezhao"];
    [self.view addSubview:backgroundView];
    backgroundView.userInteractionEnabled = YES;
    
    NSInteger flleft = 50;
    NSInteger fltop = 266;
    NSInteger flwidth =541;
    NSInteger flheight = 354;
    UIImageView *flashImage = [[UIImageView alloc]initWithFrame:CGRectMake(flleft*RESIZE_RATIO,
                                                                           fltop*RESIZE_RATIO,
                                                                           flwidth*RESIZE_RATIO,
                                                                           flheight*RESIZE_RATIO)];
    
    flashImage.image = [UIImage imageNamed:@"tanchukuang"];
    
    [backgroundView addSubview:flashImage];
    
    NSInteger laleft = 60;
    NSInteger latop = 94;
    NSInteger lawidth =445;
    NSInteger laheight = 35;
    NSInteger lasize = 36;
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                              latop*RESIZE_RATIO,
                                                              lawidth*RESIZE_RATIO,
                                                              laheight*RESIZE_RATIO)];
    lable.text = @"要 不 要 加 首 睡 前 诗?";
    lable.font = [UIFont systemFontOfSize:lasize];
    [flashImage addSubview:lable];


}
@end
