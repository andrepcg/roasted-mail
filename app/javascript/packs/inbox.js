const EMAIL_REFRESH_TIMER = 10000;


$(document).on('turbolinks:load', function() {
  if (getControllerName() === 'mailbox' && getActionName() === 'inbox') {
    function loadEmails() {
      const currentPage = $('#emails_list').data('page');
      $.ajax({
        "type": "GET",
        "url": "/mailbox/emails",
        "dataType": "script",
        "data": {
          "page": currentPage
        }
      }).done(() => {
        $('#last_refresh').text(new Date().toLocaleString())
      });
    }

    loadEmails();
    addTimer();

    $("#autoRefresh").prop('checked', true);

    $("#autoRefresh").change(function() {
      const isChecked = this.checked;
      if (isChecked) {
        addTimer();
      } else {
        clearInterval(refreshInterval);
      }
    });

    function clearTimers() {
      clearInterval(refreshInterval);
    }

    function addTimer() {
      refreshInterval = setInterval(loadEmails, EMAIL_REFRESH_TIMER);
    }

    window.addEventListener("turbolinks:before-cache", clearTimers)
    window.addEventListener("turbolinks:before-render", clearTimers)
  }
});
