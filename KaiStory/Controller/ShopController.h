//
//  ShopController.h
//  KaiStory
//
//  Created by mac on 15/2/6.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewContr.h"
//@protocol checkSeletecellDelgate <NSObject>
//-(void)checkseletecells:(NSString*)str1;
//@end
@interface ShopController : BaseViewContr<UITableViewDelegate,UITableViewDataSource>{
    UIView *flickView;
    UIButton *backButon;
    NSMutableArray * array;
    UIImageView *images;
    UILabel *timeLabe;
    UILabel *mintimeLabe;
    UIImageView *countimage;
    UILabel *countLabe;
    UILabel *selfLabe;
    UIButton *backButons;
    NSMutableArray *countArrary;
}


@property (weak, nonatomic) IBOutlet UIButton *customButton;

@property (weak, nonatomic) IBOutlet UIButton *sleepRecomend;

@property (weak, nonatomic) IBOutlet UIButton *mySleepRecomend;

//@property (assign ,nonatomic)id<checkSeletecellDelgate>checkdelegate;

@end
