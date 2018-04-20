//
//  HDOptionalViewController.m
//  HDCinema
//
//  Created by HeDong on 2018/4/13.
//  Copyright © 2018年 HeDong. All rights reserved.
//

#import "HDOptionalViewController.h"
#import "HDCustomBrowseViewController.h"

typedef NS_ENUM(NSInteger, HDOptionalViewControllerBtnType) {
    HDOptionalViewControllerBtnType_Custom  = 0,
    HDOptionalViewControllerBtnType_52      = 1,
    HDOptionalViewControllerBtnType_4080    = 2,
    HDOptionalViewControllerBtnType_SoHu    = 3,
};

@interface HDOptionalViewController ()

@property (nonatomic, weak) UITextField *textField;

@end

@implementation HDOptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"自选内容";
    [self createSubviews];
    self.view.backgroundColor = HDColorFromHex(0xcccccc);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)createSubviews {
    CGFloat margin = 10;
    CGFloat height = 44;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *btn = [self createBtn];
    btn.tag = HDOptionalViewControllerBtnType_Custom;
    [btn setTitle:@"前往自输入地址" forState:UIControlStateNormal];
    
    UIButton *wuBtn = [self createBtn];
    wuBtn.tag = HDOptionalViewControllerBtnType_52;
    [wuBtn setTitle:@"52影院" forState:UIControlStateNormal];
    
    UIButton *siBtn = [self createBtn];
    siBtn.tag = HDOptionalViewControllerBtnType_4080;
    [siBtn setTitle:@"4080新视觉影院" forState:UIControlStateNormal];

    UIButton *soHuBtn = [self createBtn];
    soHuBtn.tag = HDOptionalViewControllerBtnType_SoHu;
    [soHuBtn setTitle:@"搜狐视频" forState:UIControlStateNormal];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(margin);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@(height));
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textField.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@(height));
    }];
    
    [wuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(10);
        make.left.right.height.equalTo(btn);
    }];
    
    [siBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wuBtn.mas_bottom).offset(10);
        make.left.right.height.equalTo(btn);
    }];
    
    [soHuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(siBtn.mas_bottom).offset(10);
        make.left.right.height.equalTo(btn);
    }];
}

- (UIButton *)createBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = HDColorFromHex(0x0093ff);
    btn.layer.cornerRadius = 8.0;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

- (void)clickBtn:(UIButton *)btn {
    [self.view endEditing:YES];
    NSString *URLString = self.textField.text;
    switch (btn.tag) {
        case HDOptionalViewControllerBtnType_52: {
            URLString = @"http://www.52xsba.com/";
            break;
        }
            
        case HDOptionalViewControllerBtnType_4080: {
            URLString = @"http://www.yy4080.com/";
            break;
        }
            
        case HDOptionalViewControllerBtnType_SoHu: {
            URLString = @"https://tv.sohu.com/";
            break;
        }
            
        default:
            break;
    }
    
    if ([URLString hasPrefix:@"http://"] ||
        [URLString hasPrefix:@"https://"] ||
        [URLString hasPrefix:@"ftp://"]) {
        // 其他处理
    } else {
        URLString = [NSString stringWithFormat:@"http://%@" , URLString];
    }
    
    HDCustomBrowseViewController *customBrowse = [[HDCustomBrowseViewController alloc] init];
    customBrowse.URL = [NSURL URLWithString:URLString];
    [self.navigationController pushViewController:customBrowse animated:YES];
}

@end
