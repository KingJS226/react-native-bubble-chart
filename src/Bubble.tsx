import React from 'react';
import {
  requireNativeComponent,
  Platform,
  ImageSourcePropType,
  Image,
} from 'react-native';

const RNBubble = requireNativeComponent('RNBubbleSelectNodeView');

export interface BubbleNode {
  id: string;
  text: string;
  value: number;
  title?: string;
  subTitle?: string;
  prefix?: string;
  surfix?: string;
  icon?: ImageSourcePropType;
}

export type BubbleProps = BubbleNode & {
  color?: string;
  radius?: number;
  marginScale?: number;
  fontName?: string;
  fontSize?: number;
  valueSize?: number;
  titleSize?: number;
  subTitleSize?: number;
  iconSize?: number;
  fontColor?: string;
  valueColor?: string;
  titleColor?: string;
  subTitleColor?: string;
  fontStyle?: 'bold' | 'bold-italic' | 'normal';
  lineHeight?: number;
  borderColor?: string;
  borderWidth?: number;
  padding?: number;
  selectedScale?: number;
  deselectedScale?: number;
  animationDuration?: number;
  selectedColor?: string;
  selectedFontColor?: string;
  autoSize?: boolean;
  gradient?: {
    startColor: string;
    endColor: string;
    direction: 'horizontal' | 'vertical';
  };
  image?: ImageSourcePropType;
};

const Bubble = ({
  text,
  value,
  title,
  subTitle,
  prefix,
  surfix,
  icon,
  color,
  radius,
  marginScale,
  id,
  fontName,
  fontSize,
  valueSize,
  titleSize,
  subTitleSize,
  iconSize,
  fontColor,
  valueColor,
  titleColor,
  subTitleColor,
  lineHeight,
  fontStyle,
  padding,
  borderColor,
  borderWidth,
  selectedScale,
  deselectedScale,
  selectedColor,
  animationDuration,
  selectedFontColor,
  autoSize,
  gradient,
  image,
}: BubbleProps) => {
  const props = Platform.select({
    ios: {
      text,
      value,
      title,
      subTitle,
      prefix,
      surfix,
      color,
      radius,
      marginScale,
      id,
      fontName,
      fontSize,
      valueSize,
      titleSize,
      subTitleSize,
      iconSize,
      fontColor,
      valueColor,
      titleColor,
      subTitleColor,
      lineHeight,
      padding,
      borderColor,
      borderWidth,
      selectedScale,
      deselectedScale,
      animationDuration,
      selectedColor,
      selectedFontColor,
      autoSize,
      icon: icon ? Image.resolveAssetSource(icon) : undefined,
      image: image ? Image.resolveAssetSource(image) : undefined,
    },
    android: {
      text,
      color,
      id,
      fontFamily: fontName,
      fontSize,
      fontColor,
      fontStyle,
      gradient,
    },
  });

  return <RNBubble {...props} />;
};

export default Bubble;
