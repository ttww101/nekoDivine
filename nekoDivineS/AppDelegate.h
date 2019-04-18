#import <UIKit/UIKit.h>
#import "RESideMenu.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate,JPUSHRegisterDelegate>{
    NSString *idfa;
    NSData *popupRawJSON;
    BOOL isFirstStart;
    NSMutableDictionary *clientIDFAInfo;
    BOOL googleAdSwitch;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RESideMenu *sideMenuViewController;
@property (strong, nonatomic) NSString *idfa;
@property (strong, nonatomic) NSData *popupRawJSON;
@property (nonatomic) BOOL isFirstStart;
@property (strong, nonatomic) NSMutableDictionary *clientIDFAInfo;
@property (nonatomic) BOOL googleAdSwitch;

@end
