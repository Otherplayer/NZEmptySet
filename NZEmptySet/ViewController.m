//
//  ViewController.m
//  NZEmptySet
//
//  Created by __无邪_ on 2/19/16.
//  Copyright © 2016 fqah. All rights reserved.
//

//https://github.com/dzenbot/DZNEmptyDataSet
//pod 'DZNEmptyDataSet', '~> 1.7.3'

#import "ViewController.h"
#import "HYQRefreshHeader.h"
#import "UIScrollView+EmptyDataSet.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.datas = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self addRefreshHeader];
    
    
    // 马上进入刷新状态
    //    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)loadNewData{
    NSLog(@"%s",__func__);
    [self performSelectorOnMainThread:@selector(didReceivedData) withObject:self waitUntilDone:3];
}
- (void)didReceivedData{
    [self.tableView.mj_header endRefreshing];
    
    [self.datas addObject:@"sss"];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"identifier2cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierCell];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - configure

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor cyanColor];
}



#pragma mark - DZNEmptyDataSetSource Methods
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"logo_airbnb"];
}
- (NSString *)buttonNormalTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return @"重新加载";
}
- (NSString *)descriptionNormalForEmptyDataSet:(UIScrollView *)scrollView{
    return @"“诶，夜魔你知道吗，我今天和丽娜说话了！”“恭喜，你是怎么做到的？”“她今天把我打死了，然后我又站了起来，说了句“我是不朽哒”，她笑的直不起腰，说你好有趣“";
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.datas.count > 0 ? NO : YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    NSLog(@"%s",__func__);
}




#pragma mark - Configure


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}



- (void)addRefreshHeader{
    HYQRefreshHeader *refreshHeader = [HYQRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    refreshHeader.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.hidden = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = refreshHeader;
}





@end
