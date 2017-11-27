//
//  ClassViewController.h
//  KaiStory
//
//  Created by mac on 15/4/14.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "BaseViewContr.h"
#import "ClassListVIew.h"



@interface ClassViewController : BaseViewContr<EnterDetailClassDelegate>
{
    UIScrollView *scorllView;
}

@property(strong,nonatomic)NSMutableArray *dataSoure;
@property(strong,nonatomic)NSMutableArray *propertyViewArray;

@property(strong,nonatomic)NSMutableArray *propertyListArray;

@property(strong,nonatomic)NSString * m_updateIndex;



-(void)LoadData;
@end
