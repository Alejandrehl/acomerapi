// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .

// Create a toast
function pedirCuenta(table_id) {
    VanillaToasts.create({
        title: `La mesa ${table_id} ha pedido la cuenta`,
        text: "",
        type: "success"
    });
}

function pedirMas(table_id) {
    VanillaToasts.create({
        title: `La mesa ${table_id} desea pedir mas`,
        text: "",
        type: "info"
    });
}

function problemaMesa(table_id) {
    VanillaToasts.create({
        title: `Se ha presentado un problema en la mesa ${table_id}`,
        text: "",
        type: "error"
    });
}

function problemaGeneral(table_id) {
    VanillaToasts.create({
        title: `Se solicita presencia en la mesa ${table_id}`,
        text: "",
        type: "error"
    });
}

function problemaAdmin(table_id) {
    VanillaToasts.create({
        title: `Se ha solicitado la presencia del administrador en la mesa ${table_id}`,
        text: "",
        type: "error"
    });
}

function ErrorAlCrear() {
    window.alert(`Error ingresando/creando nuevo usuario.`);
}

function initMap() {
    // En este objeto cargamos todas las opciones para nuestro mapa
    var center = {
        lat: -33.447487,
        lng: -70.673676
    };
    var options = {
        center: center,
        zoom: 13
    };

    if (document.getElementById("map")) {
        // map = new google.maps.Map(document.getElementById('map'), {
        //   center: {lat: -34.397, lng: 150.644},
        //   zoom: 8
        // })
    }

    initAutocomplete();
} // Fin Init Map

//InitAutoComplete
function initAutocomplete() {
    var map = new google.maps.Map(document.getElementById("map"), {
        center: {
            lat: -33.447487,
            lng: -70.673676
        },
        mapTypeControl: false,
        zoom: 13,
        mapTypeId: "roadmap"
    });

    // google.maps.event.addListener(map, 'click', function(event) {
    //     // alert("Latitude: " + event.latLng.lat() + " " + ", longitude: " + event.latLng.lng());
    //     document.getElementById('displayLat').value = event.latLng.lat();
    //     document.getElementById('displayLong').value = event.latLng.lng();
    // });

    // Create the search box and link it to the UI element.
    var input = document.getElementById("pac-input");
    var searchBox = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
    // alert("Latitude: " + input.latLng.lat() + " " + ", longitude: " + input.latLng.lng());

    // Bias the SearchBox results towards current map's viewport.
    map.addListener("bounds_changed", function() {
        searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    document.getElementById("displayLong").value = markers.latLng;
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener("places_changed", function() {
        var places = searchBox.getPlaces();
        if (places.length == 0) {
            return;
        }

        // Clear out the old markers.
        markers.forEach(function(marker) {
            marker.setMap(null);
        });
        markers = [];

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function(place) {
            if (!place.geometry) {
                console.log("Returned place contains no geometry");
                return;
            }
            var icon = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };

            document.getElementById(
                "displayLat"
            ).value = place.geometry.location.lat();
            document.getElementById(
                "displayLong"
            ).value = place.geometry.location.lng();
            // Create a marker for each place.
            markers.push(
                new google.maps.Marker({
                    map: map,
                    icon: icon,
                    title: place.name,
                    position: place.geometry.location
                })
            );

            if (place.geometry.viewport) {
                // Only geocodes have viewport.
                bounds.union(place.geometry.viewport);
            } else {
                bounds.extend(place.geometry.location);
            }
        });
        map.fitBounds(bounds);
        // document.getElementById('displayLong').value = marker.getPosition();
        // alert("Latitude: " + places.latLng.lat() + " " + ", longitude: " + places.latLng.lng());
    });
}
//Fin InitAutoComplete

$(function() {
    $("#toggle-one").bootstrapToggle({
        on: "Activado",
        off: "Desactivado",
        onstyle: "warning",
        offstyle: "secondary",
        width: 200
    });
});

$(function() {
    $("#toggle-two").bootstrapToggle({
        on: "En oferta",
        off: "Precio Normal",
        onstyle: "warning",
        offstyle: "secondary",
        width: 200
    });
});

// Get the button, and when the user clicks on it, execute myFunction
if (document.getElementById("checkMesas")) {
    document.getElementById("checkMesas").onclick = function() {
        showNumeroDeMesas();
    };
}

/* myFunction toggles between adding and removing the show class, which is used to hide and show the dropdown content */
function showNumeroDeMesas() {
    document.getElementById("numeroDeMesas").classList.toggle("show");
}

// Get the button, and when the user clicks on it, execute myFunction
if (document.getElementById("next-step")) {
    document.getElementById("next-step").onclick = function() {
        showNextStep();
    };
}

/* myFunction toggles between adding and removing the show class, which is used to hide and show the dropdown content */
function showNextStep() {
    document.getElementById("firstStep").classList.toggle("show");
    document.getElementById("secondStep").classList.toggle("show");
}

function sumar() {
    var total = 0;
    $("#txt_campo_1").each(function() {
        if (isNaN(parseInt($(this).val()))) {
            total += 0;
        } else {
            total += parseInt($(this).val()) * 1000; //QRs
        }
    });
    $("#txt_campo_2").each(function() {
        if (isNaN(parseInt($(this).val()))) {
            total += 0;
        } else {
            total += parseInt($(this).val()) * 2000; //Soporte Menu
        }
    });
    $("#txt_campo_3").each(function() {
        if (isNaN(parseInt($(this).val()))) {
            total += 0;
        } else {
            total += parseInt($(this).val()) * 19000; //Tablets
        }
    });

    //alert(total);
    if (document.getElementById("total")) {
        document.getElementById("total").innerHTML = total;
    }
}

function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

function handleChangueStatusReload() {
    location.reload();
}
// Tab de landing
function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
if (document.getElementById("defaultOpen")) {
    document.getElementById("defaultOpen").click();
}

function openCity02(evt, cityName) {
    var i, tabcontent02, tablinks02;
    tabcontent02 = document.getElementsByClassName("tabcontent02");
    for (i = 0; i < tabcontent02.length; i++) {
        tabcontent02[i].style.display = "none";
    }
    tablinks02 = document.getElementsByClassName("tablinks02");
    for (i = 0; i < tablinks02.length; i++) {
        tablinks02[i].className = tablinks02[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
if (document.getElementById("defaultOpen02")) {
    document.getElementById("defaultOpen02").click();
}

function validateFiles(inputFile) {
    var maxExceededMessage = "Esta imagen excede el limite de peso (1 MB)";
    var extraExceededMessage = "Para poder reducir el tamaño de la imagen ve al siguiente link: https://tinypng.com/";
    var extErrorMessage = "Solo imagenes con extension: .jpg, .jpeg, .gif or .png son permitidas";
    var allowedExtension = ["jpg", "jpeg", "gif", "png"];

    var extName;
    var maxFileSize = $(inputFile).data('max-file-size');
    var sizeExceeded = false;
    var extError = false;

    $.each(inputFile.files, function() {
        if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) { sizeExceeded = true; };
        extName = this.name.split('.').pop();
        if ($.inArray(extName, allowedExtension) == -1) { extError = true; };
    });
    if (sizeExceeded) {
        window.alert(maxExceededMessage);
        window.alert(extraExceededMessage);
        window.open('https://tinypng.com/', '_blank');
        $(inputFile).val('');
    };

    if (extError) {
        window.alert(extErrorMessage);
        $(inputFile).val('');
    };
}