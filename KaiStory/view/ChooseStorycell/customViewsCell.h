//
//  customcellTableViewCell.h
//  KaiStory
//
//  Created by yangpeng on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Allstroymodel.h"
@protocol deletecellDelgate <NSObject>
-(void)deletecells:(NSInteger)index tag:(NSInteger)butag;
@end

@interface customViewsCell : UITableViewCell{

    UIImageView *stroyImage;
    UILabel *titleLable;
    UILabel *authorLable;
    UIImageView *countimage;
    UILabel *countlabes;



}
@property (nonatomic,assign)id<deletecellDelgate>cellsDelegate;
@property (nonatomic,strong)Allstroymodel*models;
-(void)setdataModel:(Allstroymodel*)models;
@end
