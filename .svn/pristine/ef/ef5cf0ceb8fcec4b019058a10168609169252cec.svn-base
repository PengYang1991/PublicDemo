//
//  ImageScrollerView.m
//  Bistone
//
//  Created by Apple on 15/1/13.
//  Copyright (c) 2015年 yangpeng  Apple. All rights reserved.
//

#import "ImageScrollerView.h"
#import "UIImageView+AFNetworking.h"
#import "Tools.h"
#import "UIImageView+WebCache.h"
#import "LunBoWebController.h"
#define UISCREENWIDTH  self.frame.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度
#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标
static CGFloat const chageImageTime = 3.0f;

@implementation ImageScrollerView
{
    UIButton *beginBtn;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
//    BOOL _isTimeUp;
//    NSTimer * _moveTime;

}
@synthesize delegate;

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
    
    if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        if (imgArr==nil) {
            return nil;
        }else{
        //TODO 这部分代码到底用来干嘛？
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
        // 把imgArr中最后一幅图像加入位置0
        [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
        // 把imgArr中第一副图像追加到末尾
        [tempArray addObject:[imgArr objectAtIndex:0]];
        imageArray=[NSArray arrayWithArray:tempArray];
        viewSize=rect;
        NSUInteger pageCount=[imageArray count];
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        for (int i=0; i<pageCount; i++) {
            NSString *imgURL=[imageArray objectAtIndex:i];
            NSURL *url = [NSURL URLWithString:imgURL];
            UIImageView *imgView=[[UIImageView alloc] init];
            if ([imgURL hasPrefix:@"http://"]) {
                //网络图片 请使用ego异步图片库
                [imgView sd_setImageWithURL:url];
            }
            else
            {
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                [imgView setImage:img];
            }
            [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
            imgView.tag=i;
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            //NSLog(@"%lf",imgView.frame.origin.x);
            [scrollView addSubview:imgView];
        }
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        //[scrollView setContentOffset:CGPointMake(viewSize.size.width*5, 0)];
        [self addSubview:scrollView];
        
        
        
        //说明文字层
        UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
        [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
        
        float pageControlWidth=(pageCount-2)*10.0f+40.f;
        float pagecontrolHeight=20.0f;
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth),6, pageControlWidth, pagecontrolHeight)];
//        pageControl.backgroundColor = [UIColor redColor];
        pageControl.currentPage=0;
        pageControl.numberOfPages=(pageCount-2);
        [noteView addSubview:pageControl];
        [noteView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:noteView];
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
    }
}
    return self;
}
#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage

{
//    CGFloat pageWidth = scrollView.frame.size.width;
//    if((int)scrollView.contentOffset.x % (int)pageWidth != 0)
//    {
//        [scrollView setContentOffset:CGPointMake((int)(scrollView.contentOffset.x/pageWidth) * pageWidth, 0) animated:YES];
//    }
    if(scrollView.contentOffset.x == UISCREENWIDTH *(pageControl.numberOfPages+1))
    {
        //[scrollView setContentOffset:CGPointMake(UISCREENWIDTH + scrollView.contentOffset.x-10, 0) animated:YES];
        [scrollView setContentOffset:CGPointMake(UISCREENWIDTH , 0)];
    }
    //NSLog(@"%lf",scrollView.contentOffset.x);
    [scrollView setContentOffset:CGPointMake(UISCREENWIDTH + scrollView.contentOffset.x, 0) animated:YES];
    
    
    //[scrollView setContentOffset:CGPointMake(viewSize.size.width*5, 0)];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}




- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
 
    if(self.firstView)
    {
        int page = floor(scrollView.contentOffset.x / pageWidth);
        currentPageIndex=page;
        pageControl.currentPage=page;
        //NSLog(@"YZH %d",page);
    }
    else{
        //if((int)scrollView.contentOffset.x %(int)pageWidth == 0)
        
        int page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1;
        if (page >= pageControl.numberOfPages + 2) {
            page = pageControl.numberOfPages+1;
        }
            //currentPageIndex=page;
        if(page > pageControl.numberOfPages)
        {
            pageControl.currentPage = 0;
            currentPageIndex=page;
        }
        else
        {
            pageControl.currentPage=(page-1);
            currentPageIndex=page;
        }
        
    }
    
}
#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    //scrollView.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    //手动控制图片滚动应该取消那个三秒的计时器
    
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    if(!self.firstView && !_isTimeUp)
    {
        if (currentPageIndex==1) {
            
            [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
        }
        if (currentPageIndex==([imageArray count]-1)) {
            
            [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
            
        }
    }
    _isTimeUp = NO;
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
        if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked: andPages: )]) {
    
            [delegate EScrollerViewDidClicked:currentPageIndex andPages:pageControl.numberOfPages];
            
            NSLog(@"PAGE==%d,PAGES==%ld",currentPageIndex,(long)pageControl.numberOfPages);

        }

}
-(void)beginAction
{
    [delegate BeginAction];
}
-(void)stopScrollView
{
    
}
-(void)startScrollView
{
    


}


@end
