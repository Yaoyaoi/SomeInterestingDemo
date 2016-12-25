//
//  ViewController.m
//  WebImage
//
//  Created by Wujianyun on 24/12/2016.
//  Copyright © 2016 yaoyaoi. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "BookModel.h"
@interface ViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _searchText;
    UISearchBar* _searchBar;
    UITableView* _tabelView;
    NSMutableArray* _arrayData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)drawView{
    _tabelView=[[UITableView alloc]initWithFrame:self.view.bounds];
    [_tabelView setDelegate:self];
    [_tabelView setDataSource:self];
    [_tabelView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_tabelView];
    _arrayData=[[NSMutableArray alloc]init];
    _searchBar=[[UISearchBar alloc]init];
    _searchBar.placeholder =@"请输入书籍关键字";
    [_searchBar sizeToFit];
    [_searchBar setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [_searchBar setKeyboardType:UIKeyboardTypeDefault];
    [_searchBar setShowsCancelButton:YES animated:YES];
    _tabelView.tableHeaderView=_searchBar;
    _searchBar.delegate=self;
}
-(void)dataLoad{
    [self loadDataFormNet];
    [_tabelView reloadData];
}
-(void)loadDataFormNet{
    AFHTTPSessionManager*session=[AFHTTPSessionManager manager];
    NSString* path=[NSString stringWithFormat:@"https://api.douban.com/v2/book/search?q=%@",_searchText];
    [session GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask* _Nonnull task,id _Nullable responseObject) {
        NSLog(@"下载成功");
        if([responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"dic=%@",responseObject);
            [self parseData:responseObject];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        NSLog(@"下载失败！");
    }];
}
-(void)parseData:(NSDictionary*)dicData{
    [_arrayData removeAllObjects];
    NSArray* arrBooks=[dicData objectForKey:@"books"];
    for(NSDictionary* dicBook in arrBooks){
        BookModel* bookModel=[[BookModel alloc]init];
        [bookModel setTitle:[dicBook objectForKey:@"title"]];
        [bookModel setAuthor:[dicBook objectForKey:@"author"]];
        [bookModel setImageURL:[dicBook objectForKey:@"image"]];
        [_arrayData addObject:bookModel];
    }
    [_tabelView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* strID=@"ID";
    UITableViewCell * cell=[_tabelView dequeueReusableCellWithIdentifier:strID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    BookModel* bookModel=_arrayData[indexPath.row];
    cell.textLabel.text=bookModel.title;
   [cell.imageView sd_setImageWithURL:[NSURL URLWithString:bookModel.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchText=searchBar.text;
    [self dataLoad];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;{
    [_arrayData removeAllObjects];
    [_tabelView reloadData];
}

@end
