//
//  Feature1ViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/13.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "NekoViewController.h"
#import "UIView+Constraint.h"
#import <StoreKit/StoreKit.h>
#import "SVProgressHUD.h"

//八卦算命大師
@interface NekoViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) NSArray *animationImages;
@property (weak, nonatomic) IBOutlet UIImageView *gacya_neko;
@property (weak, nonatomic) IBOutlet UIButton *gacya_btn;
@property (weak, nonatomic) IBOutlet UIImageView *gacya_coin3;
@property (weak, nonatomic) IBOutlet UIImageView *gacya_coin2;
@property (weak, nonatomic) IBOutlet UIImageView *gacya_coin1;
@property (weak, nonatomic) IBOutlet UIImageView *gacya_flagView;
@property (nonatomic, assign) NSString *gacyaTimes;
@property (nonatomic, assign) NSString *gacyaDate;
@property (nonatomic,strong) NSArray *profuctIdArr;
@property (nonatomic,copy) NSString *currentProId;
@property NSUserDefaults *userDefaults;

@property int n;
@property int random;
@property BOOL sw;

@end

@implementation NekoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sw = NO;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.gacyaTimes = [self.userDefaults stringForKey:@"gacyaTimes"];
    if(self.gacyaTimes != nil && ![self.gacyaTimes isEqual:@""]){
        self.n = [self.gacyaTimes intValue];
    } else {
        self.n = 3;
    }
    
    self.gacyaDate = [self.userDefaults stringForKey:@"gacyaDate"];
    NSLog(@" time: %@", self.gacyaDate);
    if([self dateRemaining:self.gacyaDate] < 0){
        self.n = 3;
    }
    
    NSLog(@"gacyaTimes: %@", self.gacyaTimes);
    
    self.gacya_flagView.hidden = YES;
    self.gacya_flagView.alpha = 0.0f;
 
    switch (self.n) {
        case 3:
            self.gacya_coin3.hidden = NO;
            self.gacya_coin2.hidden = NO;
            self.gacya_coin1.hidden = NO;
            break;
        case 2:
            self.gacya_coin3.hidden = YES;
            self.gacya_coin2.hidden = NO;
            self.gacya_coin1.hidden = NO;
            break;
        case 1:
            self.gacya_coin3.hidden = YES;
            self.gacya_coin2.hidden = YES;
            self.gacya_coin1.hidden = NO;
            break;
        case 0:
            self.gacya_coin3.hidden = YES;
            self.gacya_coin2.hidden = YES;
            self.gacya_coin1.hidden = YES;
            break;
        default:
            break;
    }
}

- (IBAction)gacyaStart:(id)sender {
    if(!self.sw){
    
        self.sw = YES;
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate=[NSDate date];
    NSString *dateString = [formatter stringFromDate:nowDate];
    [self.userDefaults setObject:dateString forKey:@"gacyaDate"];
    
    self.gacya_flagView.hidden = YES;
    self.gacya_flagView.alpha = 0.0f;
    
    switch (self.n) {
        case 3:
            self.gacya_coin3.hidden = YES;
            break;
        case 2:
            self.gacya_coin3.hidden = YES;
            self.gacya_coin2.hidden = YES;
            break;
        case 1:
            self.gacya_coin3.hidden = YES;
            self.gacya_coin2.hidden = YES;
            self.gacya_coin1.hidden = YES;
            break;
        default:
            break;
    }
    
    if( self.n == 0){
        NSLog(@"今日次數沒了喔");
        self.sw = YES;
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        self.profuctIdArr = @[@"com.whitelok.bzsmzbds.cat30"];
        NSString *product = self.profuctIdArr[0];
        _currentProId = product;
        if([SKPaymentQueue canMakePayments]){
            [self requestProductData:product];
        }else{
            NSLog(@"不允许程序内付费");
        }
    } else {
        UIImage *image1 = [UIImage imageNamed:@"gacya_neko1"];
        UIImage *image2 = [UIImage imageNamed:@"gacya_neko2"];
        UIImage *image3 = [UIImage imageNamed:@"gacya_neko3"];
        self.gacya_neko.image = [UIImage animatedImageWithImages:@[image1, image2, image3] duration:1];
        
        self.random = arc4random() % 5;
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(stop:) userInfo:nil repeats:NO];
        }
    }
}

