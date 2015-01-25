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
    
    //背景画像
    UIImage *haikei = [UIImage imageNamed:@"haikei.png"];
    UIImageView *haikeiPic = [[UIImageView alloc]initWithImage:haikei];
    haikeiPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    [self.view addSubview:haikeiPic];
    
    
    //Sign Upボタン
    UIImage *img = [UIImage imageNamed:@"whiteWaku.png"];  // ボタンにする画像を生成する
    signUp =  [UIButton buttonWithType:UIButtonTypeCustom];
    signUp.frame = CGRectMake(0,rect.size.height/6.4*3,rect.size.width,rect.size.height/6.4);
    [signUp setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [signUp addTarget:self
               action:@selector(toSignUp:) forControlEvents:UIControlEventTouchUpInside];
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal ];
    signUp.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [signUp setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:signUp];
    
    //Loginボタン
    UIImage *img2 = [UIImage imageNamed:@"whiteWaku.png"];  // ボタンにする画像を生成する
    login =  [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(0,rect.size.height/6.4*4,rect.size.width,rect.size.height/6.4);
    [login setBackgroundImage:img2 forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [login addTarget:self
                   action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [login setTitle:@"Log In" forState:UIControlStateNormal ];
    login.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [login setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:login];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(10, 10, rect.size.width, 100);
    label1.center = CGPointMake(rect.size.width/2, rect.size.height/12.8);
    label1.text = @"Welcome";
    label1.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/10];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(10, 10, rect.size.width, 100);
    label2.center = CGPointMake(rect.size.width/2, rect.size.height/12.8+rect.size.height/6.4);
    label2.text = @"To";
    label2.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/10];
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.frame = CGRectMake(10, 10, rect.size.width, 100);
    label3.center = CGPointMake(rect.size.width/2, rect.size.height/12.8+rect.size.height/3.2);
    label3.text = @"\"Arrometer\"";
    label3.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/10];
    label3.textColor = [UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label3];
    

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
