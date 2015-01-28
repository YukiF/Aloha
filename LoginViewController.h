//
//  LoginViewController.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/08.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "firstViewController.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    
    
    UITextField *userName;
    UITextField *pass;
    UIButton *login;
    UIButton *back;
    
    //画面サイズの取得
    UIScreen *sc;
    
    //ステータスバーを除いたサイズ
    CGRect rect;
}


@end
