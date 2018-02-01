var TableWithLink = (function() {
  var $table;

  var init = function(table) {
    $table = $(table);

    bindEvents();
  };

  var bindEvents = function() {
    $table.on('click', 'tbody tr', function(event) {
      var url = $(this).data('url');

      window.location.href = url;

      event.preventDefault();
    });
  };

  return {
    init: init
  }
})();

$(document).on('turbolinks:load', function() {
  TableWithLink.init('table[data-table-with-link]');
});
