//
//  LoginViewController.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/08.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    userName.keyboardType = UIKeyboardTypeASCIICapable;
    pass.keyboardType = UIKeyboardTypeASCIICapable;
    
    [self.view addSubview:userName];
    [self.view addSubview:pass];
    
    UIImage *img = [UIImage imageNamed:@"whiteEdge.png"];  // ボタンにする画像を生成する
    login =  [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(0,rect.size.height/3.2,rect.size.width,rect.size.height/6.4);
    [login setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にsendメソッドを呼び出す
    [login addTarget:self
               action:@selector(toLogin:) forControlEvents:UIControlEventTouchUpInside];
    [login setTitle:@"Log In" forState:UIControlStateNormal ];
    login.titleLabel.font = [ UIFont fontWithName:@"AvenirNext-UltraLight" size:rect.size.height/16];
    [login setTitleColor:[ UIColor whiteColor ] forState:UIControlStateNormal ];
    [self.view addSubview:login];
    
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


-(void)toLogin:(UIButton*)button{
    NSLog(@"%@",userName.text);
    NSLog(@"%@",pass.text);
    
   
    
    
    if ([userName.text length] == 0 || [pass.text length] == 0) {
        
        UIAlertView *Alert1 = [[UIAlertView alloc]initWithTitle:@"登録できません。" message:@"全ての空欄を埋めて下さい。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [Alert1 show];
        
        
    }else{
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSDictionary *parameters = @{@"name":userName.text,@"pass":pass.text};
//        [manager GET:@"https://hidden-atoll-8201.herokuapp.com/api/v1/members/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//            //            if ([responseObject[@"name"] isEqualToString:userName.text]) {
////                NSLog(@"%d",[responseObject[@"id"] intValue]);
////            }
//            
//            NSLog(@"JSON: %@", responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
        // AFHTTPRequestOperationManagerを利用して、http://localhost/test.jsonからJSONデータを取得する
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:@"https://hidden-atoll-8201.herokuapp.com/api/v1/members/"
          parameters:@{@"name" :userName.text}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 // 通信に成功した場合の処理
                 NSLog(@"responseObject: %@", responseObject);

//                 NSString *trueUser = responseObject[[userName.text lowercaseString]];
//                 NSString *trueUser = [responseObject objectForKey:[userName.text lowercaseString]];
//                  NSArray *ar = [responseObject allValues];


//                 NSLog(@"%@",trueUser);
//                 if ([responseObject[@"name"] isEqualToString:userName.text]) {
//                     NSDictionary *result = responseObject;
//                     NSLog(@"%d",[result[@"id"] intValue]);
//                 }
               
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 // エラーの場合はエラーの内容をコンソールに出力する
                 NSLog(@"Error: %@", error);
             }];
    }
}


-(void)back:(UIButton*)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
