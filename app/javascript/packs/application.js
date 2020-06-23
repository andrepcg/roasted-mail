// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery';
import 'bootstrap/js/dist/tooltip';
import 'bootstrap/js/dist/modal';
import toastr from 'toastr';
// import 'toastr/build/toastr.css';

window.toastr = toastr;

$(document).on('turbolinks:load', function() {
  $('.copy').click(function() {
    var copyText = $(this.parentElement.parentElement).find("input").get(0);
    copyText.select();
    copyText.setSelectionRange(0, 99999); /*For mobile devices*/
    document.execCommand("copy");
  });
  $('body').tooltip({
    selector: '[data-toggle="tooltip"]',
    container: 'body',
    trigger: 'hover'
  });
  window.$ = $;

  if (typeof window.fathom === 'function') {
    window.fathom('trackPageview');
  }
});

