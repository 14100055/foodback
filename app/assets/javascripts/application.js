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
  
  addDlg(".openDlg1", ".dialog1", "Update Budget", 300, 325);
  addDlg(".openDlg2", ".dialog2", "Input Meal Cost", 300, 250);
  addDlg(".openDlg3", ".dialog3", "Select Favourites", $(window).height()*0.95, 500);
  addDlg(".openDlg4", ".dialog4", "New Day", 400, 500);

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
