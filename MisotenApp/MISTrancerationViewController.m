//
//  MISTrancerationViewController.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/12/21.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISTrancerationViewController.h"
#import "IQActionSheetPickerView.h"
#import "NeetMSTranslator/NMSTranslator.h"
#import <objc/runtime.h>

@interface MISTrancerationViewController () <UITextFieldDelegate, IQActionSheetPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *countryPicker;
@property (nonatomic, weak) IBOutlet UILabel *trancerationLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) IQActionSheetPickerView *picker;
@property (nonatomic, strong) NSMutableArray *countries;

@end

@implementation MISTrancerationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.clipsToBounds = YES;
    _textField.layer.cornerRadius = 10.0f;
    _textField.layer.borderWidth = 1.0f;
    
    self.countryPicker.delegate = self;
    
    _countryPicker.text = @"日本語";
    _picker = [[IQActionSheetPickerView alloc] initWithTitle:@"翻訳する言語を選ぶでござる" delegate:self];
    _picker.titleFont = [UIFont systemFontOfSize:18];
    [_picker setTitlesForComponents:@[[[self class] countryNames]]];
}

- (void)translation:(NSString *)string {
    NMSTranslator *tra = [NMSTranslator sharedTranslator];
    
    [tra initializeTranslatorWithClientID:@"misoten-translation"
                             clientSecret:@"DXO3s+UdqbxLO8y660ZzdGjAnmI4gMMsXKNK9OAGlhk="];
    
    [tra transrateWithText:string to:@"ja" success:^(NSHTTPURLResponse *response, NSString *string) {
        _trancerationLabel.text = string;
        
    } failure:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        
        NSLog(@"err: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == _countryPicker) {
        [_picker show];
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [_countryPicker resignFirstResponder];
}

+ (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    if (!_countryNames)
    {
        _countryNames = [[[self countryNamesByCode].allValues sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] copy];
    }
    return _countryNames;
}

+ (NSArray *)countryCodes
{
    static NSArray *_countryCodes = nil;
    if (!_countryCodes)
    {
        _countryCodes = [[[self countryCodesByName] objectsForKeys:[self countryNames] notFoundMarker:@""] copy];
    }
    return _countryCodes;
}

+ (NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *countryName = [NSString stringWithFormat:@"%@語", [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code]];
            
            //workaround for simulator bug
            if (!countryName)
            {
                countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];
            }
            
            namesByCode[code] = countryName ?: code;
        }
        _countryNamesByCode = [namesByCode copy];
    }
    return _countryNamesByCode;
}

+ (NSDictionary *)countryCodesByName
{
    static NSDictionary *_countryCodesByName = nil;
    if (!_countryCodesByName)
    {
        NSDictionary *countryNamesByCode = [self countryNamesByCode];
        NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
        for (NSString *code in countryNamesByCode)
        {
            codesByName[countryNamesByCode[code]] = code;
        }
        _countryCodesByName = [codesByName copy];
    }
    return _countryCodesByName;
}

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles {
    _countryPicker.text = [titles firstObject];
}

- (IBAction)trancerate:(id)sender {
    if(![_textField.text isEqualToString:@""]) {
        [self translation:_textField.text];
    }
}

@end
