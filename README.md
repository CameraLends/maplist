# maplist.js

MapList is a jQuery plugin that makes it easy to create maps that are linked
to scrolling lists, a la the Yelp Search Results page. Clicking an entry
highlights the map marker, and also vice versa.

## Usage

Use markup structure like this (below is in HAML):

    %ul#gear-near-you
      %li{ data: { latlong: [37.7930944, -122.4169949] }, id: "unique-item-id" }
        %a.title{ href: '/items/3' } Canon 60D
        .location Nob Hill, Fidi
        %a.btn{ href: '/items/3' } Rent


and initialize it with:

    $('#gear-near-you').maplist(googleMapObject, options)

which will fill the map with the latlongs from the li's.

`googleMapObject` holds the map created using Google Maps API.

Valid `options` that can be passed are:

* `icon`: url or absolute path to the icon to use for the marker
* `hoverIcon`: url or absolute path to the icon to use for the marker when it's hovered upon
* `center`: a point at which the map should be centered to initially

Each child in the list must have a unique ID attribute.

## Development

You'll need to install dependencies

    bundle install

Compile the demo

    API_KEY=your_maps_api_key haml demo/index.haml demo/index.html

## Design Mockup
![Gear Near You](gear-near-you.jpg)
