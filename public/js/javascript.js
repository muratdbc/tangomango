



var map;
var myCenter=new google.maps.LatLng(37.7833, -122.4167 );
var marker=new google.maps.Marker({
  position:myCenter,
  animation: google.maps.Animation.DROP
});


function initialize() {
  var mapProp = {
    center:myCenter,
    zoom: 14,
    draggable: true,
    scrollwheel: true,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };

  map=new google.maps.Map(document.getElementById("map-canvas"),mapProp);
  marker.setMap(map);

  google.maps.event.addListener(marker, 'click', function() {

    infowindow.setContent(contentString);
    infowindow.open(map, marker);

  });
};
google.maps.event.addDomListener(window, 'load', initialize);

google.maps.event.addDomListener(window, "resize", resizingMap());

$('#myMapModal').on('show.bs.modal', function() {
 resizeMap();
})

function resizeMap() {
 if(typeof map =="undefined") return;
 setTimeout( function(){resizingMap();} , 400);
}

function resizingMap() {
 if(typeof map =="undefined") return;
 var center = map.getCenter();
 google.maps.event.trigger(map, "resize");
 map.setCenter(center);
}

$("#show-events").on("click",function(event){
  event.preventDefault();
  console.log("clicked");
  form_data=$(this).parent().serialize();
  url=$(this).parent().attr("action");
  $.ajax({
    url: url,
    type: "post",
    data: form_data
  }).done(function(server_data){
    console.log(server_data);
    drawMarkersOnMap(server_data);
  }).fail(function(){
    alert("Wrong work harder");
  })
})









function drawMarkersOnMap(data){

  for (var i=0;i<data.length;i=i+2){
    console.log(data[i],data[i+1]);
    var myLatlng = new google.maps.LatLng(data[i],data[i+1]);

    var marker = new google.maps.Marker({
     position: myLatlng,
     animation: google.maps.Animation.DROP
    });

    marker.setMap(map);
  }
}


$(".events").on("click",".checkbox",function(){
  $("."+this.id.slice(0)).toggle();
});

var tagEventWithClass=function(all_event_data){
  console.log(all_event_data);
  for (var key in all_event_data){
    $($(".first_row")[key]).addClass(all_event_data[key].join().replace(","," "));
  }
}

$(document).ready(function(){
  var overlay = '<div class="overlay">' +
            '<img class="loading" src="http://bit.ly/1uqnDC5">' +
            '</div>';
  $(overlay).appendTo('body');
  $.ajax({type:"post",url:"/area-cat"}).done(function(all_event_data){
      $(".overlay").fadeOut("slow",function(){
        this.remove();
        tagEventWithClass(all_event_data)
      });
  })
})





