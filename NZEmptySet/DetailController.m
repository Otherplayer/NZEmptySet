//
//  DetailController.m
//  NZEmptySet
//
//  Created by __无邪_ on 16/2/19.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "DetailController.h"
#import "DZNEmptyDataSetView.h"

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    DZNEmptyDataSetView *view = [DZNEmptyDataSetView new];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view];

    NSString *detail = @"“诶，夜魔你知道吗，我今天和丽娜说话了！”“恭喜，你是怎么做到的？”“她今天把我打死了，然后我又站了起来，说了句“我是不朽哒”，她笑的直不起腰，说你好有趣“";
    
    [view configureImage:@"logo_airbnb" detail:detail button:@"重新加载"];
    [view.button addTarget:self action:@selector(didTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)dzn_didTapDataButton:(id)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action

- (void)didTapAction:(id)sender{
    NSLog(@"%s",__func__);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
