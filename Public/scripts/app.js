$(function() {
  $('.sidebar-nav .category-toggle').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);
    $this.parent().find('.sub-category').toggle();
  })
});
