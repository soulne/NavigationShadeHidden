//
//  PersonDetailVC.m
//  个人详情页
//
//  Created by 911 on 16/2/13.
//  Copyright © 2016年 bin. All rights reserved.
//

#import "PersonDetailVC.h"
#import "UIImage+Image.h"

#define oriOffy -244
#define oriHeight 200
@interface PersonDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstr;


@end

@implementation PersonDetailVC
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //凡是在导航条下面的scrollview 都会有默认偏移量UIEdgeInsetsMake(64, 0, 0, 0)
    //取消默认偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //导航条或者导航条上面的控件，设置透明度是没有效果的。
    self.navigationController.navigationBar.alpha = 0;
    
    

    //设置背景图片
    //设置导航条背景必须使用默认的格式。
    //当背景图片设置为nil时 系统会自动生成一张半透明的图片，设为导航条的背景。
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    
    //注册tableViewCell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    title.text = @"个人详情页";
    [title sizeToFit];
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    
    self.navigationItem.titleView = title;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //求偏移量 当前点 - 原点。
    NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - oriOffy;
    
    NSLog(@"%f",offset);
    
    CGFloat h = oriHeight - offset;
    
    if (h < 64) {
        h = 64;
    }
    
    self.heightConstr.constant = h;
    
    CGFloat alpha = offset / 136.0;
    
    if (alpha >= 1)alpha = 0.99;
    
    UIColor *color =[UIColor colorWithWhite:1 alpha:alpha];
    UIImage *bgImage = [UIImage imageWithColor:color];
    
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    //拿到标题
    UILabel *title = (UILabel *)self.navigationItem.titleView;
    title.textColor = [UIColor colorWithWhite:0 alpha:alpha];
}

@end
