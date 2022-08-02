# Test React Native Integration into Existing iOS Project

based on the article *Integration with Existing Apps* (IWEA) [https://reactnative.dev/docs/integration-with-existing-apps](https://reactnative.dev/docs/integration-with-existing-apps)

## Table of Contents

- [Create iOS Swift Project](#create)
- [Install JavaScript Dependencies](#js)
- [Install Cocoapods](#pod)
- [JavaScript Code Integration](#jsintegrationn)
- [Swift Integration](#swift)
- [Add Build Phase for Bundling JS](#buildphase)
- [Update URL for JS source](#jsurl)

## Create iOS Swift Project <a name = "create"></a>

If you already have an app set up (most likely) you can skip this step.

1. Open Xcode
2. Go to File -> New -> Project
3. Name it (in this case, `TestReactNativeIntegration`)
4. Build to show it works ![Sim](https://i.ibb.co/5kWWzhP/Simulator-Screen-Shot-i-Phone-13-Pro-2022-08-01-at-10-29-45.png)


## Install JavaScript Dependencies <a name = "js"></a>

We'll start loosely following IWEA from above.  Note that we do not follow step 1 in prerequisites -- no need to move code to `ios` folder.

If you need to install `yarn` or `pod` for instruction below, please refer to IWEA guide.

1. In the root of your project set up `package.json` by running `yarn init`.  Enter any info that pertains to your project, and you'll end up with something like this:

```
  {
    "name": "PROJECT_TITLE",
    "version": "1.0.0",
    "main": "index.js",
    "repository": "git@github.com:REPO_NAME.git",
    "author": "AUTHOR NAME <AUTHOR@EMAIL.com>",
    "license": "MIT"
  }
```

2. Create a `start` script in package.json:

```
  {
    "name": "PROJECT_TITLE",
    "version": "1.0.0",
    "main": "index.js",
    "repository": "git@github.com:REPO_NAME.git",
    "author": "AUTHOR NAME <AUTHOR@EMAIL.com>",
    "license": "MIT"
    "scripts": {
      "start": "yarn react-native start"
    }
  }

```

3. Add `react-native` dependency, and note which version of `react` it wants you to install.  Do this by running `yarn add react-native`

Scroll up and find something that looks like:
![showing react version required](https://i.ibb.co/vw4rXhL/Screen-Shot-2022-08-01-at-11-09-04-AM.png)

4. Based on the react version in blue, also add it as a dependency.  In this case we run `yarn add react@18.0.0`


## Install Cocapods <a name = "pod"></a>

1. If you do not have a `Podfile` in your project, you can create one by running (like in the IWEA): `pod init`

  You may end up with something like this:

  ```
  # Uncomment the next line to define a global platform for your project
  # platform :ios, '9.0'

  target 'TestReactNativeIntegration' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for TestReactNativeIntegration

  end
```

If you have one feel free to skip this step.

2. Now that we have a `Podfile`, this is where we IWEA is a bit outdated.  If you were to create a brand-new react native project (without an existing iOS project), you'd notice that `ios/Podfile` looks something like this (assuming we named our project `TestThis`)

***Note we change the relative directory from `../node_modules` to `./node_modules` -- this is because they're in the same directory.***

```
  require_relative './node_modules/react-native/scripts/react_native_pods'
  require_relative './node_modules/@react-native-community/cli-platform-ios/native_modules'

  platform :ios, '12.4'
  install! 'cocoapods', :deterministic_uuids => false

  production = ENV["PRODUCTION"] == "1"

  target 'TestThis' do
    config = use_native_modules!

    # Flags change depending on the env values.
    flags = get_default_flags()

    use_react_native!(
      :path => config[:reactNativePath],
      # to enable hermes on iOS, change `false` to `true` and then install pods
      :production => production,
      :hermes_enabled => flags[:hermes_enabled],
      :fabric_enabled => flags[:fabric_enabled],
      :flipper_configuration => FlipperConfiguration.enabled,
      # An absolute path to your application root.
      :app_path => "#{Pod::Config.instance.installation_root}/.."
    )

    target 'TestThisTests' do
      inherit! :complete
      # Pods for testing
    end

    post_install do |installer|
      react_native_post_install(installer)
      __apply_Xcode_12_5_M1_post_install_workaround(installer)
    end
  end
```

We need to essentially copy that into our existing `Podfile`.  In the case of this project it looks like:

```
  require_relative './node_modules/react-native/scripts/react_native_pods'
  require_relative './node_modules/@react-native-community/cli-platform-ios/native_modules'

  platform :ios, '12.4'
  install! 'cocoapods', :deterministic_uuids => false

  production = ENV["PRODUCTION"] == "1"


  target 'TestReactNativeIntegration' do
    config = use_native_modules!

    # Flags change depending on the env values.
    flags = get_default_flags()

    use_react_native!(
      :path => config[:reactNativePath],
      # to enable hermes on iOS, change `false` to `true` and then install pods
      :production => production,
      :hermes_enabled => flags[:hermes_enabled],
      :fabric_enabled => flags[:fabric_enabled],
      :flipper_configuration => FlipperConfiguration.enabled,
      # An absolute path to your application root.
      :app_path => "#{Pod::Config.instance.installation_root}/.."
    )

    post_install do |installer|
      react_native_post_install(installer)
      __apply_Xcode_12_5_M1_post_install_workaround(installer)
    end
  end
```

3. Run `pod install`

4. Now open your project's `.xcworkspace` (you will need to close out of the `.xcodeproj` first if it is open.)

5. Do another build / run in the Simulator to make sure it works


## JavaScript Code Integration <a name = "jsintegration"></a>

1. In your root directory create an `index.js` file
2. Paste the following into it:

```
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
```

3. In the CLI run `yarn start`

4. You should see something like the following

![yarn start running](https://i.ibb.co/0Y89q8d/Screen-Shot-2022-08-01-at-3-32-35-PM.png)

Congrats!  React Native is ready to go, we just need to integrate it into Swift.


## Swift Integration <a name="swift"></a>

There are a few different ways to handle integration.  The one we're going to demonstrate right here is into an existing View.  We're going to take the `ContentView.swift` that was generated (very generic) and modify it to show what we just did in JS in the previous step.  You can follow along with the modifications to your own Swift view.

1. Taking the existing ContentView.swift:

```
  import SwiftUI

  struct ContentView: View {
      var body: some View {
          Text("Hello, world!")
              .padding()
      }
  }

  struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
          ContentView()
      }
  }
```

import UIKit and React


```
  import UIKit
  import React
```

2. Create RctView (you can name this whatever you like):

```
  struct RctView: UIViewRepresentable {
  }
```

3. Populate the makeUIView and updateUIView:

```
    func makeUIView(context: Context) -> RCTRootView {
        RCTRootView(bundleURL: URL(string: "http://localhost:8081/index.bundle?platform=ios")!, moduleName: "HelloTest", initialProperties: nil, launchOptions: nil)
    }
    
    func updateUIView(_ view: RCTRootView, context: Context) {
        
    }
```

This will load `RCTRootView` to have the contents that are generated from the JS server we started with `yarn start` above.  

4. Add it to ContentView:

```
  struct ContentView: View {
      var body: some View {
          Text("Hey there, I am from Swift")
          RctView()
      }
      
  }
```

The final file looks like:

```
  import SwiftUI
  import UIKit
  import React

  struct RctView: UIViewRepresentable {
      func makeUIView(context: Context) -> RCTRootView {
          RCTRootView(bundleURL: URL(string: "http://localhost:8081/index.bundle?platform=ios")!, moduleName: "HelloTest", initialProperties: nil, launchOptions: nil)
      }
      
      func updateUIView(_ view: RCTRootView, context: Context) {
          
      }
  }

  struct ContentView: View {
      var body: some View {
          Text("Hey there, I am from Swift")
          RctView()
      }
      
  }
```

One thing to pay special attention to here is the `moduleName`.  In this case, it is `HelloTest`, which is what we named it in `AppRegistry` in the previous step.  These need to line up in order for it to work.

Now if you run your project you should see something like:

![Swift and React Native](https://i.ibb.co/MDCbNyM/Screen-Shot-2022-08-01-at-3-52-57-PM.png)


## Add Build Phase for Bundling JS <a name = "buildphase" />

So far we've configured our React Native integration for debug mode only.  When we ship to the AppStore we need it to bundle the JS and include it in the IPA.
To do so go into your project and click on it, then go to Build Phases:

![Build Phases](https://i.ibb.co/fv6Gnrh/Screen-Shot-2022-08-02-at-9-05-02-AM.png)



Then click + and add `New Run Script Phase`

![New Run Script Phase](https://i.ibb.co/MBXD2K4/Screen-Shot-2022-08-02-at-9-06-19-AM.png)


Name it `Bundle React Native code and images`


Drag it so it is right before `[CP] Embed Pods Frameworks`

![Drag Up](https://i.ibb.co/MR4r29G/Screen-Shot-2022-08-02-at-9-09-40-AM.png)

Paste the following code in:

```
  set -e

  WITH_ENVIRONMENT="./node_modules/react-native/scripts/xcode/with-environment.sh"
  REACT_NATIVE_XCODE="./node_modules/react-native/scripts/react-native-xcode.sh"

  /bin/sh -c "$WITH_ENVIRONMENT $REACT_NATIVE_XCODE"
```


Under `Input Files` add:

`$(SRCROOT)/.xcode.env.local`

and

`$(SRCROOT)/.xcode.env`

You'll end up with something like:

![Results](https://i.ibb.co/5xxCPxx/Screen-Shot-2022-08-02-at-10-50-41-AM.png)



## Update URL for JS source <a name="jsurl" />

The final step in ensuring your app will run in both `Develop` and `Release`mode through changing the `URL` the JS is loaded from.

To do this, modify your `ContentView.swift` like so:

```
  import SwiftUI
  import UIKit
  import React

  struct RctView: UIViewRepresentable {
      func makeUIView(context: Context) -> RCTRootView {
          var sourceUrl: URL;
          
          #if DEBUG
              sourceUrl = URL(string:"http://localhost:8081/index.bundle?platform=ios")!
          #else
              sourceUrl = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!;
          #endif
          
          return RCTRootView(bundleURL: sourceUrl, moduleName: "HelloTest", initialProperties: nil, launchOptions: nil)
      }
      
      func updateUIView(_ view: RCTRootView, context: Context) {
          
      }
  }
```

Now your app will know where to load the JS from depending on if it's in `Debug` (localhost) or `Release` (app bundle)!