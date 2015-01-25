//
//  SignUpViewController.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/05.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    userName = [[UITextField alloc] initWithFrame:CGRectMake(0,0,rect.size.width,rect.size.height/6.4)];
    pass = [[UITextField alloc] initWithFrame:CGRectMake(0,rect.size.height/6.4,rect.size.width,rect.size.height/6.4)];

    userName.background = [UIImage imageNamed:@"whiteEdge.png"];
    pass.background = [UIImage imageNamed:@"whiteEdge.png"];

    userName.delegate = self;
    pass.delegate = self;
    userName.textAlignment = NSTextAlignmentCenter;
    pass.textAlignment = NSTextAlignmentCenter;
    userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor] ,}];
    pass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor] ,}];

    userName.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    pass.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    userName.textColor = [UIColor whiteColor];
    pass.textColor = [UIColor whiteColor];

    [self.view addSubview:userName];
    [self.view addSubview:pass];
    
    UIImage *img = [UIImage imageNamed:@"whiteEdge.png"];  // ボタンにする画像を生成する
    signUp =  [UIButton buttonWithType:UIButtonTypeCustom];
    signUp.frame = CGRectMake(0,rect.size.height/3.2,rect.size.width,rect.size.height/6.4);
    [signUp setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [signUp addTarget:self
            action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [signUp setTitle:@"Sign Up" forState:UIControlStateNormal ];
    signUp.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [signUp setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:signUp];
    
    UIImage *img2 = [UIImage imageNamed:@"whiteEdge.png"];  // ボタンにする画像を生成する
    back =  [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0,rect.size.height/6.4*3,rect.size.width,rect.size.height/6.4);
    [back setBackgroundImage:img2 forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [back addTarget:self
               action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [back setTitle:@"Back" forState:UIControlStateNormal ];
    back.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [back setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:back];



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

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [userName resignFirstResponder];
    [pass resignFirstResponder];
    
    return YES;
}

//キーボードを大文字のみに,10文字以下に
//http://qiita.com/nakacity_people/items/595bef9b3d8fc5801ce9
//http://www.tamurasouko.com/?p=940
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 該当のtextField
    if( textField == userName) {
        
        // 入力済みのテキストを取得
        NSMutableString *str = [textField.text mutableCopy];
        
        // 入力済みのテキストと入力が行われたテキストを結合
        [str replaceCharactersInRange:range withString:string];
        
        if ([str length] > 12) {
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


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    // 最大入力文字数
//    int maxInputLength = 12;
//    
//    // 入力済みのテキストを取得
//    NSMutableString *str1 = [userName.text mutableCopy];
//    
//    // 入力済みのテキストと入力が行われたテキストを結合
//    [str1 replaceCharactersInRange:range withString:string];
//    
//    if ([str1 length] > maxInputLength) {
//        // ※ここに文字数制限を超えたことを通知する処理を追加
//        UIAlertView *Alert3 = [[UIAlertView alloc]initWithTitle:@"登録できません。" message:@"12文字以内にしてください。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [Alert3 show];
//        
//        return NO;
//    }
//    // 入力済みのテキストを取得
//    NSMutableString *str2 = [pass.text mutableCopy];
//    
//    // 入力済みのテキストと入力が行われたテキストを結合
//    [str2 replaceCharactersInRange:range withString:string];
//    
//    if ([str2 length] > maxInputLength) {
//        // ※ここに文字数制限を超えたことを通知する処理を追加
//        UIAlertView *Alert4 = [[UIAlertView alloc]initWithTitle:@"登録できません。" message:@"12文字以内にしてください。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [Alert4 show];
//        
//        return NO;
//
//        
//        return NO;
//    }
//    return YES;
//}

//// テキストフィールドの入力値変更イベント
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *strNgWord = @"!\"\\#$%&'()@[]{}|^~=;: _?<>,/-*.";	// チェック対象の文字を複数定義
//    // 文字数チェック
//    if (12 < range.location + range.length + [string length]) {
//        // 文字数制限を超える場合は入力取り消し
//        return NO;
//    }
//    
//    // 無効な文字列が含まれていないかどうかチェック
//    for (int i=0; i<[strNgWord length]; i++) {
////        // チェック対象の文字を設定
////        NSString *strCk = [strNgWord substringWithRange:NSMakeRange(i, 1)];
//        // 入力値がNGワードと一致する場合
//        if ([string isEqual:userName.text] || [string isEqual:pass.text]) {
//            // 入力取り消し
//            return NO;
//        }
//    }
//    // 入力許可
//    return YES;
//}


-(void)send:(UIButton*)button{
    NSLog(@"%@",userName.text);
    NSLog(@"%@",pass.text);

    if ([userName.text length] == 0 || [pass.text length] == 0) {
        
        UIAlertView *Alert1 = [[UIAlertView alloc]initWithTitle:@"登録できません。" message:@"全ての空欄を埋めて下さい。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [Alert1 show];

        
    }else{
        
//        //Signing up
//        user = [PFUser user];
//        user.username = userName.text;
//        user.password = pass.text;
//        [user signUpInBackgroundWithBlock:^(BOOL succeede, NSError *error){
//            if(!error){
//                
//                //success
//                ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VC"];
//                [self presentViewController:ViewController animated:YES completion:nil];
//                
//            }else{
//                
//                UIAlertView *Alert2 = [[UIAlertView alloc]initWithTitle:@"登録できません。" message:@"名前が重複しています。変更して下さい。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                [Alert2 show];
//            }
//        }];
    }
}


-(void)back:(UIButton*)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
