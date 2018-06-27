//
//  SettingsViewController.m
//  Tipsy
//
//  Created by César Francisco Barraza on 6/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
// controller declarations

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)onValueChange:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.chkSign.on forKey:@"defaults_sign"];
    [defaults synchronize];
}

@end
