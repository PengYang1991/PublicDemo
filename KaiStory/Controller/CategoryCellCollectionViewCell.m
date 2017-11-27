//
//  CategoryCellCollectionViewCell.m
//  KaiStory
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CategoryCellCollectionViewCell.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "UIImageView+WebCache.h"
@implementation CategoryCellCollectionViewCell

- (void)awakeFromNib {
    
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        [self creatstoryBackgroundView];
    }
    return  self;
}

- (void)creatstoryBackgroundView{
    NSInteger width = 276;
    NSInteger height = 240;
    self.imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                 width*RESIZE_RATIO,
                                                                 height*RESIZE_RATIO)];
    [self addSubview:self.imgeView];
    NSInteger top = 240;
    NSInteger heights = 90;
    self.partyView = [[UIView alloc]initWithFrame:CGRectMake(0, top*RESIZE_RATIO,
                                                             width*RESIZE_RATIO,
                                                             heights*RESIZE_RATIO)];
    
    self.partyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.partyView];
    
    
    NSInteger btleft = 218;
    NSInteger bttop = 20;
    NSInteger widths = 48;
    NSInteger heightbt = 49;
    
    detailBt = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBt.frame = CGRectMake(btleft*RESIZE_RATIO,
                                bttop*RESIZE_RATIO,
                                widths*RESIZE_RATIO,
                                heightbt*RESIZE_RATIO);
    [detailBt setTitle:@"我的最爱" forState:UIControlStateNormal];
    [detailBt setBackgroundImage:[UIImage imageNamed:@"kaishushuo"] forState:UIControlStateNormal];
    [detailBt setTitle:@"" forState:UIControlStateNormal];
    [detailBt setBackgroundImage:[UIImage imageNamed:@"kaishushuoweidianji(1)"] forState:UIControlStateSelected];
    [self addSubview:detailBt];
    [detailBt addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self initTextField];
    
    NSInteger imleft = 0;
    NSInteger imtop = 0;
    NSInteger imwidth = 278;
    NSInteger imheight= 330;
    self.selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(imleft*RESIZE_RATIO,
                                                                    imtop*RESIZE_RATIO,
                                                                    imwidth*RESIZE_RATIO,
                                                                    imheight*RESIZE_RATIO)];
    
    self.selectImage.userInteractionEnabled = YES;
    self.selectImage.image = [UIImage imageNamed:@"xuanzhongzhezhao"];
    NSInteger rightleft = 80;
    NSInteger righttop = 108;
    NSInteger rightwidth = 126;
    NSInteger rightheight = 86;
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(rightleft*RESIZE_RATIO,
                                                             righttop*RESIZE_RATIO,
                                                             rightwidth*RESIZE_RATIO, rightheight*RESIZE_RATIO)];
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:@"xuanzhongduigou"];
    [self.selectImage addSubview:imageview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction:)];
    [self.selectImage addGestureRecognizer:tap];
    [self insertSubview:self.selectImage aboveSubview:detailBt];
    self.selectImage.hidden = YES;
    
    NSInteger leftima = 0;
    NSInteger topima = 50;
    NSInteger heightss = 30;
    NSInteger lablesize = 14;
    self.miniutes = [[UILabel  alloc]initWithFrame:CGRectMake(leftima*RESIZE_RATIO,
                                                                  topima*RESIZE_RATIO,
                                                                  width*RESIZE_RATIO,
                                                                  heightss*RESIZE_RATIO)];
    
    self.miniutes.text = @"3.00";
    NSLog(@"%@",self.miniutes.text);
    self.miniutes.textColor = [UIColor ColorWithHexString:@"4cc49e"];
    self.miniutes.textAlignment = NSTextAlignmentCenter;
    self.miniutes.font = [UIFont systemFontOfSize:lablesize *RESIZE_RATIO];
    [self.partyView addSubview:self.miniutes];
    
    
    NSInteger lefttit = 0;
    NSInteger topitit = 0;
    NSInteger heighttit = 30;
    NSInteger titlsize = 20;
    self.titlelabel = [[UILabel  alloc]initWithFrame:CGRectMake(lefttit*RESIZE_RATIO,
                                                                    topitit*RESIZE_RATIO,
                                                                    width*RESIZE_RATIO,
                                                                    heighttit*RESIZE_RATIO)];
    
     self.titlelabel.text = @"title";
    NSLog(@"%@",_miniutes.text);
    //    miniutes.backgroundColor = [UIColor purpleColor];
     self.titlelabel.textColor = [UIColor ColorWithHexString:@"4cc49e"];
     self.titlelabel.textAlignment = NSTextAlignmentCenter;
     self.titlelabel.font = [UIFont systemFontOfSize:titlsize*RESIZE_RATIO];
    [self.partyView addSubview: self.titlelabel];
    
    
    NSInteger leftauo = 0;
    NSInteger topizuo = 28;
    NSInteger heightzuo = 30;
    NSInteger titlauosize = 16;
    self.auolabel = [[UILabel  alloc]initWithFrame:CGRectMake(leftauo*RESIZE_RATIO,
                                                                  topizuo*RESIZE_RATIO,
                                                                  width*RESIZE_RATIO,
                                                                  heightzuo*RESIZE_RATIO)];
    
    self.auolabel.text =@"爱上你就";
    NSLog(@"%@",_miniutes.text);
    self.auolabel.textColor = [UIColor ColorWithHexString:@"4cc49e"];
    self.auolabel.textAlignment = NSTextAlignmentCenter;
    self.auolabel.font = [UIFont systemFontOfSize:titlauosize*RESIZE_RATIO];
    [self.partyView addSubview:self.auolabel];

}

