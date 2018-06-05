//= require dropzone


document.addEventListener 'turbolinks:load', ->
  $(".dropzone-field").each ->
    path = $(this).data('path')
    dropzone = $(this).dropzone(
      url: path,
      paramName: 'attachment[data]',
      addRemoveLinks: true,
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
      params: {
        authenticity_token: $('[name=authenticity_token]').val(),
        'attachment[attachmentable_type]': $('[name=attachmentable_type]').val(),
        'attachment[attachmentable_id]': $('[name=attachmentable_id]').val(),
        'attachment[user_id]': $('[name=user_id]').val()
      },
      previewsContainer: $(this).data('previews'),
      dictRemoveFileConfirmation: 'Are you sure?',
      success: (file, response) ->
        file.id = response.attachment.id
      removedfile: (file) ->
        console.log file
        if file.id
          $.ajax
            url: (path + '/' + file.id)
            type: 'DELETE'
            success: (response) ->
              console.log response

        $(file.previewElement).remove()

      init: ->
        dz = this
        $(".dropzone-files-uploaded").each ->
          fl = $(this)
          mock = { 
            id: fl.data('id'),
            accepted: true,
            url: fl.data('url'),
            name: fl.data('name'),
            size: fl.data('size')
          }

          dz.files.push(mock)
          dz.emit('addedfile', mock)
          if(mock.url.match(/\.(jpg|jpeg|gif|png)/))
            dz.emit("thumbnail", mock, mock.url)
          
          # dz.createThumbnailFromUrl(mock, mock.url)
          dz.emit('complete', mock)

    );

  $(".dropzone-video-field").each ->
    _this = $(this)
    path = $(this).data('path')
    dropzone = _this.dropzone(
      url: 'https://api.sproutvideo.com/v1/videos',
      paramName: 'source_video',
      addRemoveLinks: true,
      headers : {
        'Cache-Control': null,
        'X-Requested-With': null
      },
      previewsContainer: _this.data('previews'),
      dictRemoveFileConfirmation: 'Are you sure?',
      removedfile: (file) ->

        if file.id
          $.ajax
            url: (path + '/' + file.id)
            type: 'DELETE'
            success: (response) ->
              console.log response

        $(file.previewElement).remove()

      processing: (file) ->
        dz = this
        dz.options.params = { 
          token: _this.prop('data-token'),
          description: 'id-'+_this.prop('data-id')
        }

      success: (file, response) ->
        dz = this
        console.log(file, response)
        id = response.description.replace(/id-/, '')
        file.id = id

        $.ajax
          url: _this.data('update-url') + '/' + id,
          type: 'PUT'
          data: {
            video: {
              sproutvideo_id: response.id,
              embed_code: response.embed_code,
              status: 'ready',
              length: response.duration,
              size: file.size,
              title: file.name,
              thumbnail_url: response.assets.thumbnails[0]
            }
          },
          success: (response) ->
            console.log response


        # mock = { 
        #   id: id,
        #   accepted: true,
        #   url: response.assets.thumbnails[0],
        #   name: file.name,
        #   size: file.size
        # }

        # addThumb(dz, mock)

      init: ->
        dz = this

        $(".dropzone-video-files-uploaded").each ->
          fl = $(this)
          mock = { 
            id: fl.data('id'),
            accepted: true,
            url: fl.data('url'),
            name: fl.data('name'),
            size: fl.data('size')
          }

          addThumb(dz, mock)

    );

    # $(".dropzone-files-uploaded").each ->
    #   console.log($(this).data('name'))
    #   mockFile = { name: $(this).data('name'), size: $(this).data('size') };
    #   dropzone.options.addedfile.call(dropzone, mockFile);
    #   dropzone.options.thumbnail.call(dropzone, mockFile, $(this).data('url'));

addThumb = (dz, mock) ->
  dz.files.push(mock)
  dz.emit('addedfile', mock)
  if(mock.url && mock.url.match(/\.(jpg|jpeg|gif|png)/))
    dz.emit("thumbnail", mock, mock.url)

  dz.emit('complete', mock)

window.addUserToOrganization = (link) ->
  $.post $(link).data('url'),
    user_id: $('#organization-user').val()

window.addOrganizationToUser = (link) ->
  $.post $(link).data('url').replace(/0/, $('#organization-user').val())


window.addOrganizationToAddon = (link) ->
  $.post $(link).data('url'),
    organization_id: $('#organization-addon').val()

window.addCourseToAddon = (link) ->
  $.post $(link).data('url'),
    course_id: $('#addon-course').val()

window.addAddonToCourse = (link) ->
  $.post $(link).data('url').replace(/0/, $('#course-addon').val())

window.addAddonToOrganization = (link) ->
  $.post $(link).data('url').replace(/0/, $('#organization-addon').val())

window.getVideoToken = (url) ->
  $.get url, (data) ->
    $(".dropzone-video-field").prop('data-token', data.token)
    $(".dropzone-video-field").prop('data-id', data.id)
