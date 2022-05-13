//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTUIManager.h>
#import <UIKit/UIKit.h>

@interface RCT_EXTERN_MODULE(RNBubbleSelectViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(onSelect, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onDeselect, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRemove, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(allowsMultipleSelection, BOOL)
RCT_EXPORT_VIEW_PROPERTY(longPressDuration, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(removeNodeOnLongPress, BOOL)
RCT_EXPORT_VIEW_PROPERTY(magneticBackgroundColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(initialSelection, NSArray*)

@end
