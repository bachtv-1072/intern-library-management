$(window).on('turbolinks:load', function() {
  $(document).ready(function(){
    $('#book').DataTable({
      'bInfo': false,
      'bPaginate': false
    });

    $('#category').DataTable({
      'bInfo': false,
      'bPaginate': false
    });

    $('#author').DataTable({
      'bInfo': false,
      'bPaginate': false
    });

    $('#publisher').DataTable({
      'bInfo': false,
      'bPaginate': false
    });

    const ORIGIN_PATH = window.location.origin;
    $('#ajaxSearchCate').change(function (){
      var id = parseInt($('.shot__byselect').val());
      let url_change_category =  ORIGIN_PATH + '/publishers/' + id;
      $.ajax({
        method: 'GET',
        url: url_change_category,
        data: {
          id: id
        },
        success: function(data){
          $('#div-change-category').empty().append(data);
        },
        error: function(XMLHttpRequest, errorTextStatus, error){
          alert('Failed: '+ errorTextStatus+' ;'+error);
        }
      });
    });
  });
})
