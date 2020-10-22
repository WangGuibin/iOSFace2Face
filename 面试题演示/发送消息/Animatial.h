//
//  Animatial.h
//  发送消息
//
//  Created by 王贵彬 on 2020/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animatial : NSObject

- (void)sendMessage;
+ (void)sendMessage;

@end

@interface Dog : Animatial

@end

NS_ASSUME_NONNULL_END
