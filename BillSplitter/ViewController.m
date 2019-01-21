//
//  ViewController.m
//  BillSplitter
//
//  Created by Spencer Symington on 2019-01-20.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTotalField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentField;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSlider;
@property (weak, nonatomic) IBOutlet UITextField *numberToSplitField;
@property (weak, nonatomic) IBOutlet UISlider *peopleToSplitSlider;
@property (weak, nonatomic) IBOutlet UILabel *splitAmtLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.billTotalField.delegate = self;
    self.tipPercentField.delegate = self;
    self.numberToSplitField.delegate = self;
    
}
- (IBAction)splitSliderChanged:(UISlider*)sender {
    self.numberToSplitField.text = [NSString stringWithFormat:@"%i", (int)sender.value];
    
    float billTotal = [self.billTotalField.text floatValue];
    
    float tipPercent = [self.tipPercentField.text floatValue];
    float people = [self.numberToSplitField.text floatValue];
    
    [self calculateBill:billTotal Tip:tipPercent People:people];
}
- (IBAction)tipSliderChanged:(UISlider*)sender {
    self.tipPercentField.text = [NSString stringWithFormat:@"%.01f", sender.value];
    
    float billTotal = [self.billTotalField.text floatValue];
    
    float tipPercent = [self.tipPercentField.text floatValue];
    float people = [self.numberToSplitField.text floatValue];
    
    [self calculateBill:billTotal Tip:tipPercent People:people];
}

-(void)calculateBill:(float)bill Tip:(float)tip People:(float)people{
    
    if(tip <0){
        tip = 0;
        self.tipPercentField.text = @"0";
    }
    float totalWithTip =  bill + (bill*(tip/100.0));
    
    //get float value for accurate division
   
    if(people > 8){
        people = 8;
        self.numberToSplitField.text = @"8";
    }else if(people < 2){
        people = 2;
        self.numberToSplitField.text = @"2";
    }
    
    float toPay = totalWithTip / people;
    self.splitAmtLabel.text = [NSString stringWithFormat:@"$%.02f",toPay];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    float billTotal = [self.billTotalField.text floatValue];
    float tipPercent = [self.tipPercentField.text floatValue];
    float people = [self.numberToSplitField.text floatValue];
    
    if([textField isEqual:self.billTotalField]){
        //if deletating
        if(range.length == 1){
            
            NSString *newValueString = [self.billTotalField.text substringFromIndex:range.length];
            billTotal = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.billTotalField.text stringByAppendingString:string];
            billTotal = [newValueString floatValue];
        }
        
    }
    if([textField isEqual:self.tipPercentField]){
        //if deletating
        if(range.length == 1){
            
            NSString *newValueString = [self.tipPercentField.text substringFromIndex:range.length];
            tipPercent = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.tipPercentField.text stringByAppendingString:string];
            tipPercent = [newValueString floatValue];
        }
        
    }
    if([textField isEqual:self.numberToSplitField]){
        //if deletating
        if(range.length == 1){
            
            NSString *newValueString = [self.numberToSplitField.text substringFromIndex:range.length];
            people = [newValueString floatValue];
        }else{
            
            NSString *newValueString = [self.numberToSplitField.text stringByAppendingString:string];
            people = [newValueString floatValue];
        }
        
    }
    [self calculateBill:billTotal Tip:tipPercent People:people];
    
    return YES;
}


@end
