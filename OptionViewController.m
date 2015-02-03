//
//  OptionViewController.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/10.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

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
    
    //背景画像
    UIImage *haikei = [UIImage imageNamed:@"signUpLogin.png"];
    UIImageView *haikeiPic = [[UIImageView alloc]initWithImage:haikei];
    haikeiPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    [self.view addSubview:haikeiPic];
    
    //ログアウトボタン
    UIImage *img = [UIImage imageNamed:@"whiteEdge.png"];  // ボタンにする画像を生成する
    logout =  [UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
    [logout setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [logout addTarget:self
               action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [logout setTitle:@"Log Out" forState:UIControlStateNormal ];
    logout.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [logout setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:logout];
    
    //バックボタン
    UIImage *img2 = [UIImage imageNamed:@"whiteEdge.png"];  // ボタンにする画像を生成する
    back =  [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0,rect.size.height/6.4,rect.size.width,rect.size.height/6.4);
    [back setBackgroundImage:img2 forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [back addTarget:self
             action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [back setTitle:@"Back" forState:UIControlStateNormal ];
    back.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [back setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:back];

    NSUserDefaults *userSave = [NSUserDefaults standardUserDefaults];
    userId = (int)[userSave integerForKey:@"userId"];
    NSLog(@"%d",userId);
    userNameString = [userSave objectForKey:@"userName"];

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

-(void)logout:(UIButton*)button{
    
    userId = 0;
    userNameString = nil;
    NSUserDefaults *userSave = [NSUserDefaults standardUserDefaults];
    [userSave setInteger:userId forKey:@"userId"];
    [userSave setObject:userNameString forKey:@"userName"];


    ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FVC"];
    [self presentViewController:ViewController animated:YES completion:nil];
}

-(void)back:(UIButton*)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
