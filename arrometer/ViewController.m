//
//  ViewController.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/03.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userSave = [NSUserDefaults standardUserDefaults];
    userId = [userSave integerForKey:@"userId"];
    NSLog(@"%d",userId);
    
    //ステータスバーが見えていたら消す
    //http://www.dprog.info/ios/xcode5_status_bar_appearance/
    if( [ UIApplication sharedApplication ].isStatusBarHidden == NO ) {
        [ UIApplication sharedApplication ].statusBarHidden = YES;
    }
    
    //画面サイズの取得
    sc = [UIScreen mainScreen];
    //ステータスバーを除いたサイズ
    rect = sc.applicationFrame;
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, rect.size.height * 0.145833333333333333333333, rect.size.width, rect.size.height - rect.size.height * 0.145833333333333333333333) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    
    UIColor* tableBackgroundColor = [UIColor clearColor];
    [table setBackgroundColor:tableBackgroundColor];
    
    [self.view addSubview:table];
    
    //ヘッダー画像
    UIImageView * hedderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hedder.png"]];
    hedderView.frame = CGRectMake(0,0,rect.size.width,rect.size.height * 0.17905);
    [self.view addSubview:hedderView];
    
    //http://zutto-megane.com/objective-c/post-384/
    //GPSの利用可否判断
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000.0;
        [locationManager startUpdatingLocation];
        NSLog(@"Start updating location.");
        
        // iOS8未満は、このメソッドは無いので
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            // GPSを取得する旨の認証をリクエストする
            // 「このアプリ使っていない時も取得するけどいいでしょ？」
            [locationManager requestAlwaysAuthorization];
        }
        
    } else {
        NSLog(@"The location services is disabled.");
    }
    
    //友達の名前の配列
    friends = [[NSMutableArray alloc] init];
    NSString *ex1 = @"GAMI";
    [friends addObject:ex1];
    NSString *ex2 = @"BANNAROT";
    [friends addObject:ex2];
    NSString *ex3 = @"FABIO";
    [friends addObject:ex3];
    NSString *ex4 = @"KYSER";
    [friends addObject:ex4];
    NSString *ex5 = @"POLO";
    [friends addObject:ex5];
    NSString *ex6 = @"OZKUN";
    [friends addObject:ex6];
    NSString *ex7 = @"THIBAULT";
    [friends addObject:ex7];
    NSString *ex8 = @"DORENTINA";
    [friends addObject:ex8];
    NSString *ex9 = @"MARCO";
    [friends addObject:ex9];
    NSString *ex10 = @"JULIANA";
    [friends addObject:ex10];
    NSString *ex11 = @"POPO";
    [friends addObject:ex11];
    NSString *ex12 = @"AMAAA";
    [friends addObject:ex12];
    NSString *ex13 = @"KAKAKAKA";
    [friends addObject:ex13];
    NSString *ex14 = @"KAKOKKIJHYT";
    [friends addObject:ex14];
    
    //境界線を消す
    table.separatorColor = [UIColor clearColor];
    
    //吹き出しのボタン
    UIImage *imgFukidasi = [UIImage imageNamed:@"newFukidasi.png"];  // ボタンにする画像を生成する
    fukidasi =  [UIButton buttonWithType:UIButtonTypeCustom];
    fukidasi.frame = CGRectMake(rect.size.width/4*3,rect.size.height * 0.145833333333333333333333 / 4,rect.size.width/5,rect.size.width/5);
    [fukidasi setBackgroundImage:imgFukidasi forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にtoFukidasiメソッドを呼び出す
    [fukidasi addTarget:self
                 action:@selector(toOption:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fukidasi];

        
    //UIViewクラスのfilterViewを生成
    filterView = [[UIView alloc] init];
    filterView.frame = CGRectMake(0, 0, rect.size.width,1000);
    filterView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    [self.view addSubview:filterView];
    
    //circleの表示
    UIImage *circle = [UIImage imageNamed:@"circle.png"];
    UIImageView *circlePic = [[UIImageView alloc]initWithImage:circle];
    circlePic.frame = CGRectMake(0,0,rect.size.width/4*3,rect.size.width/4*3);
    circlePic.center = CGPointMake(rect.size.width/2, rect.size.height/5*3);
    [filterView addSubview:circlePic];
    
    //距離を示すラベル
    meterLabel = [[UILabel alloc] init];
    meterLabel.frame = CGRectMake(160,8,rect.size.width,rect.size.width/4);
    meterLabel.center = CGPointMake(rect.size.width/2,rect.size.width/5*2);
    meterLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:70.f];
    meterLabel.textColor = [UIColor colorWithRed:0.11373 green:0.29412 blue:0.61961 alpha:1.0];
    meterLabel.textAlignment = NSTextAlignmentCenter;
    [filterView addSubview:meterLabel];
    
    //arrowが飛ぶ時の背景
    UIImage *sky1 = [UIImage imageNamed:@"sky1.jpg"];
    sky = [[UIImageView alloc]initWithImage:sky1];
    sky.frame = CGRectMake(0,-344,1920,1080);
    sky.alpha = 0.0;
    [filterView addSubview:sky];
    
    //arrow"s back light
    UIImage *arrowBack = [UIImage imageNamed:@"arrowLight.png"];
    arrowLight = [[UIImageView alloc]initWithImage:arrowBack];
    arrowLight.frame = CGRectMake(0,0,rect.size.width/6*1.15,rect.size.width/2*1.15);
    arrowLight.center = CGPointMake(rect.size.width/2, rect.size.height/5*3 - rect.size.width/6*0.1);
    [filterView addSubview:arrowLight];
    arrowLight.alpha = 0.0;
    //arrowの表示
    UIImage *arrow = [UIImage imageNamed:@"arrow.png"];
    arrowPic = [[UIImageView alloc]initWithImage:arrow];
    arrowPic.frame = CGRectMake(0,0,rect.size.width/6,rect.size.width/2);
    arrowPic.center = CGPointMake(rect.size.width/2, rect.size.height/5*3);
    arrowPic.transform = CGAffineTransformMakeRotation(180 * M_PI/180);
    [filterView addSubview:arrowPic];
    //arrowの音
    NSString *path = [[NSBundle mainBundle] pathForResource:@"新規録音" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &shot);
    shotJudge = 0;
    pullJudge = 0;
    lightJudge = 0;


    
    filterView.alpha = 0.0;
    
    cellNum = (int)[friends count] + 1;
    
       
    // キーボードが表示されたときのNotificationをうけとります。（後で）
    [self registerForKeyboardNotifications];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    
    
    CLLocation *newLocation = [locations lastObject];
    // 位置情報を取り出す
    //緯度
    myLatitude = newLocation.coordinate.latitude;
    //経度
    myLongitude = newLocation.coordinate.longitude;
    
    
    NSLog(@"%f",myLatitude);
    NSLog(@"%f",myLongitude);
    NSLog(@"位置情報取得中");
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"位置情報が取得できませんでした。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    
}

