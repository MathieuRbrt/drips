$('.vote')
  .on('ajax:send', function () { $(this).addClass('loading'); })
  .on('ajax:complete', function () { $(this).removeClass('loading'); })
  .on('ajax:error', function () { $(this).after('<div class="error">There was an issue.</div>'); })
  .on('ajax:success', function (data) { $(this).html(data.count); });