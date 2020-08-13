# MapProject

## Installation
In order to install [Mapbox](https://docs.mapbox.com/ios/maps/overview/), you will need to obtain a secret key and store it in a `.netrc` file in your home directory. Depending on your environment, you may have this file already, so check first before creating a new one. Add the following entry to your `.netrc` file:
```
machine api.mapbox.com 
  login mapbox
  password <INSERT API TOKEN>
```
### Carthage
In order to build the project, you will need to install [Carthage](https://github.com/Carthage/Carthage) of version `0.35.0` or higher and load frameworks with `carthage update --platform iOS --use-netrc`