- (void)detailAction:(id)sender{
    UIButton * detailButton = (UIButton*)sender;
    detailButton.selected = !detailButton.selected;
    if (detailButton.selected) {
        //        imageview.hidden = NO;
        self.labeview.hidden = NO;
        
    }else {
        
        self.labeview.hidden = YES;
        //        imageview.hidden = YES;
        
    }
}
- (void)initTextField{
    NSInteger laleft = 0;
    NSInteger latop = 36;
    NSInteger width = 276;
    NSInteger height = 290;
    
    self.labeview = [[UIView alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                            latop*RESIZE_RATIO,
                                                            width*RESIZE_RATIO,
                                                            height*RESIZE_RATIO)];
    self.labeview .backgroundColor = [UIColor whiteColor];
    [self insertSubview:self.labeview belowSubview:detailBt];
    [self creatDetail];
    self.labeview.hidden = YES;
    
}
- (void)setIsSelect:(BOOL)isSelect{
    if (isSelect) {
        [self selectImageView:isSelect];
    }else{
        
        return;
        
        
    }
    
}

- (void)selectImageView:(BOOL)select{
    if (select) {
        self.selectImage.hidden = NO;
        
    }else{
        
        self.selectImage.hidden = YES;
    }
}

- (void)cancelAction:(id)sender{
    self.selectImage.hidden = YES;
    if ([self.cellsDelegate respondsToSelector:@selector(seletecells:)]) {
        
        [self.cellsDelegate seletecells:self.tag];

    }
}
-(void)setmodel:(Allstroymodel *)stroymide{
    
    self.stromodel = stroymide;
    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:self.stromodel.icon_url]];
    self.titlelabel.text = self.stromodel.name;
    NSInteger  minutes = self.stromodel.duration;
    NSString *minutess = [self converTimer:minutes];
    self.miniutes.text = minutess;
    if (self.stromodel.author.length<=0) {
        self.auolabel.text = @"阿森纳";
    }else{
        self.auolabel.text =self.stromodel.author;
    }
    self.contlable.text = self.stromodel.kaishu_say;
    titlelables.text = self.stromodel.name;
    if (self.stromodel.author.length<=0) {
        auolables.text = @"阿森纳";
    }else{
        auolables.text =self.stromodel.author;
    }

}
- (NSString *)converTimer:(NSInteger)t {
    
    NSInteger m = t/60;
    NSInteger s = t%60;
    
    NSString *timeString = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)m,(long)s];
    
    return timeString;
}
- (void)creatDetail{
    NSInteger leftitt = 0;
    NSInteger toptit = 44;
    NSInteger heighttit = 25;
    NSInteger width = 276;
    NSInteger titlauosize = 20;
    titlelables = [[UILabel  alloc]initWithFrame:CGRectMake(leftitt*RESIZE_RATIO,
                                                                    toptit*RESIZE_RATIO,
                                                                    width*RESIZE_RATIO,
                                                                    heighttit*RESIZE_RATIO)];
    
    titlelables.text =self.stromodel.name;
    titlelables.textColor = [UIColor ColorWithHexString:@"4cc49e"];
    titlelables.textAlignment = NSTextAlignmentCenter;
    titlelables.font = [UIFont systemFontOfSize:titlauosize*RESIZE_RATIO];
    [self.labeview addSubview:titlelables];
    
    
    NSInteger leftauo = 0;
    NSInteger toptauo = toptit+heighttit;
    NSInteger heightauo = 25;
    NSInteger auolauosize = 16;
    auolables = [[UILabel  alloc]initWithFrame:CGRectMake(leftauo*RESIZE_RATIO,
                                                                  toptauo*RESIZE_RATIO,
                                                                  width*RESIZE_RATIO,
                                                                  heightauo*RESIZE_RATIO)];
    if (self.stromodel.author.length<=0) {
        auolables.text = @"阿森纳";
    }else{
        auolables.text =self.stromodel.author;
    }
    auolables.textColor = [UIColor ColorWithHexString:@"4cc49e"];
    auolables.textAlignment = NSTextAlignmentCenter;
    auolables.font = [UIFont systemFontOfSize:auolauosize*RESIZE_RATIO];
    [self.labeview addSubview:auolables];
    
    
    NSInteger leftcont = 0;
    NSInteger topcont = toptauo+20;
    NSInteger heightcont = 290-50;
    NSInteger contlauosize = 14;
    self.contlable = [[UILabel  alloc]initWithFrame:CGRectMake(leftcont*RESIZE_RATIO,
                                                                   topcont*RESIZE_RATIO,
                                                                   width*RESIZE_RATIO,
                                                                   heightcont*RESIZE_RATIO)];
    
    self.contlable.text =self.stromodel.kaishu_say;
    self.contlable.textColor = [UIColor ColorWithHexString:@"4cc49e"];
    //    contlable.textAlignment = nste;
    self.contlable.textAlignment = UIControlContentVerticalAlignmentTop;
    self.contlable.font = [UIFont systemFontOfSize:contlauosize*RESIZE_RATIO];
    self.contlable.lineBreakMode = NSLineBreakByWordWrapping;
    self.contlable.numberOfLines=0;
    [self.labeview addSubview:self.contlable];
    
}

@end
