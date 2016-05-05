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
//= require owl.carousel
//= require_tree .
//= require Chart

$(document).ready(function(){
  
  addDlg(".openDlg1", ".dialog1", "Update Budget", 500, 400);
  addDlg(".openDlg2", ".dialog2", "Input Meal Cost", 500, 400);
  addDlg(".openDlg3", ".dialog3", "Select Favourites", $(window).height()*0.95, 700);
  addDlg(".openDlg4", ".dialog4", "New Day", 400, 425);

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '600186960136254',
      xfbml      : true,
      version    : 'v2.6'
    });
  };
  $(".owl-carousel").owlCarousel({
    autoPlay: 3000,
    items: 1,
    autoWidth: true,
  });
  
  (function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  function addDlg(dom1, dom2, title1, height1, width1) {
    $(dom1).click(function() {
      $(dom2).dialog({
        buttons: [
          {
            text: "Close",
            click: function() {
              $( this ).dialog( "close" );
            }
          }
        ],
        height: height1,
        width: width1,
        title: title1,
        modal: true,
        draggable: false,
        resizable: false
      });
    });
  }

});

Chart.defaults.global.animationSteps = 100;
Chart.defaults.global.tooltipYPadding = 16;
Chart.defaults.global.tooltipCornerRadius = 0;
Chart.defaults.global.tooltipTitleFontStyle = "normal";
Chart.defaults.global.tooltipFillColor = "rgba(0,160,0,0.8)";
Chart.defaults.global.animationEasing = "easeOutBounce";
// Chart.defaults.global.responsive = true;
// Chart.defaults.global.scaleLineColor = "black";
// Chart.defaults.global.scaleFontSize = 12;

