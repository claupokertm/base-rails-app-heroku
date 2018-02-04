window.onPageLoad = function (selector, cb) {
  $(document).on('turbolinks:load',  function () {
    var $el = $(selector);
    if($el.length < 1){
      return true;
    }
    cb($el);
  });
};