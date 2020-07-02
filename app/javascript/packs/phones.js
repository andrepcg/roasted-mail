
// $(document).on('turbolinks:load', function() {
//   if (getControllerName() === 'phone_numbers' && getActionName() === 'show') {
//     let interval;

//     function clearTimers() {
//       clearInterval(interval);
//     }

//     if (!interval) {
//       interval = setInterval(reloadWithTurbolinks, 10000);
//       window.addEventListener("turbolinks:before-cache", clearTimers)
//       window.addEventListener("turbolinks:before-render", clearTimers)
//     }
//   }
// });