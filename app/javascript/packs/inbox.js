const EMAIL_REFRESH_TIMER = 5000;

$(document).on('turbolinks:load', function() {

  const lastRefresh = $('#last_refresh');

  function loadEmails() {
    // $('.tooltip').tooltip('dispose');
    const currentPage = $('#emails_list').data('page');
    $.ajax({
      "type": "GET",
      "url": "/mailbox/emails",
      "dataType": "script",
      "data": {
        "page": currentPage
      }
    }).done(() => {
      lastRefresh.text(new Date().toLocaleString())
    });
  }

  window.addEventListener("turbolinks:load", loadEmails);

  let refreshInterval = setInterval(loadEmails, EMAIL_REFRESH_TIMER);
  $("#autoRefresh").prop('checked', true);

  $("#autoRefresh").change(function() {
    const isChecked = this.checked;
    if (isChecked) {
      refreshInterval = setInterval(loadEmails, EMAIL_REFRESH_TIMER);
    } else {
      clearInterval(refreshInterval);
    }
  });
});
