//
//  MTMenuVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTMenuVC.h"
#import "UIColor+PXExtensions.h"
#import "MTPriorityCell.h"
#import "MTAppManager.h"
#import "MTMenuCellObject.h"
#import "NSString+FontAwesome.h"

#define kMaxDeep                    3

@interface MTMenuVC ()<UITableViewDataSource, UITableViewDelegate, MTMenuCellDelegate>{
    NSMutableArray*    _tableViewDataSource;
    NSInteger countOfItems;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;

@end

@implementation MTMenuVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor pxColorWithHexValue:KColorChildMenuBackground];
    _tableViewDataSource = [[NSMutableArray alloc] init];
    
    MTMenuInfo* menuInfo = [MTAppManager sharedInstance].menuInfo;
    NSMutableArray* menuList = menuInfo.menuItems;
    MTMenuCellObject * report = [[MTMenuCellObject alloc] initWithTitle:@"Report"];
    [menuList addObject:report];
    MTMenuCellObject * logout = [[MTMenuCellObject alloc] initWithTitle:@"Logout"];
    [menuList addObject:logout];
    
    for (int i=0; i< menuList.count; i++) {
        MTMenuCellObject* item = (MTMenuCellObject* )[menuList objectAtIndex:i];
        [self dataFiller:item level:0 ParentPath:nil CurrentIndex:i];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width*0.5;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataFiller:(MTMenuCellObject*)model level:(NSInteger) level ParentPath :(NSArray *)arrParentPath CurrentIndex :(int) index
{
    //MTMenuCellModel* model = [[MTMenuCellModel alloc] init];
    model.level = level;
    model.hide = (1 << (kMaxDeep - level)) - 1;
    model.m_arrPath = [[NSMutableArray alloc] init];
    if (arrParentPath != nil){
        [model.m_arrPath addObjectsFromArray:arrParentPath];
    }
    [model.m_arrPath addObject:[NSNumber numberWithInt:index]];
    
    [_tableViewDataSource addObject:model];
    
    if (level != kMaxDeep - 1)
    {
        for (int i=0; i< model.childs.count; i++){
            MTMenuCellObject* item = [model.childs objectAtIndex:i];
            [self dataFiller:item level:level + 1 ParentPath:model.m_arrPath CurrentIndex:i];
        }
        
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITableViewDelegate
const static int kShowFlag = (1 << kMaxDeep) -1;

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int n = 0;
    
    for (MTMenuCellObject* model in _tableViewDataSource) {
        if (model.hide == kShowFlag) n ++ ;
    }
    
    return n;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int t = -1;
    MTMenuCellObject* m;
    for (MTMenuCellObject* model in _tableViewDataSource) {
        if (model.hide == kShowFlag) t ++;
        if (t == indexPath.row) {
            m = model;
            break;
        }
    }
    
    static NSString* key = @"PriorityCell";
    MTPriorityCell* cell = [tableView dequeueReusableCellWithIdentifier:key];
    cell.delegate =  self;
    cell.cellData = m;
    UIView* cellBackView = [[UIView alloc] initWithFrame:cell.frame];
    cellBackView.backgroundColor = [UIColor pxColorWithHexValue:KColorSelectedMenu];
    cell.selectedBackgroundView = cellBackView;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMenuCellObject* m = [self expandTable:indexPath];
    //-----Logout--
    if ([m.key isEqualToString:@"Logout"]) {
        [MTAppManager sharedInstance].menuInfo = nil;
        [[MTAppManager sharedInstance].slidingViewController dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    //------Go to Page-------
    if (m.level == 0) {
        [MTAppManager sharedInstance].currentSelectedPriority = (MTPriority*)m;
        [MTAppManager sharedInstance].currentSelectedArea = nil;
        [MTAppManager sharedInstance].currentSelectedCategory = nil;
        [self performSegueWithIdentifier:@"goToAreaDashboard" sender:nil];
    }else if (m.level == 1) {
        [MTAppManager sharedInstance].currentSelectedArea = (MTArea*)m;
        [MTAppManager sharedInstance].currentSelectedCategory = nil;
        [self performSegueWithIdentifier:@"goToHighChart" sender:nil];
    }else{
        [MTAppManager sharedInstance].currentSelectedCategory = (MTCategory*)m;
        [self performSegueWithIdentifier:@"goToHighChart" sender:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(MTMenuCellObject*)expandTable:(NSIndexPath*) indexPath{
    int t = -1, p = 0;
    MTMenuCellObject* m;
    for (MTMenuCellObject* model in _tableViewDataSource) {
        if (model.hide == kShowFlag) t ++;
        if (t == indexPath.row) {
            m = model;
            break;
        }
        p++;
    }
    
    if (m.level == 6) return m;
    
    NSLog(@"%@", m.m_arrPath);
    p ++;
    if (p == _tableViewDataSource.count) return m;
    MTMenuCellObject* nxtModel = _tableViewDataSource[p];
    if (nxtModel.level > m.level)
    {
        if (nxtModel.hide == kShowFlag)
        {
            m.isExpand = FALSE;
            NSMutableArray* arr = [NSMutableArray array];
            while (true)
            {
                if (nxtModel.hide == kShowFlag)
                {
                    t ++;
                    NSIndexPath* path = [NSIndexPath indexPathForRow:t inSection:0];
                    [arr addObject:path];
                }
                nxtModel.hide ^= 1 << (kMaxDeep - m.level - 1);
                p ++;
                if (p == _tableViewDataSource.count) break;
                nxtModel = _tableViewDataSource[p];
                if (nxtModel.level <= m.level) break;
            }
            [self.menuTable deleteRowsAtIndexPaths:arr
                             withRowAnimation:UITableViewRowAnimationFade];
            
        }
        else
        {
            m.isExpand = TRUE;
            NSMutableArray* arr = [NSMutableArray array];
            while (true)
            {
                nxtModel.hide ^= 1 << (kMaxDeep - m.level - 1);
                
                if (nxtModel.hide == kShowFlag)
                {
                    t ++;
                    NSIndexPath* path = [NSIndexPath indexPathForRow:t inSection:0];
                    [arr addObject:path];
                }
                
                p ++;
                if (p == _tableViewDataSource.count) break;
                nxtModel = _tableViewDataSource[p];
                if (nxtModel.level <= m.level) break;
            }
            [self.menuTable insertRowsAtIndexPaths:arr
                             withRowAnimation:UITableViewRowAnimationFade];
        }
        MTPriorityCell*  cell = (MTPriorityCell*) [self.menuTable cellForRowAtIndexPath:indexPath];
        [cell accessoryViewAnimation:m.isExpand];
        
    }
    return m;
}

#pragma mark MTMenuCellDelegate
-(void)didSelectExpandButton:(MTMenuCellObject *)data{
    NSLog(@"%@", data.m_arrPath);
    [self expandTable:[self getInedxPathFromData:data]];
}
-(NSIndexPath*)getInedxPathFromData:(MTMenuCellObject*)data{
    countOfItems = 0;
    NSArray * items = [MTAppManager sharedInstance].menuInfo.menuItems;
    for (int i = 0; i < items.count ; i++) {
        if ([self getNumbersOfExpandedChildrens:[items objectAtIndex:i] key:data.key]) {
            break;
        }
    }
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:countOfItems inSection:0];
    return indexPath;
}

-(BOOL)getNumbersOfExpandedChildrens:(MTMenuCellObject*)item key:(NSString*)key{
    if ([item.key isEqualToString:key]) return TRUE;
    countOfItems++;
    if (item.isExpand) {
        for (int i = 0; i < item.childs.count; i++) {
            BOOL result =  [self getNumbersOfExpandedChildrens:[item.childs objectAtIndex:i]  key:key];
            if (result) {
                return TRUE;
            }
         }
    }
    return FALSE;
}
@end
