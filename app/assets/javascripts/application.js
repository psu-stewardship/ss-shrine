// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
// This code uses:
//
// * babel-polyfill (https://babeljs.io/docs/usage/polyfill/)
// * whatwg-fetch (https://github.github.io/fetch/)
// * uppy (https://uppy.io)

function fileUpload(fileInput) {
    var imagePreview = document.querySelector('.upload-preview')
    

    fileInput.style.display = 'none' // uppy will add its own file input
  
    var uppy = Uppy.Core({
        id: fileInput.id,
        autoProceed: true,
        allowMultipleUploads: false,
      })
      .use(Uppy.FileInput, {
        target: formGroup,
        pretty: false,
      })
      .use(Uppy.Informer, {
        target: fileInput.parentNode,
      })
      .use(Uppy.StatusBar, {
        target: imagePreview.parentNode,
        hideAfterFinish: false,
      })
    //   .use(Uppy.ThumbnailGenerator, {
    //     thumbnailWidth: 400,
    //   })
  
    uppy.use(Uppy.AwsS3, {
      companionUrl: '/', // will call Shrine's presign endpoint on `/s3/params`
    })
  
    uppy.on('upload-success', function (file, response) {
      document.querySelector('.upload-submit').style.visibility='visible';
      // construct uploaded file data in the format that Shrine expects
      var uploadedFileData = JSON.stringify({
        id: file.meta['key'].match(/^cache\/(.+)/)[1], // object key without prefix
        storage: 'cache',
        metadata: {
          size:      file.size,
          filename:  file.name,
          mime_type: file.type,
        }
      })
  
      // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
      var hiddenInput = fileInput.parentNode.querySelector('.upload-hidden')
      hiddenInput.value = uploadedFileData
    })
  
    uppy.on('thumbnail:generated', function (file, preview) {
      imagePreview.src = preview
    })
  
    return uppy
  }

  document.querySelector('.upload-submit').style.visibility='hidden';
  
  document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    fileUpload(fileInput)
  })
