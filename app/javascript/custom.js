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

    const current_book_url = document.URL;
    const ORIGIN_PATH = window.location.origin;
    $('#ajax_filter').change(function (){
      var id = parseInt($('.shot__byselect').val());
      let url_change_category =  ORIGIN_PATH + '/publishers/' + id + '/books';
      $.ajax({
        method: 'GET',
        dataType: 'script',
        url: url_change_category,
        data: {
          id: id
        }
      });
    });

    $('#rating_point').change(function() {
      var point = parseInt($(this).val());
      var book_id = parseInt($('.bookValue').val());
      let url_post =  current_book_url + '/ratings';
      $.ajax({
        method: 'POST',
        dataType: 'script',
        url: url_post,
        data: {
          rating: {point: point, book_id: book_id}
        }
      });
    });

    $('.btn-add-to-cart2').unbind().click(function (){
      var book_id = parseInt($(this).data('id'));
      let url_borrow_items =  ORIGIN_PATH + '/borrow_items';
      $.ajax({
        method: 'POST',
        dataType: 'script',
        url: url_borrow_items,
        data: {
          borrow_item: {
            book_id: book_id
          }
        }
      });
    });

    $('.code_value').change(function(){
      var value = $(this).val();
      $.ajax({
        method: 'GET',
        dataType: 'script',
        url: current_book_url,
        data: {
          q: {borrow_code_eq: value}
        }
      });
    });
  });
})
