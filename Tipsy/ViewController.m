//
//  ViewController.m
//  Tipsy
//
//  Created by César Francisco Barraza on 6/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// control definitions
@property (weak, nonatomic) IBOutlet UITextField* txtBill;
@property (weak, nonatomic) IBOutlet UILabel* lblTip;
@property (weak, nonatomic) IBOutlet UILabel* lblTotal;
@property (weak, nonatomic) IBOutlet UILabel* lblPercent;
@property (weak, nonatomic) IBOutlet UIStepper* stpTip;
@property (weak, nonatomic) IBOutlet UIView* vwTip;
@property (weak, nonatomic) IBOutlet UIView* vwTotal;

@end

@implementation ViewController

/*
    @funcName updateUI
    @desc Updates the tip and total labels.
*/
- (void)updateUI {
    double bill = [self.txtBill.text doubleValue];
    double tipPercent = self.stpTip.value / 100;
    double tip = tipPercent * bill;
    double total = bill + tip;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSInteger sign = [defaults integerForKey:@"defaults_sign"];
    BOOL sep = [defaults boolForKey:@"defaults_sep"];
    
    NSString* tipText;
    NSString* totalText;
    
    NSNumber* numTip = [NSNumber numberWithDouble:tip];
    NSNumber* numTotal = [NSNumber numberWithDouble:total];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.usesGroupingSeparator = YES;
    
    // figure out which sign we have to use
    switch(sign)
    {
        case 0:
            if(sep)
            {
                tipText = [NSString stringWithFormat:@"$%@", [formatter stringForObjectValue:numTip]];
                totalText = [NSString stringWithFormat:@"$%@", [formatter stringForObjectValue:numTotal]];
            }
            else
            {
                tipText = [NSString stringWithFormat:@"$%.2f", tip];
                totalText = [NSString stringWithFormat:@"$%.2f", total];
            }
            break;
        case 1:
            if(sep)
            {
                tipText = [NSString stringWithFormat:@"€%@", [formatter stringForObjectValue:numTip]];
                totalText = [NSString stringWithFormat:@"€%@", [formatter stringForObjectValue:numTotal]];
            }
            else
            {
                tipText = [NSString stringWithFormat:@"€%.2f", tip];
                totalText = [NSString stringWithFormat:@"€%.2f", total];
            }
            break;
        case 2:
            if(sep)
            {
                tipText = [NSString stringWithFormat:@"£%@", [formatter stringForObjectValue:numTip]];
                totalText = [NSString stringWithFormat:@"£%@", [formatter stringForObjectValue:numTotal]];
            }
            else
            {
                tipText = [NSString stringWithFormat:@"£%.2f", tip];
                totalText = [NSString stringWithFormat:@"£%.2f", total];
            }
            break;
    }
    
    self.lblTip.text = tipText;
    self.lblTotal.text = totalText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.txtBill becomeFirstResponder];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    double bill = [defaults integerForKey:@"defaults_bill"];
    NSNumber* val = [NSNumber numberWithDouble:bill];
    self.txtBill.text = [val stringValue];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    // hide the keyboard
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    [self updateUI];
}

- (IBAction)onEditingDidBegin:(id)sender {
    // if there is a zero, clear the field
    double val = [self.txtBill.text doubleValue];
    if(val == 0)
    {
        self.txtBill.text = @"";
    }
    
    CGRect frameTip = self.vwTip.frame;
    CGRect frameTotal = self.vwTotal.frame;
    frameTip.origin.y = 181;
    frameTotal.origin.y = 259;
    
    [UIView animateWithDuration:0.32 animations:^{
        self.vwTip.frame = frameTip;
        self.vwTotal.frame = frameTotal;
    }];
}

- (IBAction)onEditingDidEnd:(id)sender {
    CGRect frameTip = self.vwTip.frame;
    CGRect frameTotal = self.vwTotal.frame;
    frameTip.origin.y = 398;
    frameTotal.origin.y = 475;
    
    [UIView animateWithDuration:0.22 animations:^{
        self.vwTip.frame = frameTip;
        self.vwTotal.frame = frameTotal;
    }];
    
    // save the bill amount
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:[self.txtBill.text doubleValue] forKey:@"defaults_bill"];
    [defaults synchronize];
}

- (IBAction)onValueChanged:(id)sender {
    int value = self.stpTip.value;
    
    // %% is the literal for adding an actual percentage sign with formatting
    self.lblPercent.text = [NSString stringWithFormat:@"%i%%", value];
}
@end
