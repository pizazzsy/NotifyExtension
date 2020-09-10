//
//  AppDelegate.m
//  推送扩展demo
//
//  Created by 承启通 on 2020/8/11.
//  Copyright © 2020 承启通. All rights reserved.
//

#import "AppDelegate.h"
#import  <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate
@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registPush:application andOptions:launchOptions];

    return YES;
}

-(void)registPush:(UIApplication *)application andOptions:(NSDictionary *)launchOptions{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                  NSLog(@"========%@",settings);
        }];
    } else {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            //IOS8，创建UIUserNotificationSettings，并设置消息的显示类类型
            UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
            [application registerUserNotificationSettings:notiSettings];
        }
    }
//    UNNotificationAction * likeAction;              //喜欢
//    UNNotificationAction * ingnoreAction;           //取消
//    UNNotificationAction * emojiAction;             //自定义表情
//    UNTextInputNotificationAction * inputAction;    //文本输入
//    
//    likeAction = [UNNotificationAction actionWithIdentifier:@"action_like"
//                                                      title:@"点赞"
//                                                    options:UNNotificationActionOptionForeground];
//
//    inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"action_input"
//                                                                title:@"评论"
//                                                              options:UNNotificationActionOptionForeground
//                                                 textInputButtonTitle:@"发送"
//                                                 textInputPlaceholder:@"说点什么"];
//    
//    emojiAction = [UNNotificationAction actionWithIdentifier:@"action_emoji"
//                                                       title:@"表情"
//                                                     options:UNNotificationActionOptionForeground];
//    
//    ingnoreAction = [UNNotificationAction actionWithIdentifier:@"action_cancel"
//                                                         title:@"忽略"
//                                                       options:UNNotificationActionOptionForeground];
//
//    UNNotificationCategory * category;
//    category = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategory"
//                                                         actions:@[likeAction, inputAction, ingnoreAction]
//                                               intentIdentifiers:@[]
//                                                         options:UNNotificationCategoryOptionNone];
//       
//    NSSet * sets = [NSSet setWithObjects:category, nil];
//    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:sets];
       
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token成功:%@",token);
}
//获取DeviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"[DeviceToken 失败]:%@\n",error.description);
}
#pragma mark - iOS10 收到通知（本地和远端） UNUserNotificationCenterDelegate

//App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

//    NSLog(@"iOS10 收到本地通知：%@",notification.request.content.userInfo);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}
    

//App通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{

//    NSLog(@"iOS10 收到本地通知（点击）：%@",response.notification.request.content.userInfo);
    completionHandler(); // 系统要求执行这个方法
}
#pragma mark -iOS 10之前收到通知

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    //此处省略一万行需求代码。。。。。。
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
