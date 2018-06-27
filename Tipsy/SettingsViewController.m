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
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmCurrency;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger sign = [defaults integerForKey:@"defaults_sign"];
    self.sgmCurrency.selectedSegmentIndex = sign;
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
    [defaults setInteger:self.sgmCurrency.selectedSegmentIndex forKey:@"defaults_sign"];
    [defaults synchronize];
}

@end
