//
//  ClassPropertyView.h
//  KaiStory
//
//  Created by mac on 15/4/15.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

@protocol EnterDetailClassDelegate <NSObject>
-(void)EnterStoryDetail:(PropertyModel *)propertymodel;
@end



@interface ClassPropertyView : UIView

-(id)initWithFrameRect:(CGRect)frame dataSource:(ClassModel *)data :(NSInteger)i;

@property(strong,nonatomic)NSString *titleName;
@property(strong,nonatomic)ClassModel *model;


@property (nonatomic,assign)id<EnterDetailClassDelegate>EnterClassDetailDelegate;
@end
