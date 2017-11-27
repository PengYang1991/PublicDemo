//
//  DailyDetailControl.h
//  KaiStory
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "DailyModel.h"
#import "ShareView.h"

@interface DailyDetailControl : BaseViewContr<UIWebViewDelegate,ShareDelegate>
@property(nonatomic,assign)NSString* m_DailyID;
@property(nonatomic,strong)NSString* m_URL;


@property (strong,nonatomic)DailyModel * m_CurrentModel;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *favorBtn;

@property (strong, nonatomic) IBOutlet UILabel *favorCount;
@property (strong, nonatomic) IBOutlet UILabel *Share_count;
@property (strong, nonatomic) IBOutlet UILabel *Comment_count;


@property (strong, nonatomic) IBOutlet UILabel *artileTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *releaseLabel;

@property(strong,nonatomic)UIImage *tt;


- (IBAction)BackAction:(id)sender;


@end
