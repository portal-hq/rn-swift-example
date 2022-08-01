# Test React Native Integration into Existing iOS Project

based on the article *Integration with Existing Apps* (IWEA) [https://reactnative.dev/docs/integration-with-existing-apps](https://reactnative.dev/docs/integration-with-existing-apps)

## Table of Contents

- [Create iOS Swift Project](#create)
- [Install JavaScript Dependencies](#js)
- [Usage](#usage)
- [Contributing](../CONTRIBUTING.md)

## Create iOS Swift Project <a name = "create"></a>

If you already have an app set up (most likely) you can skip this step.

1. Open Xcode
2. Go to File -> New -> Project
3. Name it (in this case, `TestReactNativeIntegration`)
4. Build to show it works ![Sim](https://i.ibb.co/5kWWzhP/Simulator-Screen-Shot-i-Phone-13-Pro-2022-08-01-at-10-29-45.png)






## Install JavaScript Dependencies <a name = "js"></a>

We'll start loosely following IWEA from above.  Note that we do not follow step 1 in prerequisites -- no need to move code to `ios` folder.

If you need to install `yarn` or `pod` for instruction below, please refer to IWEA guide.

1. In the root of your project set up `package.json` by running `yarn init`.  Enter any info that pertains to your project, and you'll send up with something like this:

```
{
  "name": "TestReactNativeIntegration",
  "version": "1.0.0",
  "main": "index.js",
  "repository": "git@github.com:portal-hq/RN-Swift-Example.git",
  "author": "Elijah Windsor <ewindsor@gmail.com>",
  "license": "MIT"
}
```

2. Create a `start` script in package.json:

```
{
  "name": "TestReactNativeIntegration",
  "version": "1.0.0",
  "main": "index.js",
  "repository": "git@github.com:portal-hq/RN-Swift-Example.git",
  "author": "Elijah Windsor <ewindsor@gmail.com>",
  "license": "MIT",
  "scripts": {
    "start": "yarn react-native start"
  }
}

```

3. Add `react-native` dependency, and note which version of `react` it wants you to install.  Do this by running `yarn add react-native`

Scroll up and find something that looks like:
![showing react version required](https://i.ibb.co/vw4rXhL/Screen-Shot-2022-08-01-at-11-09-04-AM.png)

4. Based on the react version in blue, also add it as a dependency.  In this case we run `yarn add react@18.0.0`

### Prerequisites

What things you need to install the software and how to install them.

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running.

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo.

## Usage <a name = "usage"></a>

Add notes about how to use the system.
