//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTUIManager.h>

@interface RCT_EXTERN_MODULE(RNBubbleSelectNodeViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(id, NSString)
RCT_EXPORT_VIEW_PROPERTY(value, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(title, NSString)
RCT_EXPORT_VIEW_PROPERTY(subTitle, NSString)
RCT_EXPORT_VIEW_PROPERTY(prefix, NSString)
RCT_EXPORT_VIEW_PROPERTY(surfix, NSString)
RCT_EXPORT_VIEW_PROPERTY(icon, UIImage)
RCT_EXPORT_VIEW_PROPERTY(image, UIImage)
RCT_EXPORT_VIEW_PROPERTY(color, UIColor)
RCT_EXPORT_VIEW_PROPERTY(radius, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(marginScale, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(valueSize, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(titleSize, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(subTitleSize, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(iconSize, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(valueColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(titleColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(subTitleColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(fontName, NSString)
RCT_EXPORT_VIEW_PROPERTY(lineHeight, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(borderColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(borderWidth, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(padding, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(selectedScale, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(deselectedScale, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(animationDuration, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(selectedColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(selectedFontColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(autoSize, BOOL)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
