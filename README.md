[![Build Status](https://travis-ci.com/bamnenim/flutter_google_places_api.svg?branch=master)](https://travis-ci.com/bamnenim/flutter_google_places_api)

# google_places_api

An implementation of [google place api](https://developers.google.com/places/web-service/intro)

# Getting started
## API key
To get api key, follow instruction [here](https://developers.google.com/places/web-service/intro)

## Places api types
 types | description 
 ------|------------
 Find Place | takes a text input and returns a place.
 Nearby Search | lets you search for places within a specified area.
 Text Search |  returns information about a set of places based on a string — for example "pizza in New York" or "shoe stores near Ottawa" or "123 Main Street". 
 Place Details | Return detailed information about a specific place, including user reviews.
 Place Photos | gives you access to the millions of Place related photos stored in Google's Place database.
 Place Autocomplete | can be used to automatically fill in the name and/or address of a place as you type.
 Query Autocomplete | can be used to provide a query prediction service for text-based geographic searches, by returning suggested queries as you type.

## Usage
all places requests returns Future<PlaceResponse> that means you need to use [await/async](https://dart.dev/codelabs/async-await).
 
Each request.call() will returns corresponding response!
 
#### Find Place
Find Place requires 'key', 'input' and 'inputtype' as default parameter.

'inputtype' must be either __textquery__ or __phonenumber__.

for more parameters, check out [here](https://developers.google.com/places/web-service/search#FindPlaceRequests)

```dart
//request returns corresponding response
FindPlaceResponse response = await FindPlaceRequest(
 key: 'YOUR_API_KEY_HERE',
 input: 'YOUT_INPUT_HERE',
 inputType: 'Either textquery or phonenumber'
).call();

print(response.toString());//will print response as json format
``` 

#### Nearby Search
Nearby Search requires 'key', 'location' and 'radius' as default parameter.

For more parameters, check out [here](https://developers.google.com/places/web-service/search#PlaceSearchRequests)

```dart
//request returns corresponding response
NearbySearchResponse response = await NeaerbySearchRequest(
 key: 'YOUR_API_KEY_HERE',
 location: 'YOUT_LOCATION',
 radius: 'DISTANCE IN METERS'
).call();

print(response.toString());//will print response as json format
```

#### Text Search
Text Search requires 'key' and 'query' as default parameter.

For more parameters, check out [here](https://developers.google.com/places/web-service/search#TextSearchRequests)

```dart
//request returns corresponding response
TextSearechResponse response = await TextSearchRequest(
 key: 'YOUR_API_KEY_HERE',
 query: 'YOUR_QUERY',
).call();

print(response.toString());//will print response as json format
```
 
 
#### Place Details
Details requires 'key' and 'place_id' as default parameter.

For more parameters, check out [here](https://developers.google.com/places/web-service/details#PlaceDetailsRequests)

```dart
//request returns corresponding response
PlaceDetailsResponse response = await PlaceDetailsRequest(
 key: 'YOUR_API_KEY_HERE',
 placeId: 'PLACE_ID'
).call();

print(response.toString());//will print response as json format
``` 

#### Place Photo
place photo directly returns image of request. So if you want to use image in flutter with this package, there are two ways:
1) use url with Image.network
2) use bytes result with Image.memory

here is example of 1)
```dart
//this will extract url to get photo
String photoUrl = PlacePhotoRequest(
 key: 'YOUR_API_KEY_HERE',
 photoRefernce: 'PHOTO_REFERENCE_HERE'
 maxHeight: 400, //this value should be in 1~1600, default is 1600
 maxWidth: 400, //this value should be in 1~1600, default is 1600
).buildUrl();

/*---------In Widget-------------*/
Image.network(photoUrl);
```
and here is example of 2)
```dart
//this will return place photo response object
//PlacePhotoResponse only has one parameter : imageBytes
//use imageBytes in Image.memory!

PlacePhotoResponse reponse = await PlacePhotoRequest(
 key: 'YOUR_API_KEY_HERE',
 photoRefernce: 'PHOTO_REFERENCE_HERE'
 maxHeight: 400, //this value should be in 1~1600, default is 1600
 maxWidth: 400, //this value should be in 1~1600, default is 1600
).call();

/*---------In Widget-------------*/
Image.memory(response.imageByte);
```

#### Place Autocomplete
autocomplete requires 'input' and 'key' as default parameter

For more parameters, check out [here](https://developers.google.com/places/web-service/autocomplete)

```dart
//request returns corresponding response
PlaceAutocompleteResponse response = await PlaceAutocompleteRequest(
 key: 'YOUR_API_KEY_HERE',
 input: 'YOUR_INPUT'
).call();

print(response.toStirng());//will print response as json format
```

#### Query Autocomplete
query autocomplete requires 'input' and 'key' as default parameter.

For more parameters, check out [here](https://developers.google.com/places/web-service/query#query_autocomplete_results)

```dart
//request returns corresponding response
QueryAutocompleteResponse response = await QueryAutocompleteRequest(
 key: 'YOUR_API_KEY_HERE',
 input: 'YOUR_INPUT'
).call();

print(response.toStirng());//will print response as json format
```
