//
//  MISForgetItemsTableView.m
//  Sample001
//
//  Created by 奥寺辰也 on 2016/11/15.
//  Copyright © 2016年 奥寺辰也. All rights reserved.
//

#import "MISForgetItemsTableView.h"

@interface MISForgetItemsTableView ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataSourceItems;
@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,assign) NSIndexPath *lastIndexPath;
@property (nonatomic,strong) UILabel *naviLabel;
@property (nonatomic,assign) NSInteger num;
@end

@implementation MISForgetItemsTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSourceItems = [@[
                              @"パスポート",
                              @"ビザ",
                              @"海外旅行保険",
                              @"交通",
                              @"マイレージカード",
                              @"鉄道パス",
                              @"クレジットカード",
                              @"現金（日本円）",
                              @"現金（現地通貨）",
                              @"国際キャッシュカード",
                              @"携帯電話",
                              @"携帯電話の充電器",
                              @"カメラ",
                              @"カメラ用電池・充電器",
                              @"電気プラグアダプター",
                              @"デジタルカメラのメモリ",
                              @"オーディオプレーヤー",
                              @"延長コード"] mutableCopy];
    //ナビゲーションバーのタイトル
    self.naviLabel = [[UILabel alloc] init];
    self.num = self.dataSourceItems.count;
    self.naviLabel.text = [NSString stringWithFormat:@"準備完了まで %ld個",(long)self.num];
    self.naviLabel.font = [UIFont fontWithName:@"Helvetica" size:16]; //フォントの設定。
    self.naviLabel.font = [UIFont boldSystemFontOfSize:16]; //フォントの設定。
    self.naviLabel.backgroundColor = [UIColor clearColor]; //背景色。透明が安定
    self.naviLabel.textColor = [UIColor blackColor]; //文字色。
    [self.naviLabel sizeToFit];
    self.navigationItem.titleView = self.naviLabel;
    //編集モード
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


// 編集モードになった時に呼ばれるメソッド
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    NSLog(@"%s", __func__);
    [super setEditing:editing animated:animated];
    if (editing) {
        // 編集モードの処理
        NSLog(@"編集モードに入りました。");
        
        
//        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        // 編集モードから戻った時の処理
        NSLog(@"編集モードから出ました。");
    }
}


//項目追加
- (IBAction)add:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"持ち物を追加" message:@"例）パスポート" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"OK pushed");
                                                
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *action) {
                                                NSLog(@"Cancel pushed");
                                            }]];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"text input";
        textField.delegate = self;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//アラートのOKが押されたら
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    NSLog(@"%@",textField.text);
    if(textField.text.length != 0){
        //配列に追加する
        [self.dataSourceItems addObject:textField.text];
        [self.tableView reloadData];
        self.num += 1;
        self.naviLabel.text = [NSString stringWithFormat:@"準備完了まで %ld個",(long)self.num];
        [self.naviLabel sizeToFit];
        //self.navigationItem.titleView = self.naviLabel;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

/*
 * UITableView cell
 */

//データ件数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger dataCount;
    
    return dataCount = self.dataSourceItems.count;
}

//セクション（区切り）件数/データ件数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//テーブルに表示するセル
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.allowsMultipleSelection = YES;
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    _cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!_cell) {
        // 再利用できない場合は新規で作成
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        //選択時の背景
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell.tintColor = [UIColor orangeColor];
    }
    
    //セルの背景
    // For even
    if (indexPath.row % 2 == 0) {
        _cell.backgroundColor = [UIColor colorWithRed:1.000
                                                green:1.0
                                                 blue:0.941
                                                alpha:1.0
                                 ];
    }
    // For odd
    else {
        _cell.backgroundColor = [UIColor colorWithRed:1.000
                                                green:0.894
                                                 blue:0.710
                                                alpha:1.0
                                 ];
    }
    
    _cell.textLabel.text = self.dataSourceItems[indexPath.row];
    
    return _cell;
    
}

//セルが選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"touch");
    self.lastIndexPath = indexPath;
    
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.num -= 1;
    if(self.num == 0){
        self.naviLabel.text = [NSString stringWithFormat:@"準備完了まで %ld個 出発できます！",(long)self.num];
    }else{
        self.naviLabel.text = [NSString stringWithFormat:@"準備完了まで %ld個",(long)self.num];
    }
    [self.naviLabel sizeToFit];
    self.navigationItem.titleView = self.naviLabel;
    
    //    [tableView setEditing:YES animated:YES];
}

//セルが選択解除された時
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Dtouch");
    self.lastIndexPath = indexPath;
    
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _cell.accessoryType = UITableViewCellAccessoryNone;
    self.num += 1;
    self.naviLabel.text = [NSString stringWithFormat:@"準備完了まで %ld個",(long)self.num];
    [self.naviLabel sizeToFit];
    self.navigationItem.titleView = self.naviLabel;
    
    //    [tableView setEditing:YES animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 3;
}


@end
