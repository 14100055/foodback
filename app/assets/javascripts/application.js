// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .
$(document).ready(function(){
  $(".openDlg1").click(function() {
    $(".dialog1").dialog({
      buttons: [
        {
          text: "Close",
          click: function() {
            $( this ).dialog( "close" );
          }
        }
      ],
      height: 300,
      width: 325,
      title: "Update Budget",
      modal: true,
      draggable: false,
      resizable: false
    });
  })

  $(".openDlg2").click(function() {
    $(".dialog2").dialog({
      buttons: [
        {
          text: "Close",
          click: function() {
            $( this ).dialog( "close" );
          }
        }
      ],
      height: 300,
      width: 250,
      title: "Input Meal Cost",
      modal: true,
      draggable: false,
      resizable: false  
    });
  })
  
  $(".openDlg3").click(function() {
    $(".dialog3").dialog({
      buttons: [
        {
          text: "Close",
          click: function() {
            $( this ).dialog( "close" );
          }
        }
      ],
      height: $(window).height()*0.95,
      width: 500,
      title: "Select Favourites",
      modal: true,
      draggable: false,
      resizable: false  
    });
  })

});