-(void)stop:(NSTimer *)timer {
    self.gacya_neko.image = [UIImage imageNamed:@"gacya_neko1"];
    self.n = self.n - 1;
    
    switch (self.random) {
        case 1:
            [self.gacya_flagView setImage:[UIImage imageNamed:@"gacya_flag1"]];
            break;
        case 2:
            [self.gacya_flagView setImage:[UIImage imageNamed:@"gacya_flag2"]];
            break;
        case 3:
            [self.gacya_flagView setImage:[UIImage imageNamed:@"gacya_flag3"]];
            break;
        case 4:
            [self.gacya_flagView setImage:[UIImage imageNamed:@"gacya_flag4"]];
            break;
        case 5:
            [self.gacya_flagView setImage:[UIImage imageNamed:@"gacya_flag5"]];
            break;
        default:
            break;
    }
    
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        self.gacya_flagView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        self.gacya_flagView.hidden = NO;
    }];
    
    NSString* temp = [[NSString alloc] initWithFormat:@"%d", self.n];
    [self.userDefaults setObject:temp forKey:@"gacyaTimes"];
    self.sw = NO;
}


//计算日期
-(NSInteger)dateRemaining:(NSString *)Date{
    //日期格式设置,可以根据想要的数据进行修改 添加小时和分甚至秒
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //得到时区，根据手机系统时区设置（systemTimeZone）
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    
    //获取当前日期
    NSDate *nowDate=[NSDate date];
    
    /*GMT：格林威治标准时间*/
    //格林威治标准时间与系统时区之间的偏移量（秒）
    NSInteger nowInterval=[zone secondsFromGMTForDate:nowDate];
    
    //将偏移量加到当前日期
    NSDate *nowTime=[nowDate dateByAddingTimeInterval:nowInterval];
    
    //传入日期设置日期格式
    NSDate *yourDate = [dateFormatter dateFromString:Date];
    
    //格林威治标准时间与传入日期之间的偏移量
    NSInteger yourInterval = [zone secondsFromGMTForDate:yourDate];
    
    //将偏移量加到传入日期
    NSDate *yourTime = [yourDate dateByAddingTimeInterval:yourInterval];
    
    //time为两个日期的相差秒数
    NSTimeInterval time=[yourTime timeIntervalSinceDate:nowTime];
    
    //最后通过秒数time计算所剩时间 几年？几月？几天？几时？几秒？
    time = time/(3600*24);
    NSLog(@"時間差： %li", (long)time);
    return (NSInteger)time;
}

//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeBlack];
    
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        [SVProgressHUD dismiss];
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_currentProId]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"支付失败"];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    [SVProgressHUD dismiss];
    NSLog(@"------------反馈信息结束-----------------");
}

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
-(void)verifyPurchaseWithPaymentTransaction{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    
    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //创建请求到苹果官方进行购买验证
    NSURL *url=[NSURL URLWithString:SANDBOX];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
    if([dic[@"status"] intValue]==0){
        NSLog(@"购买成功！");
        NSDictionary *dicReceipt= dic[@"receipt"];
        NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
        NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([productIdentifier isEqualToString:@"123"]) {
            int purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
            [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
        }else{
            [defaults setBool:YES forKey:productIdentifier];
        }
        //在此处对购买记录进行存储，可以存储到开发商的服务器端
        
        self.n = 3;
        switch (self.n) {
            case 3:
                self.gacya_coin3.hidden = NO;
                self.gacya_coin2.hidden = NO;
                self.gacya_coin1.hidden = NO;
                break;
            case 2:
                self.gacya_coin3.hidden = YES;
                self.gacya_coin2.hidden = NO;
                self.gacya_coin1.hidden = NO;
                break;
            case 1:
                self.gacya_coin3.hidden = YES;
                self.gacya_coin2.hidden = YES;
                self.gacya_coin1.hidden = NO;
                break;
            case 0:
                self.gacya_coin3.hidden = YES;
                self.gacya_coin2.hidden = YES;
                self.gacya_coin1.hidden = YES;
                break;
            default:
                break;
        }
        self.sw = NO;
        
    }else{
        NSLog(@"购买失败，未通过验证！");
        
    }
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    
    for(SKPaymentTransaction *tran in transaction){
        
        
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"交易完成");
                [self verifyPurchaseWithPaymentTransaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                
            }
                
                
                
                
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [SVProgressHUD showErrorWithStatus:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
