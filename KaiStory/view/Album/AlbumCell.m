//
//  AlbumCell.m
//  KaiStory
//
//  Created by yangpeng on 15/4/10.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (void)awakeFromNib {
    
    
    [self.storyImage setImage:[UIImage imageNamed:@"backGround"]];
    
    self.albumName =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 30)];
    [self addSubview:self.albumName];

}


- (void)setStorymdoel:(SortItem *)storymdoel {

    _storymdoel = storymdoel;



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
