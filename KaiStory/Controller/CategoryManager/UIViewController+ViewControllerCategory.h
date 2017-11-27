

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
//#import "Story.h"

@interface UIViewController (ViewControllerCategory)


//@property (nonatomic, strong) UIButton *right;
@property (nonatomic ,strong) CTCallCenter *callCenter;
//@property (nonatomic, strong) Story *story_cate;



//设置NavigationBar的 Title、 titleColor、 backgroundColor
- (void)setNavigationBarWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor;
- (void)setNavigationBarWithTitle:(NSString *)title titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor;
//设置NavigationBar的背景图片
- (void)setNavigationBarWithImage:(UIImage *)image;
- (void)setLeftNavigationItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (UIButton *)setRightNavigationItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
//- (void)setRightHiden:(BOOL)hiden;



- (void)callPhone:(CTCallCenter *)callCenter;
- (void)previousPlay;
- (void)nextPlay;
- (void)configPlayingInfos:(NSString *)name image:(NSString *)imgUrl;
@end
