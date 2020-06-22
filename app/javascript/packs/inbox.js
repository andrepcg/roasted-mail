const EMAIL_REFRESH_TIMER = 5000;

$(document).on('turbolinks:load', function() {

  const refreshButton = $('#refresh');
  const lastRefresh = $('#last_refresh');

  function loadEmails() {
    $('.tooltip').tooltip('dispose');
    refreshButton.prop('disabled', true).text('Refreshing...');
    $.ajax({
      "type": "GET",
      "url": "/mailbox/emails",
      "dataType": "script",
    }).done(() => {
      refreshButton.prop('disabled', false).text('Refresh');
      lastRefresh.text(new Date().toLocaleString())
    });
  }

  window.addEventListener("turbolinks:load", loadEmails);

  refreshButton.click(loadEmails);

  setInterval(loadEmails, EMAIL_REFRESH_TIMER);
});