//http://blog.koogawa.com/entry/2014/08/12/191215
// CLLocationManager オブジェクトにデリゲートオブジェクトを設定すると初回に呼ばれる
- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        // ユーザが位置情報の使用を許可していない
        NSLog(@"ユーザーが許可してません。");
    }
}

//http://web-terminal.blogspot.com/2013/01/iphonear.html
// 北を基準として二点間の緯度・経度を元に方位角を算出する
//------------------------------------------------------------------------------
float CalculateAngle(float nLat1, float nLon1, float nLat2, float nLon2)
{
    float longitudinalDifference = nLon2 - nLon1;
    float latitudinalDifference  = nLat2 - nLat1;
    float azimuth = (M_PI * .5f) - atan(latitudinalDifference / longitudinalDifference);
    if (longitudinalDifference > 0)   return( azimuth );
    else if (longitudinalDifference < 0) return( azimuth + M_PI );
    else if (latitudinalDifference < 0)  return( M_PI );
    return( 0.0f );
}

//------------------------------------------------------------------------------
// GPSイベント：方位の取得
//------------------------------------------------------------------------------
-(void)locationManager:(CLLocationManager*)manager didUpdateHeading:(CLHeading*)newHeading
{
    // 方位角を求める
    azimuth = CalculateAngle(myLatitude,myLongitude,targetLatitude,targetLongitude);
    
    NSLog(@"azimuth %f",azimuth);
    
    // 現在向いている方位から方位角を引き、今向いている方向から対象物までの角度を算出する
    targetAzimuth = newHeading.trueHeading - azimuth;
    
    NSLog(@"targetAzimuth %f",targetAzimuth);
    /*
     targetAzimuthがマイナス値なら左方向、プラス値なら右方向に対象物があります。
     自分が向いている方向を0度として考える事が出来ます。
     */
    //ここが怪しい
    arrowPic.transform = CGAffineTransformMakeRotation((360-(targetAzimuth + 180)) * M_PI/180);
    arrowLight.transform = CGAffineTransformMakeRotation((360-(targetAzimuth)) * M_PI/180);
    
    NSLog(@"%@",NSStringFromCGRect(arrowPic.frame));
    
    if(targetAzimuth <= 15 || targetAzimuth >= 345) {
        
        if (lightJudge == 0) {
            //ここにコンパスのアニメーションをいれたい
//            [self arrowLightAnimation];
            [self blinkImage:arrowLight];
            arrowLight.alpha = 1.0;
            lightJudge = 1;
        }
    }else{
        lightJudge = 0;
        arrowLight.alpha = 0.0;
        [arrowLight.layer removeAllAnimations];
}
}

