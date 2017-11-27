//
//  Wheelcell.m
//  KaiStory
//
//  Created by yangpeng on 15/4/30.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "Wheelcell.h"
#import "Tools.h"
@implementation Wheelcell

- (void)awakeFromNib {
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        self.lables = [[UILabel alloc]initWithFrame:CGRectMake(10*RESIZE_RATIO, -3, 30, 30)];
        [self.contentView addSubview:self.lables];
        self.lables.text = @"1";
    }

    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
