//
//  Commom.m
//  Fortune
//
//  Created by Bean on 15-5-22.
//  Copyright (c) 2015年 Fortune. All rights reserved.
//

#import "Commom.h"

@implementation Commom


+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    pinyin = [[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return [pinyin uppercaseString];
}

+(UIImage*) imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+(UIImage*) imageWithColorbtnimage:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 28.0f, 2.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    CGSize sizeTemp= CGSizeMake(width, 20000.0f);
    
    UIFont  *font = [UIFont boldSystemFontOfSize:fontSize];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    sizeTemp =[text boundingRectWithSize:sizeTemp options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return sizeTemp;
}

+ (UIViewController *)getCurrentViewController {
    
    UIViewController *result = nil;
    
    __block UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        [windows enumerateObjectsUsingBlock:^(UIWindow *tempWindow, NSUInteger idx, BOOL *stop) {
            
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                
                window = tempWindow;
                *stop = YES;
            }
        }];
    }
    
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    if (result.childViewControllers.count) {
        
        if ([result isKindOfClass:[UITabBarController class]]) {
            
            result = [((UITabBarController *)result) selectedViewController];
        }
        
        for (; result.childViewControllers.count; ) {
            
            if (result.presentedViewController) {
                
                result = [result.presentedViewController.childViewControllers lastObject];
            } else {
                
                result = [result.childViewControllers lastObject];
            }
        }
    }
    
    return result;
}



@end



