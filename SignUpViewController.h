//
//  SignUpViewController.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/05.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AFNetworking.h"
#import "firstViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface SignUpViewController : UIViewController<UITextFieldDelegate>{
    
    
    UITextField *userName;
    UITextField *pass;
    UIButton *signUp;
    UIButton *back;
    
    //画面サイズの取得
    UIScreen *sc;
    
    //ステータスバーを除いたサイズ
    CGRect rect;
}


@end
