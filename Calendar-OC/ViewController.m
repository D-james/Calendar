//
//  ViewController.m
//  Calendar-OC
//
//  Created by duanshengwu on 2018/5/14.
//  Copyright © 2018年 D-James. All rights reserved.
//

#import "ViewController.h"
#import "DSCalendarController.h"

@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    

}


- (IBAction)toSingleVC:(id)sender {
    [self toCanlendarVC:true];
}


- (IBAction)toSectionVC:(id)sender {
    [self toCanlendarVC:false];
}


- (void)toCanlendarVC:(BOOL)isSingleSelect {
    
    DSCalendarController *vc = [DSCalendarController new];
    vc.isSingleSelect = isSingleSelect;
    [self.navigationController pushViewController:vc animated:true];
}
@end
