//
//  customcellTableViewCell.m
//  KaiStory
//
//  Created by yangpeng on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "customViewsCell.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
@implementation customViewsCell{

    NSInteger index;

}

- (void)awakeFromNib {
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        
    }
    
    
    return self;
}
- (void)setdataModel:(Allstroymodel *)models{
    self.models = models;
    [self setNeedsLayout];
    }
- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger imleft = 20;
    NSInteger imtop = 10;
    NSInteger imwidth = 150;
    NSInteger imheight = 95;
    stroyImage = [[UIImageView alloc]initWithFrame:CGRectMake(imleft*RESIZE_RATIO,
                                                              imtop*RESIZE_RATIO,
                                                              imwidth*RESIZE_RATIO,
                                                              imheight*RESIZE_RATIO)];
    
    [self.contentView addSubview:stroyImage];
    [stroyImage sd_setImageWithURL:[NSURL URLWithString:self.models.icon_url]];
    NSInteger titleleft = 14+imleft+imwidth;
    NSInteger top = 13;
    NSInteger width = 300;
    NSInteger height = 20;
    NSInteger lablesize = 28;
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectMake(titleleft*RESIZE_RATIO,
                                                          top*RESIZE_RATIO,
                                                          width*RESIZE_RATIO,
                                                          height*RESIZE_RATIO)];
    titleLable.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
    
    titleLable.text = self.models.name;
    titleLable.textColor = [UIColor ColorWithHexString:@"b1b1b1"];
    [self .contentView addSubview:titleLable];
    
    NSInteger authorleft = 14+imleft+imwidth;
    NSInteger authortop = top+height+10;
    NSInteger widths = 300;
    NSInteger heights = 10;
    NSInteger lablesizes = 18;
    authorLable = [[UILabel alloc]initWithFrame:CGRectMake(authorleft*RESIZE_RATIO,
                                                           authortop*RESIZE_RATIO,
                                                           widths*RESIZE_RATIO,
                                                           heights*RESIZE_RATIO)];
    
    authorLable.font = [UIFont systemFontOfSize:lablesizes*RESIZE_RATIO];
    
    authorLable.text = self.models.author;
    authorLable.textColor = [UIColor ColorWithHexString:@"b1b1b1"];
    [self .contentView addSubview:authorLable];
    
    
    NSInteger sleft = 15;
    NSInteger stops = 0;
    NSInteger swidth = 28;
    NSInteger sheight = 28;
    countlabes = [[UILabel alloc]initWithFrame:CGRectMake(sleft*RESIZE_RATIO,
                                                                   stops*RESIZE_RATIO,
                                                                   swidth*RESIZE_RATIO,
                                                                   sheight*RESIZE_RATIO)];
    countlabes.center = CGPointMake(imleft*RESIZE_RATIO, imtop*RESIZE_RATIO+4);
    
    countlabes.layer.cornerRadius = swidth*RESIZE_RATIO/2;
    countlabes.layer.masksToBounds = YES;
    countlabes.backgroundColor = [UIColor ColorWithHexString:@"88d295"];
    NSLog(@"model___________==%ld",(long)self.models.counts);
    NSString *strings = [NSString stringWithFormat:@"%ld",(long)self.models.counts];
    countlabes.text = strings;
    countlabes.textColor = [UIColor whiteColor];
    countlabes.font = [UIFont systemFontOfSize:11];
    countlabes.textAlignment = NSTextAlignmentCenter;
    [self.contentView insertSubview:countlabes aboveSubview:stroyImage];
    
//    NSInteger sleft = 15;
//    NSInteger stops = 10/2;
//    NSInteger swidth = 28;
//    NSInteger sheight = 27;
//    UIImageView *countimages = [[UIImageView alloc]initWithFrame:CGRectMake(sleft*RESIZE_RATIO,
//                                                                            stops*RESIZE_RATIO,
//                                                                            swidth*RESIZE_RATIO,
//                                                                            sheight*RESIZE_RATIO)];
//    countimages.center = CGPointMake(imleft*RESIZE_RATIO, imtop*RESIZE_RATIO);
//    
//    countimages.image = [UIImage imageNamed:@"shuzijiaobiao"];
//    [self.contentView addSubview:countimages];

    
    
    NSArray *imageArrary = @[@"xiangshangjiantou",@"xiangxiajiantou",@"jiayishou",@"jianyishou",@"shandiao"];
    NSInteger buttonleft = 14+imleft+imwidth;
    NSInteger buttop = authortop+16;
    NSInteger btwidth =45;
    NSInteger btheight = 45;
    for (int i=0; i<imageArrary.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((buttonleft*RESIZE_RATIO+i*btwidth*RESIZE_RATIO)+15*i*RESIZE_RATIO,
                                  buttop*RESIZE_RATIO,
                                  btwidth*RESIZE_RATIO,
                                  btheight*RESIZE_RATIO);
        NSString *name = imageArrary[i];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        button.tag = i;
        [self.contentView addSubview:button];
        
        [button addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}
- (void)butAction:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 2) {
        countlabes.hidden = NO;
        index+=1;
        NSString *counts = [NSString stringWithFormat:@"%ld",(long)index];
        self.models.counts = index;
        countlabes.text = counts;
    }if (button.tag==3&&index>=1) {
        index-=1;
        NSString *counts = [NSString stringWithFormat:@"%ld",(long)index];
        self.models.counts = index;
        countlabes.text = counts;
    }
    
    if ([self.cellsDelegate respondsToSelector:@selector(deletecells:tag:)]) {
        UIButton*button = (UIButton*)sender;
        [self.cellsDelegate deletecells:self.tag tag:button.tag];
        
        
        
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
