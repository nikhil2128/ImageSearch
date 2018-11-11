# ImageSearch
This project displays the list of images in scrollable view fetched from the flickr api.

## Architecture
The project is based upon MVVM architecture and is written in Swift 4.

* **M**odel - PhotosModel
* **V**iew - View in Main.storyboard
* **V**iew **M**odel - PhotosViewModel
* Controller - ViewController


## Folder Structure
* **Data Factory** - This is responsible for providing data either fetching remotely thorough the API or from the cache (local DB). 
* **Extension** - This contains swift extensions.
* **Constants** - This contains all the constants required in the app. 
* **Custom Views** - This contains the custom views created like custom buttons, views, labels, etc. 
* **Utils** - This contains the helper classes. 

## Configuration
If you want to change the API key used for fetching data through the flickr api, then edit it at Constants -> APIConstants.swift -> APIKey

## Unit Tests & Code Coverage
Since the project is based upon MVVM architecture, we can do maximum code coverage by writing unit tests for models, view models, extensions, utils.
