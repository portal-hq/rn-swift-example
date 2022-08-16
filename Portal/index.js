import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'yellow',
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    fontSize: 24,
    textAlign: 'center',
  }
})

const HelloTest = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Hello There, I'm from React Native!</Text>
    </View>
  )
}

AppRegistry.registerComponent('HelloTest', () => HelloTest)