//
//  ViewController.m
//  封装方法
//
//  Created by William on 16/4/13.
//  Copyright © 2016年 William. All rights reserved.
//

#import "ViewController.h"
#import "TCLibrary/TCLibrary.h"
#import "test.h"
#import "BViewController.h"
#import "CViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [self.view addSubview:_scrollView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 400,self.view.frame.size.width , self.view.frame.size.height-400)];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        [_imageView addGestureRecognizer:tap];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"iden"];
}


#pragma mark - tableViewDalegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iden" forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"字典转模型";
            break;
        case 1:
            cell.textLabel.text = @"模型转字典";
            break;
        case 2:
            cell.textLabel.text = @"网络轮播图";
            break;
        case 3:
            cell.textLabel.text = @"后台加载图片";
            break;
        case 4:
            cell.textLabel.text = @"截屏保存相册";
            break;
        case 5:
            cell.textLabel.text = @"A界面推出C界面返回B界面";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            [self dictionaryToModel];
            break;
        case 1:
            [self modelToDictionary];
            break;
        case 2:
            [self carouselWithScrollView];
            break;
        case 3:
            [self TCSetImageWithURL];
            break;
        case 4:
            [self screenshot];
            break;
        case 5:
            [self.navigationController pushViewController:[CViewController new] backViewController:[BViewController new] animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - 实现方法
- (void)dictionaryToModel
{
    NSDictionary *dic = @{@"a":@(1),@"type":@"123",@"age":@"21",@"monery":@"123",@"model":@{@"1":@"1",@"2":@"2"},@"mydate":@"2016-12-13T16:25:32"};
    test *ts = [[test alloc] TCSetValuesForKeysWithDictionary:dic];
    NSLog(@"age=%@type=%@monery=%@ mydate=%@a=%d",ts.age,ts.type,ts.monery,ts.mydate,ts.a);
}

- (void)modelToDictionary
{
    NSDictionary *dic = @{@"a":@(1),@"type":@"123",@"age":@"21",@"monery":@"123",@"model":@{@"1":@"1",@"2":@"2"},@"mydate":@"2016-12-13T16:25:32"};
    test *ts = [[test alloc] TCSetValuesForKeysWithDictionary:dic];
    ts.a = 100;
    ts.b = 3.14;
    NSDictionary *modelDic = [ts TCGetDictionaryFromValuesAndKeys];
    NSLog(@"%@",modelDic);

}

- (void)carouselWithScrollView
{
    UIImage *i1 = [UIImage imageNamed:@"practice"];
    UIImage *i2 = [UIImage imageNamed:@"task"];
    UIImage *i3 = [UIImage imageNamed:@"user"];
    [[TCImageManage sharedInstance]createCarouselWithScrollView:self.scrollView ImageArray:@[i1,i2,i3] interval:3 URLArray:@[@"http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg",@"http://www.ziyouniuniu.com/androidImage/home/img/3.jpg",@"http://www.ziyouniuniu.com/androidImage/home/img/1.jpg"]];
}

- (void)TCSetImageWithURL
{
    [self.imageView setImageWithURL:@"http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg" placeholder:nil];
}

- (void)screenshot
{
    [[TCImageManage alloc]screenshot:self.view NeedSave:YES success:^{
        NSLog(@"成功截屏并保存到相册");
    } failure:^(NSError *error) {
        
    }];
}


- (void)removeView
{
    [self.imageView removeFromSuperview];
    [self.scrollView removeFromSuperview];
    self.imageView = nil;
    self.scrollView = nil;
}

@end
