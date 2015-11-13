(function() {
  $(document).on('page:change', function() {
    return $('body').on('click', '.select-subject', function() {
      if ($(this).prop('checked')) {
        return $(this).parents('.row').find('input[type="text"]').attr('required', 'true');
      } else {
        return $(this).parents('.row').find('input[type="text"]').attr('required', 'false');
      }
    });
  });

}).call(this);
