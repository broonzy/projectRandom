$(document).ready(function() {
  //below line from stackoverflow - Marcin
    $("#row").bind('DOMSubtreeModified', function() {
        if ($('.entry')[55]){
            $('#phrase_text').fadeIn(500);
            //$('#emptyrow').click;
            $('#row').hide(500);
            // on refresh remove the last 7 .entry
            // although this is not emptying the line items!
           // $('#row').empty();
            $('#row').remove();
        }
    });
});

