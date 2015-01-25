//
//  OptionViewController.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/10.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "firstViewController.h"


@interface OptionViewController : UIViewController{
    
    //画面サイズの取得
    UIScreen *sc;
    
    //ステータスバーを除いたサイズ
    CGRect rect;
    
    UIButton *logout;
    UIButton *back;
    

}

@end
