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
  })
})