//arrow light animation
- (void)blinkImage:(UIImageView *)target {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.01f;
    animation.autoreverses = YES;
    //animation.repeatCount =
    animation.repeatCount = HUGE_VAL; //infinite loop -> HUGE_VAL
    animation.fromValue = [NSNumber numberWithFloat:1.0f]; //MAX opacity
    animation.toValue = [NSNumber numberWithFloat:0.0f]; //MIN opacity
    [target.layer addAnimation:animation forKey:@"blink"];
}

#pragma mark -- テーブルビューに必要なメソッド
//セルにIDをつけるのは、どのセルを再利用して再度表示したいのかを教えるため

//セルの数を決めるメソッド
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellNum;
}


//セルの作り方の設定と、セルの内容を決めるメソッド
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];

    }
    
    
    //http://works.sabitori.com/2011/06/18/table-redraw/
    // サブビューを取り除く
    for (UIView *subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
    }
    
    
    table.rowHeight = rect.size.height/6.4;
    
    /* -- cellに直接ラベルを載せれないので、UIViewを1クッション置く。 -- */
    //UIViewクラスのmyViewを生成
    UIView * myView = [[UIView alloc] init];
    myView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height/6.4);
    myView.backgroundColor = [UIColor clearColor];
    
    //myViewをcellに表示
    [cell.contentView addSubview:myView];
    
    UIImage *userBack = [UIImage imageNamed:@"newUserBack.png"];
    UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
    userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.34482759);
    [myView addSubview:userBackPic];

    //画像を表示
