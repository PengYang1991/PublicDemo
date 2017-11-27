//
//  CustomizedViewController.h
//  KaiStory
//
//  Created by yangpeng on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "customViewsCell.h"
#import "Allstroymodel.h"
@interface CustomizedViewController : BaseViewContr<UITableViewDelegate,UITableViewDataSource,deletecellDelgate,UITextFieldDelegate>{
    
    UIImageView *imageviews ;
    UIImageView *backgroundView ;
    NSString *titlestring;
    UIButton *modelButton;
    UITextField *edittext;
    }

@property(nonatomic,strong)UITableView*stroylist;
@property(nonatomic,strong)Allstroymodel *stroymodel;
@end
