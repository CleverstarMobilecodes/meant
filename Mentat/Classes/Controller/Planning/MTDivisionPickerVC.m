//
//  MTDivisionPickerVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 09/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDivisionPickerVC.h"
#import "MZFormSheetController.h"

@interface MTDivisionPickerVC ()<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray* divisionDataList;
    MTNewProjectVC* parentVC;
}
@property (weak, nonatomic) IBOutlet UIPickerView *divisionPicker;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)setDivisionValue:(id)sender;
- (IBAction)doCancel:(id)sender;

@end

@implementation MTDivisionPickerVC

-(void)setData:(MTNewProjectVC *)parent data:(NSArray *)data{
    parentVC = parent;
    divisionDataList = data;
    [self.divisionPicker reloadAllComponents];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setDivisionValue:(id)sender {
    NSString * selectedValue = [divisionDataList objectAtIndex:[self.divisionPicker selectedRowInComponent:0]];
    float f = [selectedValue floatValue];
    [parentVC setDivisionLabelValue:f];
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}
- (IBAction)doCancel:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}
#pragma mark UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return divisionDataList.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [divisionDataList objectAtIndex:row];
}
//-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UIView* itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
//    imageView.image = [UIImage imageNamed:@"profile_small.jpg"];
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius = 15;
//    [itemView addSubview:imageView];
//    UILabel * userName = [[UILabel alloc]  initWithFrame:CGRectMake(35, 0, 120, 35)];
//    userName.text = [divisionDataList objectAtIndex:row];
//    userName.textAlignment = NSTextAlignmentCenter;
//    [itemView addSubview:userName];
//    
//    return itemView;
//}


@end