//
//    if (indexPath.row == 0) {
//        UIImage *userBack = [UIImage imageNamed:@"newUserBack.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else if(indexPath.row == 1){
//        UIImage *userBack = [UIImage imageNamed:@"newUserBack.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else if(indexPath.row == 2){
//        UIImage *userBack = [UIImage imageNamed:@"userBack3.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else if(indexPath.row == 3){
//        UIImage *userBack = [UIImage imageNamed:@"userBack4.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else if(indexPath.row == 4){
//        UIImage *userBack = [UIImage imageNamed:@"userBack5.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else if(indexPath.row == 5){
//        UIImage *userBack = [UIImage imageNamed:@"userBack6.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }else{
//        UIImage *userBack = [UIImage imageNamed:@"userBack7.png"];
//        UIImageView *userBackPic = [[UIImageView alloc]initWithImage:userBack];
//        userBackPic.frame = CGRectMake(0,0,rect.size.width,rect.size.height/6.4);
//        [myView addSubview:userBackPic];
//    }
    
    if (indexPath.row + 1 < cellNum) {
        //ラベル
        UILabel *friendLabel = [[UILabel alloc] init];
        friendLabel.frame = CGRectMake(160,8,rect.size.width,rect.size.width/4);
        friendLabel.center = CGPointMake(rect.size.width/2,rect.size.height/6.34482759/2);
        friendLabel.text = [friends objectAtIndex:indexPath.row];
//        friendLabel.font = [UIFont fontWithName:@"PopJoyStd-B" size:rect.size.height/16];
        UIFont *font = [UIFont fontWithName:@"PopJoyStd-B" size:rect.size.height/16];
        [friendLabel setFont:font];
        friendLabel.textColor = [UIColor whiteColor];
        friendLabel.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:friendLabel];
        
    }else{
        
        addUser = [[UITextField alloc] initWithFrame:CGRectMake(0,0,rect.size.width,rect.size.height/6.4)];
        addUser.textAlignment = NSTextAlignmentCenter;
        addUser.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"+" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor] ,}];
        addUser.font = [ UIFont fontWithName:@"PopJoyStd-B" size:rect.size.height/16];
        addUser.textColor = [UIColor whiteColor];
        addUser.returnKeyType = UIReturnKeyJoin;
        addUser.delegate = self;
        [myView addSubview:addUser];


    }
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"Yuki"] = @"Futagami";
//    [testObject saveInBackground];
    
    // cellがタップされた際の処理
    if (indexPath.row + 1 < cellNum) {
        [UIView animateWithDuration:0.5f
                         animations:^{
                             // アニメーションをする処理
                             filterView.alpha = 1.0;
                         }
         ];
        
        //16thbartstation
        targetLatitude = 37.764799;
        targetLongitude =  -122.419981;
        
        // 経緯・緯度からCLLocationを作成
        CLLocation *A = [[CLLocation alloc] initWithLatitude:targetLatitude longitude:targetLongitude];
        CLLocation *B = [[CLLocation alloc] initWithLatitude:myLatitude longitude:myLongitude];
        
        //　距離を取得
        CLLocationDistance distance = [A distanceFromLocation:B];
        // 距離をコンソールに表示
        NSLog(@"distance:%f", distance);
        intDis = roundf(distance);
        meterLabel.text = [NSString stringWithFormat:@"%dm",intDis];
        //viewDidLoadにあるから多分いらない
//        [locationManager startUpdatingLocation]; // 現在位置を取得する
        [locationManager startUpdatingHeading]; // コンパスの向きを取得
        NSLog(@"コンパス呼ばれてる");

    }else{
        
        table.userInteractionEnabled = NO;
        [addUser becomeFirstResponder];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (filterView.alpha == 1.0) {
        // シングルタッチの場合
        touch = [touches anyObject];
        location1 = [touch locationInView:filterView];
        //    NSLog(@"x:%f y:%f", location1.x, location1.y);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (filterView.alpha == 1.0) {
        
        if (targetAzimuth <= 15 || targetAzimuth >= 345) {
            arrowLight.alpha = 0.0;
            [arrowLight.layer removeAllAnimations];
            if (shotJudge == 0) {
                touch = [touches anyObject];
                location2 = [touch locationInView:filterView];
                //            NSLog(@"x:%f y:%f", location2.x, location2.y);
                [locationManager stopUpdatingHeading];
                arrowPic.center = CGPointMake(rect.size.width/2, rect.size.height/5*3 + ((location2.y - location1.y)/2));
                arrowPic.transform = CGAffineTransformMakeRotation(180 * M_PI/180);
                //            NSLog(@"アローの場所は%@",NSStringFromCGPoint(arrowPic.center));
                if(((location2.y - location1.y)/2) >= rect.size.width * 0.2){
                    if ( pullJudge == 0) {
                        [self arrowPullAnimation];
                        pullJudge = 1;
                    }
                }else{
                    pullJudge = 0;
                    [arrowPic.layer removeAllAnimations];
                }
                
            }
        }
    }
}

