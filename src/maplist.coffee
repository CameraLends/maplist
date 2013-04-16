class Maplist

  markers: {}

  constructor: (@element, @mapObject, @options) ->
    @plotMarkers()
    @childTagName = @element.children()[0].tagName

    if ! @options["center"]?
      @options["center"] = @element.children(":first").data("latlong")

    @mapObject.setCenter(
      new google.maps.LatLng(@options["center"][0], @options["center"][1])
    )

    @element.on "mouseenter mouseleave", "li", @mouseEventCallback


  mouseEventCallback: (event) =>
    $target  = @elementOrClosestNode(event)
    iconName = "hoverIcon"
    iconName = "icon" if event.type == "mouseleave"

    if @options[iconName]?
      @getMarkerAt($target.data "latlong").setIcon(@options[iconName])


  elementOrClosestNode: (event)->
    if event.target.tagName != @childTagName
      $(event.target).closest(@childTagName)
    else
      $(event.target)


  getMarkerAt: (latLong)->
    @markers["#{latLong[0]}"]["#{latLong[1]}"]


  addMarker: (marker, latLong)->
    @markers["#{latLong[0]}"] = {} if ! @markers["#{latLong[0]}"]?
    @markers["#{latLong[0]}"]["#{latLong[1]}"] = marker


  plotMarkers: ->
    for i in [0...@element.children().length]
      $child        = @element.children().eq(i)
      latLong       = $child.data("latlong")
      gLatLong      = new google.maps.LatLng(latLong[0], latLong[1])
      markerOptions = { position: gLatLong, map: @mapObject, listElementId: $child.attr("id") }

      markerOptions["icon"] = @options["icon"] if @options["icon"]?

      marker = new google.maps.Marker(markerOptions)
      @addMarker(marker, latLong)
      @registerCallbacksForMarker(marker)


  registerCallbacksForMarker: (marker)->
    google.maps.event.addListener(marker, 'mouseover',
      do (marker = marker, element = @element, options = @options)->
        ()->
          $("##{marker.listElementId}").addClass("selected")
          marker.setIcon(options["hoverIcon"]) if options["hoverIcon"]?
    )

    google.maps.event.addListener(marker, 'mouseout',
      do (marker = marker, element = @element, options = @options)->
        ()->
          $("##{marker.listElementId}").removeClass("selected")
          marker.setIcon(options["icon"]) if options["icon"]?
    )


$ ->
  $.fn.maplist = (mapObject, options) ->
    new Maplist(this, mapObject, options)
