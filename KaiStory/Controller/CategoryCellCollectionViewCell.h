//
//  CategoryCellCollectionViewCell.h
//  KaiStory
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Allstroymodel.h"
@protocol seletecellDelgate <NSObject>
-(void)seletecells:(NSInteger)index;
@end
@interface CategoryCellCollectionViewCell : UICollectionViewCell{
    UIButton * detailBt;
    UIImageView *imageview ;
    UILabel *titlelables;
    UILabel *auolables;
}

@property(strong,nonatomic)UIImageView *imgeView;
@property(strong,nonatomic)UIView *partyView;
@property(strong,nonatomic)UIView *labeview;
@property(assign,nonatomic)BOOL isSelect;
@property(strong,nonatomic)UIImageView*selectImage;
@property(strong,nonatomic)Allstroymodel *stromodel;
@property(strong,nonatomic) UILabel *titlelabel;
@property(strong,nonatomic) UILabel *miniutes ;
@property(strong,nonatomic) UILabel *auolabel;
@property(strong,nonatomic)UILabel *contlable;
-(void)setmodel:(Allstroymodel*)stroymide;

@property (nonatomic,assign)id<seletecellDelgate>cellsDelegate;
@end
