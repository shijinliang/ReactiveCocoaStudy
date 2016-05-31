//
//  ShowPromptMessage.h
//  ReactiveCocoaStudy
//
//  Created by xiaoshi on 16/5/31.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ShowPromptMessage : NSObject
/**
 *  ShowPromptMessage单例
 */
+ (ShowPromptMessage*)sharedManager;

/**
 *  显示message
 */
- (void)showPromptMessage:(NSString*)message;
@end
