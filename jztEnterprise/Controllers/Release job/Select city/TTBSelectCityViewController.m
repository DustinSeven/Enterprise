//
//  TTBSelectCityViewController.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBSelectCityViewController.h"
#import "TTBSelectCityView.h"
#import "ZGProvinceEntity.h"
#import "ZGCityParam.h"
#import "ZGCityEntity.h"
#import "ZGAreaEntity.h"
#import "TTBSelectCityCell.h"
#import "ZGAreaParam.h"
#import "TTBReleaseJobProcess.h"

@interface TTBSelectCityViewController ()<PushTreeViewDataSource, PushTreeViewDelegate>
{
    TTBSelectCityView *_baseView;
    
    NSMutableArray *provinceArr;
    NSMutableArray *cityArr;
    NSMutableArray *areaArr;
    
    ZGProvinceEntity *selectedProvinceEntity;
    ZGCityEntity *selectedCityEntity;
    ZGAreaEntity *selectedAreaEntity;
}

@end

@implementation TTBSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if(IS_PHONE)
    {
        _baseView = [[TTBSelectCityView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.view = _baseView;
        
        provinceArr = [NSMutableArray array];
        cityArr = [NSMutableArray array];
        areaArr = [NSMutableArray array];
        
        _baseView.baseTableView.delegate = self;
        _baseView.baseTableView.dataSource = self;
        
        UISwipeGestureRecognizer *baseGestrueRecognize;
        baseGestrueRecognize = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(baseViewSwipe:)];
        [_baseView addGestureRecognizer:baseGestrueRecognize];
        
        self.title = @"选择地区";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    [[TTBReleaseJobProcess shareInstance]getAllProvinceWithParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"]intValue] == 200)
        {
            NSArray *data = [responseObject objectForKey:@"data"];
            for(int i = 0;i<data.count;++i)
            {
                ZGProvinceEntity *tmpEntity = [[ZGProvinceEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                [provinceArr addObject:tmpEntity];
            }
            [_baseView.baseTableView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }];
    
}

#pragma -mark 侧滑事件
- (void)baseViewSwipe:(UISwipeGestureRecognizer *)recognize
{
    if (recognize.direction == UISwipeGestureRecognizerDirectionRight) {
        if(_baseView.baseTableView.level > 0)
            [_baseView.baseTableView back];
    }
}

#pragma mark - PushTreeViewDataSource
- (NSInteger)numberOfSectionsInLevel:(NSInteger)level
{
    return 1;
}

- (NSInteger)numberOfRowsInLevel:(NSInteger)level section:(NSInteger)section
{
    if(level == 0)
        return provinceArr.count;
    if(level == 1)
        return cityArr.count;
    if(level == 2)
        return areaArr.count;
    
    return 0;
}

- (InfiniteTreeBaseCell *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"SelectCityCell";
    TTBSelectCityCell *cell = (TTBSelectCityCell*)[pushTreeView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TTBSelectCityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if(level == 0)
    {
        ZGProvinceEntity *tmpEntity = [provinceArr objectAtIndex:indexPath.row];
        cell.textLabel.text = tmpEntity.name;
    }
    if(level == 1)
    {
        ZGCityEntity *tmpEntity = [cityArr objectAtIndex:indexPath.row];
        cell.textLabel.text = tmpEntity.name;
    }
    if(level == 2)
    {
        ZGAreaEntity *tmpEntity = [areaArr objectAtIndex:indexPath.row];
        cell.textLabel.text = tmpEntity.name;
    }
    
    return cell;
}

#pragma mark - PushTreeViewDelegate
- (void)pushTreeView:(InfiniteTreeView *)pushTreeView didSelectedLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    if(level == 0)
    {
        ZGCityParam *cityParam = [[ZGCityParam alloc]init];
        selectedProvinceEntity = [provinceArr objectAtIndex:indexPath.row];
        cityParam.provinceId = selectedProvinceEntity.identity;
        [[TTBReleaseJobProcess shareInstance]getCityWithParam:[cityParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 [cityArr removeAllObjects];
                 for(int i = 0;i<data.count;++i)
                 {
                     ZGCityEntity *tmpCityEntity = [[ZGCityEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                     [cityArr addObject:tmpCityEntity];
                 }
                 [_baseView.baseTableView reloadLastTabData];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [alert show];
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
         }];
    }
    
    if(level == 1)
    {
        ZGAreaParam *areaParam = [[ZGAreaParam alloc]init];
        selectedCityEntity = [cityArr objectAtIndex:indexPath.row];
        areaParam.cityId = selectedCityEntity.identity;
        [[TTBReleaseJobProcess shareInstance]getAreaWithParam:[areaParam getDictionary] ParentView:nil progressText:@"loading" success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if([[responseObject objectForKey:@"code"]intValue] == 200)
             {
                 NSArray *data = [responseObject objectForKey:@"data"];
                 [areaArr removeAllObjects];
                 for(int i = 0;i<data.count;++i)
                 {
                     ZGAreaEntity *tmpAreaEntity = [[ZGAreaEntity alloc]initWithAttributes:[data objectAtIndex:i]];
                     [areaArr addObject:tmpAreaEntity];
                 }
                 [_baseView.baseTableView reloadLastTabData];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:[responseObject objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 [alert show];
             }
             
         }
                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"网络错误，请检查您的网络连接！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
         }];
    }
    
    if(level == 2)
    {
        selectedAreaEntity = [areaArr objectAtIndex:indexPath.row];
        
        if([_delegate respondsToSelector:@selector(didSelectArea:)])
           [_delegate didSelectArea:selectedAreaEntity];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (UIView *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level viewForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = ChangeInfoCellHeight;
    UIView *headerview = nil;
    headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, headerHeight)];
    headerview.backgroundColor = RGBCOLOR(233, 238, 247);
    UILabel *titL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, headerHeight)];
    titL.textColor = RGBCOLOR(104, 104, 104);
    titL.backgroundColor = [UIColor clearColor];
    titL.font = [UIFont boldSystemFontOfSize:16];
    [headerview addSubview:titL];

    if(level == 0)
        titL.text = @"省份";
    if(level == 1)
        titL.text = @"市/县";
    if(level == 2)
        titL.text = @"区";

    return headerview;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForHeaderInSection:(NSInteger)section
{
    return ChangeInfoCellHeight;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ChangeInfoCellHeight;
}

- (BOOL)pushTreeViewHasNextLevel:(InfiniteTreeView *)pushTreeView currentLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{

    if (level >= 2 )
    {
        return NO;
    }

    return YES;
}

- (void)pushTreeViewWillReloadAtLevel:(InfiniteTreeView*)pushTreeView currentLevel:(NSInteger)currentLevel level:(NSInteger)level                            indexPath:(NSIndexPath*)indexPath
{
    //    NSLog(@"current level %ld level %ld", currentLevel, level);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
