import React from 'react';
import { BubbleNode, BubbleProps } from './Bubble';
import {
  NativeSyntheticEvent,
  requireNativeComponent,
  Platform,
} from 'react-native';

const RNBubbleSelect = requireNativeComponent('RNBubbleSelectView');

export type BubbleSelectProps = Omit<
  BubbleProps,
  'text' | 'id' | 'value' | 'title' | 'subTitle' | 'icon'
> & {
  onSelect?: (bubble: BubbleNode) => void;
  onDeselect?: (bubble: BubbleNode) => void;
  onRemove?: (bubble: BubbleNode) => void;
  bubbleSize?: number;
  allowsMultipleSelection?: boolean;
  children: React.ReactNode;
  style?: object;
  width?: number;
  height?: number;
  removeOnLongPress?: boolean;
  longPressDuration?: number;
  backgroundColor?: string;
  maxSelectedItems?: number;
  initialSelection?: string[];
};

const BubbleSelect = ({
  onSelect,
  onDeselect,
  style,
  allowsMultipleSelection = true,
  children,
  bubbleSize,
  onRemove,
  removeOnLongPress = true,
  longPressDuration,
  width = 200,
  height = 200,
  backgroundColor,
  maxSelectedItems,
  initialSelection = [],
  ...bubbleProps
}: BubbleSelectProps) => {
  const defaultStyle = {
    flex: 1,
    width,
    height,
  };

  const handleSelect = (event: NativeSyntheticEvent<BubbleNode>) => {
    if (onSelect) {
      onSelect(event.nativeEvent);
    }
  };

  const handleDeselect = (event: NativeSyntheticEvent<BubbleNode>) => {
    if (onDeselect) {
      onDeselect(event.nativeEvent);
    }
  };

  const handleRemove = (event: NativeSyntheticEvent<BubbleNode>) => {
    if (onRemove) {
      onRemove(event.nativeEvent);
    }
  };

  const platformProps = Platform.select({
    android: {
      style: { ...defaultStyle, ...style },
      onSelect: handleSelect,
      onDeselect: handleDeselect,
      onRemove: handleRemove,
      onSelectNode: handleSelect,
      onDeselectNode: handleDeselect,
      onRemoveNode: onRemove,
      allowsMultipleSelection: allowsMultipleSelection,
      removeNodeOnLongPress: removeOnLongPress,
      longPressDuration: longPressDuration,
      magneticBackgroundColor: backgroundColor,
      bubbleSize,
      backgroundColor,
      maxSelectedItems,
    },
    ios: {
      onSelect: handleSelect,
      onDeselect: handleDeselect,
      onRemove: handleRemove,
      style: { ...defaultStyle, ...style },
      allowsMultipleSelection: allowsMultipleSelection,
      removeNodeOnLongPress: removeOnLongPress,
      longPressDuration: longPressDuration,
      magneticBackgroundColor: backgroundColor,
      initialSelection,
    },
  });

  return (
    <RNBubbleSelect {...platformProps}>
      {React.Children.map(children, (child: any) =>
        React.cloneElement(child, bubbleProps)
      )}
    </RNBubbleSelect>
  );
};

export default BubbleSelect;
