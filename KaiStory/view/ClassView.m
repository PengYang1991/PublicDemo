//
//  ClassView.m
//  KaiStory
//
//  Created by yangpeng on 15/3/19.
//  Copyright (c) 2015年 yangpeng. All rights reserved.
//

#import "ClassView.h"
#import "Tools.h"
#import "UIViewExt.h"
#import "UIColor+HexStringToColor.h"
#import "LoginDataService.h"


@implementation ClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrameRect:(CGRect)frame dataArray:(NSArray *)data
{
    if (self = [super initWithFrame:frame]) {
        self .backgroundColor = [UIColor ColorWithHexString:@"#e4f2ee"];
        category = [NSMutableArray array];
        if (data==nil) {
            return nil;
        }else{
        [category addObjectsFromArray:data ];
        [self creatCategory];
        
        self.m_StoryListArray = [NSMutableArray array];
      }
   }
    
    return self;
}
- (void)creatCategory{
    butArrry  = [NSMutableArray array];
    CGFloat width = 204;
    CGFloat height = 112;
    CGFloat gapWidth = (640-width*3)/2;
    CGFloat gapHeight = (266-height*2)/3;
    for (NSInteger col=0; col<3; col++) {
        for (NSInteger row=0; row<2; row++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((width+gapWidth)*RESIZE_RATIO*col,
                                      height*row*RESIZE_RATIO+(row+1)*gapHeight*RESIZE_RATIO,
                                      width*RESIZE_RATIO,
                                      height*RESIZE_RATIO);
            button.backgroundColor = [UIColor ColorWithHexString:@"#ffacac"];
            [butArrry addObject:button];
            [self addSubview:button];
        }
        
    }
    
    for (NSInteger s=0; s<butArrry.count; s++) {
        UIButton *button = [butArrry objectAtIndex:s];
        button.tag = s+100;
        self.findeItem = [category objectAtIndex:s];
        NSString *name = self.findeItem.name;
        //        NSString *urlstring = self.findeItem.icon_url;
        //        NSURL *url = [NSURL URLWithString:urlstring];
        //        NSData *data = [NSData dataWithContentsOfURL:url];
        //        UIImage *image = [UIImage  imageWithData:data];
        //        button.backgroundColor = [UIColor colorWithPatternImage:image];
        [button setTitle:name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


- (void)categoryAction:(id)sender{
    
    if ([sender isKindOfClass:[UIButton class]]) {
        
        UIButton *button = sender;
        
        NSInteger i = button.tag-100;
        
        self.findeItem = [category objectAtIndex:i];
        NSString *method = self.findeItem.open_method;
        NSString *openurl = self.findeItem.open_url;
        NSString *param = self.findeItem.open_params ;
        NSString *opentype = self.findeItem.open_type;
        NSLog(@"______________method==%@______openurl==%@,opentype==%@,op==%@",method,opentype,openurl,param);
        if (param!=nil) {
            if (i==5)
            {
                NSLog(@"分类更多按钮被点击");
                
                [self.m_StoryDetailDelegate EnterClassList];
                
            }else
            {
                //                [LoginDataService requestAFURL1:openurl httpMethod:method params:nil data:nil complection:^(id result) {
                //                    NSLog(@"__________result==%@",result);
                //
                //                    NSLog(@"___________resut==%@",result);
                //                    NSDictionary *Result = result[@"result"];
                //                    NSString *verson = [Result objectForKey:@"version"];
                //                    NSLog(@"verson=====%@",verson);
                //                    NSDictionary *view_content = [Result objectForKey:@"view_content"];
                //                    NSLog(@"view_content======%@",view_content);
                //                    NSDictionary *showData= [view_content objectForKey:@"show_data"];
                //                    NSLog(@"showData========%@",showData);
                //                    NSDictionary *category= [showData objectForKey:@"category"];
                //
                //                    CategoryModel *categorymodel = [[CategoryModel alloc]initWithDict:category];
                //
                //                    NSLog(@"Category=====%@",categorymodel);
                //                    NSLog(@"Category=====%@",categorymodel.banner_url);
                //                    NSDictionary *mediaList = [showData objectForKey:@"media_list"];
                //                    NSLog(@"mediaList=====%@",mediaList);
                //                    NSArray *DataList = [showData objectForKey:@"media_list"];
                //                    NSLog(@"mediaList=====%@",DataList);
                //                    for (NSDictionary * dic in DataList) {
                //                        StoryModel *model = [[StoryModel alloc]initWithDict:dic];
                //                        NSLog(@"s_________=%@",model);
                //                        [self.m_StoryListArray addObject:model];
                //                    }
                //                    [self.m_StoryDetailDelegate EnterStoryDetail:self.m_StoryListArray category:self.findeItem];
                //
                //                }];
                [self.m_StoryDetailDelegate EnterAlbumList:self.findeItem];
                
            }
            
        }else if (param.length>0){
            
            NSMutableDictionary*params = [NSMutableDictionary dictionaryWithObjectsAndKeys:param,@"open_params ", nil];
            
            [LoginDataService requestAFURL1:openurl httpMethod:method params:params data:nil complection:^(id result) {
                NSLog(@"__________result==%@",result);
                
            }];
            
        }
        
        if ([opentype isEqualToString:@""]) {//通过opentype来判断跳转的控制器
            
            
        }
        
        
    }
}








@end
