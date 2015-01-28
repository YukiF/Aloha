//
//  ViewController.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/03.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "firstViewController.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>{
    
    IBOutlet UITableView *table;
    
    //セルの数
    int cellNum;
    
    //友達の名前の配列
    NSMutableArray *friends;

    //画面サイズの取得
    UIScreen *sc;
    
    //ステータスバーを除いたサイズ
    CGRect rect;
   
    //タップした時のフィルター
    UIView * filterView;
    
    UIButton *fukidasi;
    
    //バックグラウンドを画像に設定
    UIImageView *myView;
    
    //ユーザー追加するためのテキストフィールド
    UITextField *addUser;
    
    UIImageView *arrowPic;
    UIImageView *arrowLight;
    UIImageView *sky;
    SystemSoundID shot;
    //連続で押せないように
    int shotJudge;
    //ぷるぷるjadge判定
    int pullJudge;
    //光判定
    int lightJudge;

    //タッチされた場所の判定
    UITouch *touch;
    //タッチした位置
    CGPoint location1;
    //タッチして指を動かしている位置
    CGPoint location2;
    //タッチが終わった位置
    CGPoint location3;

    //GPS用
    CLLocationManager *locationManager;
    float myLatitude;
    float myLongitude;
    
    //sampleの緯度経度
    float targetLatitude;
    float targetLongitude;
    
    // 方位角を求める
    double azimuth;
    // 現在向いている方位から方位角を引き、今向いている方向から対象物までの角度を算出する
    double targetAzimuth;
    
    //距離を示すラベル
    UILabel *meterLabel;
    int intDis;
}



@end

