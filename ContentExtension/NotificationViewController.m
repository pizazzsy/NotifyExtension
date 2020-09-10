//
//  NotificationViewController.m
//  ContentExtension
//
//  Created by 承启通 on 2020/8/11.
//  Copyright © 2020 承启通. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
//    self.label.text = notification.request.content.body;
}

@end
