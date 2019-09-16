import Uppy from '@uppy/core'
import AwsS3Multipart from '@uppy/aws-s3-multipart'
import StatusBar from '@uppy/status-bar'
import FileInput from '@uppy/file-input'
import Dashboard from '@uppy/dashboard'

function fileUpload(fileInput) {
    fileInput.style.display = 'none' // uppy will add its own file input

    var uppy = Uppy({
        id: fileInput.id,
        autoProceed: true,
        allowMultipleUploads: false,
      })
      .use(Dashboard, {
        id: 'Dashboard',
        target: 'body',
        inline: 'true'
      })

    uppy.use(AwsS3Multipart, {
      companionUrl: '/',
    })

    uppy.on('upload-success', function (file, response) {
      document.querySelector('.upload-submit').style.visibility='visible';
      // construct uploaded file data in the format that Shrine expects
      var uploadedFileData = JSON.stringify({
        id: response.uploadURL.match(/\/cache\/([^\?]+)/)[1],
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

    return uppy
  }

  document.querySelector('.upload-submit').style.visibility='hidden';

  document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    fileUpload(fileInput)
  })
