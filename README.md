# react-native-bubble-chart

An easy-to-use customizable bubble animation chart, similar to the Apple Music genre selection

## Features

* iOS Support (In beta)
* Typescript Sup  port
* Customizable

## Installation

```sh
yarn add react-native-bubble-chart
```

```sh
npm install react-native-bubble-chart --save
```

## iOS Installation

If you're using React Native versions > 60.0, it's relatively straightforward.

```sh
cd ios && pod install
```

For versions below 0.60.0, use rnpm links

* Run ```sh react-native link react-native-bubble-select```
* If linking fails, follow the manual linking steps

## Usage

```js
import * as React from 'react';
import {
  StyleSheet,
  View,
  Text,
  SafeAreaView,
  Button,
  Platform,
  Dimensions,
} from 'react-native';
import BubbleSelect, { Bubble, BubbleNode } from 'react-native-bubble-chart';
import randomCity, { randomCities } from './randomCity';

const { width, height } = Dimensions.get('window');

export default function App() {
  const [cities, setCities] = React.useState<any[]>([]);
  const [force, setForce] = React.useState(false);
  const [selectedCites, setSelectedCities] = React.useState<BubbleNode[]>([]);
  const [removedCities, setRemovedCities] = React.useState<BubbleNode[]>([]);

  React.useEffect(() => {
    if (force) {
      setCities(randomCities());
    }
  }, [force]);

  React.useEffect(() => {
    if (Platform.OS === 'ios') {
      setForce(true);
    } else {
      setCities(randomCities());
    }
  }, []);

  const addCity = () => {
    setCities([...cities, randomCity()]);
  };

  const handleSelect = (bubble: BubbleNode) => {
    setSelectedCities([...selectedCites, bubble]);
  };

  const handleDeselect = (bubble: BubbleNode) => {
    setSelectedCities(selectedCites.filter(({ id }) => id !== bubble.id));
  };

  const handleRemove = (bubble: BubbleNode) => {
    console.log(bubble);
    setRemovedCities([...removedCities, bubble]);
  };

  return (
    <BubbleSelect
      onSelect={handleSelect}
      onDeselect={handleDeselect}
      onRemove={handleRemove}
      width={width}
      height={height}
      fontName={Platform.select({
        ios: 'SinhalaSangamMN-Bold',
        android: 'sans-serif-medium',
      })}
      autoSize={true}
    >
      {cities.map((city, index) => (
        <Bubble
          key={city.id}
          id={city.id}
          text={city.text}
          title={city.text}
          // subTitle={city.text}
          value={Math.round((Math.random() * 91 + 10) * 100) / 100}
          surfix="%"
          valueSize={14}
          titleSize={18}
          color={city.color}
          selectedColor={city.selectedColor}
          selectedScale={city.selectedScale}
          gradient={city.gradient}
          lineHeight={16}
          icon={
            index % 2
              ? require('../assets/plus.png')
              : require('../assets/download.png')
          }
          iconSize={32}
        />
      ))}
    </BubbleSelect>
  );
}

```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
