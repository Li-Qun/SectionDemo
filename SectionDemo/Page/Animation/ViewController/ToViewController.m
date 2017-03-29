//
//  ToViewController.m
//  
//
//  Created by HF on 17/3/28.
//
//

#import "ToViewController.h"
#import "HFAnimation.h"

@interface ToViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation ToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ViewController animation 返回效果";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.backgroundColor = [UIColor yellowColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"VCBack %ld fade %ld",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //手动控制返回效果
    CATransition *animate =[HFAnimation getShowAnimationIndex:indexPath.section + 1 fadeAnimationIndex:indexPath.row];
    [self.navigationController.view.layer addAnimation:animate forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}


@end
