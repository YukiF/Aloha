//
//  firstViewController.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/08.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

int userId;
NSString *userNameString;

@interface firstViewController : UIViewController{
    
    UIButton *signUp;
    UIButton *login;
    
    //画面サイズの取得
    UIScreen *sc;
    
    //ステータスバーを除いたサイズ
    CGRect rect;
    
}

@end
