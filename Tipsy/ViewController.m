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
@property (weak, nonatomic) IBOutlet UIView *vwTotal;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.txtBill becomeFirstResponder];
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
    double bill = [self.txtBill.text doubleValue];
    double tipPercent = self.stpTip.value / 100;
    double tip = tipPercent * bill;
    double total = bill + tip;
    
    NSString* text = self.txtBill.text;
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString* formatted = [formatter text];
    
    self.txtBill.text = [NSString stringWithString: formatted];
    self.lblTip.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.lblTotal.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (IBAction)onEditingDidBegin:(id)sender {
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
}

- (IBAction)onValueChanged:(id)sender {
    int value = self.stpTip.value;
    self.lblPercent.text = [NSString stringWithFormat:@"%i%%", value];
}
@end
