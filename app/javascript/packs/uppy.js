import Uppy from '@uppy/core'
import AwsS3 from '@uppy/aws-s3'
import StatusBar from '@uppy/status-bar'
import FileInput from '@uppy/file-input'

function fileUpload(fileInput) {
    var imagePreview = document.querySelector('.upload-preview')
    

    fileInput.style.display = 'none' // uppy will add its own file input
  
    var uppy = Uppy({
        id: fileInput.id,
        autoProceed: true,
        allowMultipleUploads: false,
      })
      .use(FileInput, {
        target: fileInput.parentNode,
        pretty: false,
      })
      .use(StatusBar, {
        target: imagePreview.parentNode,
        hideAfterFinish: false,
        showProgressDetails: true,
      })
    //   .use(Uppy.ThumbnailGenerator, {
    //     thumbnailWidth: 400,
    //   })
  
    uppy.use(AwsS3, {
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
  
//     uppy.on('thumbnail:generated', function (file, preview) {
//       imagePreview.src = preview
//     })
  
    return uppy
  }

  document.querySelector('.upload-submit').style.visibility='hidden';
  
  document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    fileUpload(fileInput)
  })
