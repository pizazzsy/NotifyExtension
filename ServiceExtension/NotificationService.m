//
//  NotificationService.m
//  ServiceExtension
//
//  Created by 承启通 on 2020/8/11.
//  Copyright © 2020 承启通. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    NSLog(@"收到推送消息，可进行处理");
//      这里重写一些东西
        self.bestAttemptContent.title = @"这里是标题";
        self.bestAttemptContent.subtitle = @"这里是子标题";
        self.bestAttemptContent.body = @"这里是body";
    
    // ！！！！！ 这里是重点！！！！！！！！！！！！
    // 我在这里写死了myNotificationCategory，其实在收到系统推送时，每一个推送内容最好带上一个catagory，跟服务器约定好了，这样方便我们根据categoryIdentifier来自定义不同类型的视图，以及action
    //myNotificationCategory这个值要跟info.plist里面的值一样
    self.bestAttemptContent.categoryIdentifier = @"myNotificationCategory";
    self.contentHandler(self.bestAttemptContent);
}
-(void)initAction{
        UNNotificationAction * likeAction;              //喜欢
        UNNotificationAction * ingnoreAction;           //取消
        UNNotificationAction * emojiAction;             //自定义表情
        UNTextInputNotificationAction * inputAction;    //文本输入
        likeAction = [UNNotificationAction actionWithIdentifier:@"action_like"
                                                          title:@"点赞"
                                                        options:UNNotificationActionOptionForeground];
        inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"action_input"
                                                                    title:@"评论"
                                                                  options:UNNotificationActionOptionForeground
                                                     textInputButtonTitle:@"发送"
                                                     textInputPlaceholder:@"说点什么"];
        emojiAction = [UNNotificationAction actionWithIdentifier:@"action_emoji"
                                                           title:@"表情"
                                                         options:UNNotificationActionOptionForeground];
        ingnoreAction = [UNNotificationAction actionWithIdentifier:@"action_cancel"
                                                             title:@"忽略"
                                                           options:UNNotificationActionOptionForeground];
        UNNotificationCategory * category;
        category = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategory"
                                                             actions:@[likeAction, inputAction, ingnoreAction]
                                                   intentIdentifiers:@[]
                                                             options:UNNotificationCategoryOptionNone];
    
        NSSet * sets = [NSSet setWithObjects:category, nil];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:sets];
}
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
