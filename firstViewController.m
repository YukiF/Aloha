//
//  firstViewController.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/08.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "firstViewController.h"

@interface firstViewController ()

@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if( [ UIApplication sharedApplication ].isStatusBarHidden == NO ) {
        [ UIApplication sharedApplication ].statusBarHidden = YES;
    }
    
    
    //画面サイズの取得
    sc = [UIScreen mainScreen];
    //ステータスバーを除いたサイズ
    rect = sc.applicationFrame;
    
    //Sign Upボタン
    UIImage *img = [UIImage imageNamed:@"newUserBack.png"];  // ボタンにする画像を生成する
    signUp =  [UIButton buttonWithType:UIButtonTypeCustom];
    signUp.frame = CGRectMake(0,rect.size.height/6.34482759*3,rect.size.width,rect.size.height/6.34482759);
    [signUp setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [signUp addTarget:self
               action:@selector(toSignUp:) forControlEvents:UIControlEventTouchUpInside];
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal ];
    signUp.titleLabel.font = [ UIFont fontWithName:@"PopJoyStd-B" size:rect.size.height/16];
    [signUp setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:signUp];
    
    //Loginボタン
    UIImage *img2 = [UIImage imageNamed:@"newUserBack.png"];  // ボタンにする画像を生成する
    login =  [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(0,rect.size.height/6.34482759*4,rect.size.width,rect.size.height/6.34482759);
    [login setBackgroundImage:img2 forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [login addTarget:self
                   action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [login setTitle:@"Log In" forState:UIControlStateNormal ];
    login.titleLabel.font = [ UIFont fontWithName:@"PopJoyStd-B" size:rect.size.height/16];
    [login setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:login];
    

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

-(void)toSignUp:(UIButton*)button{
    
    ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SUVC"];
    [self presentViewController:ViewController animated:YES completion:nil];

    
}

-(void)toLogin:(UIButton*)button{
    
    ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LVC"];
    [self presentViewController:ViewController animated:YES completion:nil];
    
}


@end
