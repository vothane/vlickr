
source = new EventSource('/comments/events')
source.addEventListener 'comments.create', (e) ->
  comment = $.parseJSON(e.data).comment
  $('#feed').append($('<li>').text("#{comment.content}"))