-(void)arrowPullAnimation
{
    NSLog(@"アニメーション呼ばれた！");
    //http://do-gugan.com/~furuta/archives/2011/10/post_341.html
    [UIView setAnimationRepeatAutoreverses:TRUE]; //最初の位置に戻る
       [UIView animateWithDuration:.05
                             delay:0.01
                           options:UIViewAnimationOptionRepeat
                     animations:^(void) {
                         arrowPic.center = CGPointMake(arrowPic.center.x - rect.size.width * 0.012, arrowPic.center.y);
                     }
                     completion:^(BOOL finished) {
                             arrowPic.center = CGPointMake(arrowPic.center.x + rect.size.width * 0.012, arrowPic.center.y);
                     }];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (filterView.alpha == 1.0) {
        
        
        touch = [touches anyObject];
        location3 = [touch locationInView:filterView];
        NSLog(@"x:%f y:%f", location3.x, location3.y);
        
        if (location1.x - 10 <= location3.x && location1.x + 10 >= location3.x && location1.y - 10 <= location3.y && location1.y + 10 >= location3.y) {
            
            // タッチされたときの処理
            if (filterView.alpha == 1.0) {
                [UIView animateWithDuration:0.5f
                                 animations:^{
                                     // アニメーションをする処理
                                     filterView.alpha = 0.0;
                                 }];
                [locationManager stopUpdatingHeading];
            }
        }else{
            if (targetAzimuth <= 15 || targetAzimuth >= 345) {
                if (((location2.y - location1.y)/2) >= rect.size.width * 0.2) {
                    if (shotJudge == 0) {
                        shotJudge = 1;
                        arrowPic.transform = CGAffineTransformMakeRotation(180 * M_PI/180);
                        arrowPic.center = CGPointMake(rect.size.width/2,arrowPic.center.y);
                        sky.alpha = 1.0;
                        [arrowPic.layer removeAllAnimations];
                        [arrowLight.layer removeAllAnimations];
                        //touch event unavailable
                        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                        AudioServicesPlaySystemSound(shot);
                        [UIView animateWithDuration:1.5f
                                         animations:^{
                                             // アニメーションをする処理
                                             arrowPic.center = CGPointMake(rect.size.width/2,-300);
                                             sky.frame = CGRectMake(0,0,1920,1080);
                                         }
                                         completion:^(BOOL finished){
                                             // アニメーションが終わった後実行する処理
                                             arrowPic.center = CGPointMake(rect.size.width/2,rect.size.height/5*3);
                                             shotJudge = 0;
                                             lightJudge = 0;
                                             sky.alpha = 0.0;
                                             sky.frame = CGRectMake(0,-344,1920,1080);
                                             //touch event available
                                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                             [locationManager startUpdatingHeading]; // コンパスの向きを取得
                                         }];
                        
                    }
                }else{
                    [UIView animateWithDuration:0.3f
                                     animations:^{
                                         // アニメーションをする処理
                                         arrowPic.center = CGPointMake(rect.size.width/2, rect.size.height/5*3);
                                     }
                                     completion:^(BOOL finished){
                                         // アニメーションが終わった後実行する処理
                                         [locationManager startUpdatingHeading]; // コンパスの向きを取得
                                     }];
                }
                
            }
        }
    }
}

-(void)toOption:(UIButton*)button{
    
    ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OVC"];
    [self presentViewController:ViewController animated:YES completion:nil];
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    
    [addUser resignFirstResponder];
    table.userInteractionEnabled = YES;

//    //ユーザーが存在するかどうかを確認
//    PFQuery *pfQuery = [PFQuery queryWithClassName:@"_User"];
//    [pfQuery whereKey:@"username" equalTo:addUser.text];
//    [pfQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        if (object == nil){
//            NSLog(@"%@", error.description);
//            UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"追加できません。" message:@"該当するユーザーが存在しません。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [Alert show];
//
//        }else{
//            NSLog(@"%@", object[@"username"]);
//        }
//    }];
    return YES;
}

//キーボードを大文字のみに,10文字以下に
//http://qiita.com/nakacity_people/items/595bef9b3d8fc5801ce9
//http://www.tamurasouko.com/?p=940
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 該当のtextField
    if( textField == addUser) {
        
        // 入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        // 入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        if ([str length] > 11) {
            // ※ここに文字数制限を超えたことを通知する処理を追加
            
            return NO;
        }else{
            
            // deleteの時
            if( string.length == 0 ) return YES;
            
            BOOL canEdit = YES;
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
            for (int i = 0; i < string.length; i++)
            {
                unichar c = [string characterAtIndex:i];
                if (![myCharSet characterIsMember:c]) {
                    canEdit = NO;
                    
                    if( 'a' <= c && c <= 'z' ) {
                        NSString *str = [[NSString stringWithFormat:@"%c", c] uppercaseString];
                        textField.text = [textField.text stringByReplacingCharactersInRange:NSMakeRange(range.location+i, 0) withString:str];
                    }
                }
            }
            return canEdit;
        }
    }else return YES;
    
    
    
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // キーボードの表示開始時の場所と大きさを取得します。
    CGRect keyboardFrameBegin = [[aNotification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];

    CGPoint scrollPoint = CGPointMake(0.0,rect.size.height/6.4 * (cellNum - 6) + rect.size.height/11.8 + keyboardFrameBegin.size.height);
    [table setContentOffset:scrollPoint animated:YES];

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGPoint scrollReturnPoint = CGPointMake(0.0,rect.size.height/6.4 * (cellNum - 6) + rect.size.height/11.8);
    [table setContentOffset:scrollReturnPoint animated:YES];
}




@end
