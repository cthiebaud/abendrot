$(function() {
  
  $('.collapse').on('show', function (event) {
    var thisId = $(this).attr("id");
    // console.log(thisId);
    var theAssociatedButton =  $(".accordion-toggle[href=#"+thisId+"] i");
    // console.log(theAssociatedButton);
    theAssociatedButton.removeClass("icon-chevron-right").addClass("icon-chevron-left");
  });

  $('.collapse').on('hide', function (event) {
    var thisId = $(this).attr("id");
    // console.log(thisId);
    var theAssociatedButton =  $(".accordion-toggle[href=#"+thisId+"] i");
    // console.log(theAssociatedButton);
    theAssociatedButton.removeClass("icon-chevron-left").addClass("icon-chevron-right");
  });

});