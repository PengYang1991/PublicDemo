//
//  CustomizedViewController.m
//  KaiStory
//
//  Created by yangpeng on 15/4/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#import "CustomizedViewController.h"
#import "Tools.h"
#import "UIColor+HexStringToColor.h"
#import "PlayCustomViewController.h"
@interface CustomizedViewController (){
    NSString *identy ;
    NSMutableArray* modelArray;
    UIImageView*flashImage;
    UITableView *listview;
    NSArray *arrarys;
}

@end

@implementation CustomizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ColorWithHexString:@"e4f2ee"];
    modelArray = [NSMutableArray array];
    arrarys = @[@"无渐弱模式",@"最后一个故事后渐弱",@"最后五分钟渐弱"];
    
    [self loadData];
    [self creatui];
    [self creatlableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backBtnAction:(id)sender{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatui{
    
    NSInteger bttop = 76+64;
    NSInteger btleft = 30;
    NSInteger btwidth = 565;
    NSInteger btheight = 73;
    NSInteger lablesize = 38;
    UIButton *addstroy = [UIButton buttonWithType:UIButtonTypeCustom];
    addstroy.frame = CGRectMake(btleft*RESIZE_RATIO,
                                bttop*RESIZE_RATIO,
                                btwidth*RESIZE_RATIO,
                                btheight*RESIZE_RATIO);
    
    [addstroy setBackgroundImage:[UIImage imageNamed:@"xuangushipng"] forState:UIControlStateNormal];
    [addstroy setTitle:@"定制故事" forState:UIControlStateNormal];
    addstroy .titleLabel.font = [UIFont systemFontOfSize:lablesize*RESIZE_RATIO];
    [self.view addSubview:addstroy];
    [addstroy addTarget:self action:@selector(addActions:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger imleft = 40;
    NSInteger imtop = bttop+40+btheight;
    NSInteger imwidth = 561;
    NSInteger imheight = 421;
    imageviews = [[UIImageView alloc]initWithFrame:CGRectMake(imleft*RESIZE_RATIO,
                                                              imtop*RESIZE_RATIO,
                                                              imwidth*RESIZE_RATIO,
                                                              imheight*RESIZE_RATIO)];
    
    imageviews.image = [UIImage imageNamed:@"gushikuang"];
    imageviews.userInteractionEnabled = YES;
    [self creatlsitView];
    [self.view addSubview:imageviews];
    
    NSInteger sleeppoem = imtop+80+imheight;
    NSInteger sleepleft = 40;
    NSInteger  sleepwidth = 561;
    NSInteger sleepheight  = 211;
    UIImageView *sleepPoem = [[UIImageView alloc]initWithFrame:CGRectMake(sleepleft*RESIZE_RATIO,
                                                                          sleeppoem*RESIZE_RATIO,
                                                                          sleepwidth*RESIZE_RATIO,
                                                                          sleepheight*RESIZE_RATIO)];
    sleepPoem.userInteractionEnabled = YES;
    sleepPoem.image = [UIImage imageNamed:@"shikuang"];
    sleepPoem.userInteractionEnabled = YES;
    [self.view addSubview:sleepPoem];
    
    NSInteger sleeplefts = sleepwidth-26-40;
    NSInteger sltop = 26;
    NSInteger slwidth =40;
    NSInteger slheight = 41;
    UIButton *addpoem = [UIButton buttonWithType:UIButtonTypeCustom];
    addpoem.frame = CGRectMake(sleeplefts*RESIZE_RATIO,
                               sltop*RESIZE_RATIO,
                               slwidth*RESIZE_RATIO,
                               slheight*RESIZE_RATIO);
    
    [addpoem setBackgroundImage:[UIImage imageNamed:@"jiahao1"] forState:UIControlStateNormal];
    [sleepPoem addSubview:addpoem];
    [addpoem addTarget:self action:@selector(addpoemActions:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger leftla = 60;
    NSInteger topla = 105;
    NSInteger  widthla = 320;
    NSInteger  height = 40;
    NSInteger labsizes = 32;
    UILabel *addpoems = [[UILabel alloc]initWithFrame:CGRectMake(leftla*RESIZE_RATIO,
                                                                 topla*RESIZE_RATIO,
                                                                 widthla*RESIZE_RATIO,
                                                                 height*RESIZE_RATIO)];
    
    addpoems.textColor = [UIColor ColorWithHexString:@"88d295"];
    addpoems.text = @"要 不 要 加 首 睡 前 诗";
    addpoems.font =[UIFont systemFontOfSize:labsizes*RESIZE_RATIO];
    
    [sleepPoem addSubview:addpoems];
    
    NSInteger lft =leftla+widthla+10;
    NSInteger tops =sltop+slheight+20;
    NSInteger imawidth = 128;
    NSInteger imaheight = 50;
    
    UIImageView *plaineimage = [[UIImageView alloc]initWithFrame:CGRectMake(lft*RESIZE_RATIO,
                                                                            tops*RESIZE_RATIO,
                                                                            imawidth*RESIZE_RATIO,
                                                                            imaheight*RESIZE_RATIO)];
    plaineimage.image = [UIImage imageNamed:@"feiji"];
    
    [sleepPoem addSubview:plaineimage];
    
    
}

- (void)addActions:(id)sender{
    
    
    
    
}
- (void)addpoemActions:(id)sender{
    backgroundView.hidden =NO;
    
}
- (void)creatlsitView{
    NSInteger  listlft = 20;
    NSInteger  listtop = 26;
    NSInteger  listwidth =531-18;
    NSInteger  listheight = 322;
    self.stroylist = [[UITableView alloc]initWithFrame:CGRectMake(listlft*RESIZE_RATIO,
                                                                  listtop*RESIZE_RATIO,
                                                                  listwidth*RESIZE_RATIO,
                                                                  listheight*RESIZE_RATIO)
                                                 style:UITableViewStylePlain];
    self.stroylist.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.stroylist.delegate  = self;
    self.stroylist.dataSource = self;
    [imageviews addSubview:self.stroylist];
    //    identy = @"customcell";
    //    [self.stroylist  registerClass:[customViewsCell class] forCellReuseIdentifier:identy];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:listview]) {
        return arrarys.count;
    }else{
        return modelArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    customViewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell = [[customViewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell1.textLabel.text = arrarys[indexPath.row];
    NSInteger lasize =24;
    cell1.textLabel.font = [UIFont systemFontOfSize:lasize*RESIZE_RATIO];
    cell1.textAlignment = NSTextAlignmentCenter;
    cell1.textColor = [UIColor ColorWithHexString:@"b1b1b1"];
    cell1.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellsDelegate = self;
    cell.tag = indexPath.row+1000;
    Allstroymodel *models = [modelArray objectAtIndex:indexPath.row];
    [cell setdataModel:models];
    if ([tableView isEqual:listview]) {
        return cell1;
    }else{
        return  cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:listview]) {
        
        return 101*RESIZE_RATIO/3;
    }else{
        return 120*RESIZE_RATIO;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    titlestring = [arrarys objectAtIndex:indexPath.row];
    
    [modelButton setTitle:titlestring forState:UIControlStateNormal];
    
    
}
-(void)creatlableView{
    NSInteger left = 50;
    NSInteger top = 26+322+16;
    NSInteger width = 533-18;
    NSInteger height = 30;
    
    UIView *labeview = [[UIView alloc]initWithFrame:CGRectMake(left*RESIZE_RATIO,
                                                               top*RESIZE_RATIO,
                                                               width*RESIZE_RATIO,
                                                               height*RESIZE_RATIO)];
    
    [imageviews addSubview:labeview];
    NSInteger widths = 55;
    NSInteger heights = 30;
    NSInteger labsize = 24;
    UILabel *didFinsh = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, widths, heights)];
    didFinsh.text = @"已完成:";
    didFinsh.textColor = [UIColor ColorWithHexString:@"88d295"];
    didFinsh.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    [labeview addSubview:didFinsh];
    
    NSInteger minleft = widths;
    NSInteger minwidths = 60;
    NSInteger minheights = 30;
    
    UILabel *minutelable = [[UILabel alloc]initWithFrame:CGRectMake(minleft, 0, minwidths, minheights)];
    minutelable.text = @"30分钟 / ";
    minutelable.textColor = [UIColor ColorWithHexString:@"88d295"];
    minutelable.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    [labeview addSubview:minutelable];
    
    
    
    NSInteger predictleft = widths+minwidths;
    NSInteger predictwidths = 60+15;
    NSInteger predictheights = 30;
    
    UILabel *predictlable = [[UILabel alloc]initWithFrame:CGRectMake(predictleft,
                                                                     0, predictwidths,
                                                                     predictheights)];
    predictlable.text = @"设定时间 : ";
    predictlable.textColor = [UIColor ColorWithHexString:@"88d295"];
    predictlable.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    [labeview addSubview:predictlable];
    
    
    NSInteger preleft = predictleft+predictwidths;
    NSInteger prewidths = 60;
    NSInteger preheights = 30;
    
    UILabel *prelable = [[UILabel alloc]initWithFrame:CGRectMake(preleft, 0, prewidths, preheights)];
    prelable.text = @"45分钟";
    prelable.textColor = [UIColor ColorWithHexString:@"88d295"];
    prelable.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    [labeview addSubview:prelable];
    [self creatFlashView];
    [self creatFlashbigView];
}
#pragma dianjixieyi

- (void)deletecells:(NSInteger)index tag:(NSInteger)butag{
    NSInteger rows = index-1000;
    if (butag==4) {
        [modelArray removeObjectAtIndex:rows];
        [self.stroylist reloadData];
        
    }
    if (butag==0) {
        if (rows==0||rows>modelArray.count) {
            return;
        }
        [modelArray exchangeObjectAtIndex:rows-1 withObjectAtIndex:rows];
        [self.stroylist reloadData];
        
    }
    if (butag==1) {
        if (rows+1>=modelArray.count) {
            return;
        }
        [modelArray exchangeObjectAtIndex:rows+1 withObjectAtIndex:rows];
        [self.stroylist reloadData];
        
    }
    if (butag==2||butag==3) {
        return;
    }
}

-(void)loadData{
    NSUserDefaults *reddata = [NSUserDefaults standardUserDefaults];
    NSMutableArray*setarrary = [reddata objectForKey:@"setid"];
    NSLog(@"set==%ld",[setarrary count]);
    for (NSString *ids in setarrary) {
        NSLog(@"id===%@",ids);
        [self   checkid:ids];
    }
    
    
    
}

- (void)checkid:(NSString *)ids{
    NSUserDefaults *reddata = [NSUserDefaults standardUserDefaults];
    NSString *seriaStr = [reddata objectForKey:@"model"];
    NSLog(@"seria==%@",seriaStr);
    NSDictionary *results = [Tools dictionaryWithJsonString:seriaStr];
    NSLog(@"result===%lu",(unsigned long)results.count);
    NSDictionary *resdic =[results objectForKey:@"result"];
    NSArray *resuary = [resdic objectForKey:@"media_list"];
    
    for (NSDictionary *dic in resuary) {
        Allstroymodel*model = [[Allstroymodel alloc]initWithDict:dic];
        self.stroymodel = model;
        //             [modelArray addObject:model];
        NSLog(@"mdoel = %ld",modelArray.count);
        NSString *modelid = self.stroymodel.m_id;
        NSLog(@"________ids==%@,i=======%@",ids,modelid);
        if (ids==modelid) {
            
            [modelArray addObject:model];
        }
        
        //        NSLog(@"mdoel = %ld",modelArray.count);
    }
    
    NSLog(@"mdoel = %ld",modelArray.count);
    
}

- (void)creatFlashView{
    NSInteger left=0;
    NSInteger top = 64;
    NSInteger with =FRAME_WIDTH;
    NSInteger height =FRAME_HEIGHT-64;
    
    backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(left, top, with, height)];
    backgroundView.image = [UIImage imageNamed:@"zhezhao"];
    [self.view addSubview:backgroundView];
    backgroundView.userInteractionEnabled = YES;
    
    NSInteger flleft = 50;
    NSInteger fltop = 266;
    NSInteger flwidth =541;
    NSInteger flheight = 354;
    flashImage = [[UIImageView alloc]initWithFrame:CGRectMake(flleft*RESIZE_RATIO,
                                                              fltop*RESIZE_RATIO,
                                                              flwidth*RESIZE_RATIO,
                                                              flheight*RESIZE_RATIO)];
    
    flashImage.image = [UIImage imageNamed:@"tanchukuang"];
    flashImage.userInteractionEnabled = YES;
    [backgroundView addSubview:flashImage];
    
    NSInteger laleft = 60;
    NSInteger latop = 94;
    NSInteger lawidth =445;
    NSInteger laheight = 35;
    NSInteger labsize = 36;
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                              latop*RESIZE_RATIO,
                                                              lawidth*RESIZE_RATIO,
                                                              laheight*RESIZE_RATIO)];
    
    lable.text = @"要 不 要 加 首 睡 前 诗 ？";
    lable.font = [UIFont systemFontOfSize:labsize*RESIZE_RATIO];
    lable.textColor = [UIColor whiteColor];
    [flashImage addSubview:lable];
    
    
    NSInteger btleft = 40;
    NSInteger bttop = latop+laheight+68;
    NSInteger btwidth = 215;
    NSInteger btheight = 75;
    UIButton * addBut = [UIButton buttonWithType:UIButtonTypeCustom];
    addBut.frame = CGRectMake(btleft*RESIZE_RATIO,
                              bttop*RESIZE_RATIO,
                              btwidth*RESIZE_RATIO,
                              btheight*RESIZE_RATIO);
    [addBut setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    [addBut setTitle:@"加一首" forState:UIControlStateNormal];
    [flashImage addSubview:addBut];
    
    
    NSInteger aleft = btheight+btwidth;
    NSInteger atop = bttop;
    NSInteger awidth = 215;
    NSInteger aheight = 75;
    UIButton *noAddBut = [UIButton buttonWithType:UIButtonTypeCustom];
    noAddBut.frame = CGRectMake(aleft*RESIZE_RATIO,
                                atop*RESIZE_RATIO,
                                awidth*RESIZE_RATIO,
                                aheight*RESIZE_RATIO);
    
    
    
    
    [noAddBut setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    [noAddBut setTitle:@"不加了" forState:UIControlStateNormal];
    [noAddBut addTarget:self action:@selector(notAxtion:) forControlEvents:UIControlEventTouchUpInside];
    [flashImage addSubview:noAddBut];
    backgroundView.hidden = YES;
    
}
-(void)notAxtion:(id)sender
{
    flashImage.hidden = NO;
    backgroundView.hidden = YES;
    
    
}
- (void)creatFlashbigView{
    
    NSInteger bigleft = 46;
    NSInteger bittop = 66;
    NSInteger bigwidth =541;
    NSInteger bigheight = 754;
    flashImage = [[UIImageView alloc]initWithFrame:CGRectMake(bigleft*RESIZE_RATIO,
                                                              bittop*RESIZE_RATIO+44,
                                                              bigwidth*RESIZE_RATIO,
                                                              bigheight*RESIZE_RATIO)];
    flashImage.image = [UIImage imageNamed:@"tanchukuang"];
    
    flashImage.userInteractionEnabled = YES;
    [self.view addSubview:flashImage];
    
    NSInteger laleft = 60;
    NSInteger latop = 136;
    NSInteger lawidth = 428;
    NSInteger laheight = 67;
    NSInteger lasize = 26;
    UILabel *palymodel = [[UILabel alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                                  latop*RESIZE_RATIO,
                                                                  lawidth*RESIZE_RATIO,
                                                                  laheight*RESIZE_RATIO)];
    
    
    palymodel.text = @"声 音 渐 弱 模 式/";
    palymodel.textColor =[UIColor whiteColor];
    palymodel.font =[UIFont systemFontOfSize:lasize*RESIZE_RATIO];
    [flashImage addSubview:palymodel];
    
    NSInteger btleft = 60;
    NSInteger bttop = latop +laheight;
    NSInteger btwidth = 428;
    NSInteger btheight = 67;
    modelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    modelButton.frame = CGRectMake(btleft*RESIZE_RATIO,
                                   bttop*RESIZE_RATIO,
                                   btwidth*RESIZE_RATIO,
                                   btheight*RESIZE_RATIO);
    
    
    [modelButton setBackgroundImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [modelButton setTitle:@"无 渐 弱 模 式" forState:UIControlStateNormal];
    [modelButton setTitleColor:[UIColor ColorWithHexString:@"63bba5"] forState:UIControlStateNormal];
    [flashImage addSubview:modelButton];
    
    
    
    NSInteger btlefts = 541-30-33;
    NSInteger bttops = 30;
    NSInteger btwidths = 33;
    NSInteger btheights = 33;
    UIButton *finshbts = [UIButton buttonWithType:UIButtonTypeCustom];
    finshbts.frame = CGRectMake(btlefts*RESIZE_RATIO,
                                bttops*RESIZE_RATIO,
                                btwidths*RESIZE_RATIO,
                                btheights*RESIZE_RATIO);
    
    
    [finshbts setBackgroundImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [finshbts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashImage addSubview:finshbts];
    [finshbts addTarget:self action:@selector(hidebigflash:) forControlEvents:UIControlEventTouchUpInside];
    [self creatListView];
    
}

-(void)creatListView{
    NSInteger lileft = 85;
    NSInteger  litop =136+67+67;
    NSInteger  liwidth =377;
    NSInteger  liheight=101;
    listview = [[UITableView alloc]initWithFrame:CGRectMake(lileft*RESIZE_RATIO,
                                                            litop*RESIZE_RATIO,
                                                            liwidth*RESIZE_RATIO,
                                                            liheight*RESIZE_RATIO)];
    
    listview.delegate = self;
    listview.dataSource = self;
    listview.separatorColor = [UIColor ColorWithHexString:@"63bba5"];
    [listview setSeparatorInset:UIEdgeInsetsZero];
    
    if ([listview respondsToSelector:@selector(setSeparatorInset:)]){
        [listview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([listview respondsToSelector:@selector(setLayoutMargins:)]){
        [listview setLayoutMargins:UIEdgeInsetsZero];
    }
    listview.bounces = NO;
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"xialakuang"];
    [listview setBackgroundView:imageview];
    [flashImage addSubview:listview];
    
    
    NSInteger laleft = lileft;
    NSInteger latop = litop+liheight+50;
    NSInteger lawidth = 428;
    NSInteger laheight = 20;
    NSInteger lasize = 26;
    UILabel *editlable = [[UILabel alloc]initWithFrame:CGRectMake(laleft*RESIZE_RATIO,
                                                                  latop*RESIZE_RATIO,
                                                                  lawidth*RESIZE_RATIO,
                                                                  laheight*RESIZE_RATIO)];
    
    
    editlable.text = @"专辑昵称/";
    editlable.textColor =[UIColor whiteColor];
    editlable.font =[UIFont systemFontOfSize:lasize*RESIZE_RATIO];
    [flashImage addSubview:editlable];
    
    
    NSInteger textleft = 60;
    NSInteger texttop = latop+laheight+20;
    NSInteger textwidht =428;
    NSInteger textheight = 67;
    edittext = [[UITextField alloc]initWithFrame:CGRectMake(textleft*RESIZE_RATIO,
                                                            texttop*RESIZE_RATIO,
                                                            textwidht*RESIZE_RATIO,
                                                            textheight*RESIZE_RATIO)];
    
    edittext.background = [UIImage imageNamed:@"xiala"];
    edittext.text = @"昵 称 + 定 制 1";
    edittext.textAlignment = NSTextAlignmentCenter;
    edittext.textColor = [UIColor ColorWithHexString:@"63bba5"];
    [flashImage addSubview:edittext];
    edittext.delegate =self;
    
    NSInteger btleft = 60;
    NSInteger bttop = texttop+textheight+86;
    NSInteger btwidth = 428;
    NSInteger btheight = 67;
    UIButton *finshbt = [UIButton buttonWithType:UIButtonTypeCustom];
    finshbt.frame = CGRectMake(btleft*RESIZE_RATIO,
                               bttop*RESIZE_RATIO,
                               btwidth*RESIZE_RATIO,
                               btheight*RESIZE_RATIO);
    
    
    [finshbt setBackgroundImage:[UIImage imageNamed:@"xiankuang"] forState:UIControlStateNormal];
    [finshbt setTitle:@"完成" forState:UIControlStateNormal];
    [finshbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashImage addSubview:finshbt];
    [finshbt addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.text) {
        textField.text = nil;
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length<1) {
        textField.text = @"昵 称 + 定 制 1";
    }
    
}
- (void)hidebigflash:(id)sender{
    
    flashImage.hidden = YES;
    
   }


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [edittext resignFirstResponder];


}
-(void)finishAction:(id)sender{

    PlayCustomViewController *customPlay = [[PlayCustomViewController alloc]initWithConfig:@"哄睡" withBackBtn:YES withFootBar:YES];
    
    [self presentViewController:customPlay animated:YES completion:^{
        
    }];

   


}






@end
