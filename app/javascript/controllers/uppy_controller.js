import { Controller } from "stimulus"
import Uppy from '@uppy/core'
import AwsS3Multipart from '@uppy/aws-s3-multipart'
import StatusBar from '@uppy/status-bar'
import FileInput from '@uppy/file-input'
import Dashboard from '@uppy/dashboard'

export default class extends Controller {

  connect() {
    document.querySelector('.upload-submit').style.visibility='hidden'
    this.initialize_uppy()
  }

  initialize_uppy() {
    var uppy = Uppy({
      id: 'someid',
      autoProceed: true,
      allowMultipleUploads: true,
    })
    .use(Dashboard, {
      id: 'dashboard',
      target: this.element,
      inline: 'true',
      showProgressDetails: true
    })
    .use(AwsS3Multipart, {
      companionUrl: '/',
    })

    var hiddenFileInput = function(success) {
      var uploadedFileData = JSON.stringify({
        id: success.uploadURL.match(/\/cache\/([^\?]+)/)[1],
        storage: 'cache',
        metadata: {
          size:      success.data.size,
          filename:  success.data.name,
          mime_type: success.data.type,
        }
      })

      var input = document.createElement("input")
      input.setAttribute("type", "hidden")
      input.setAttribute("name", "album[posts_attributes][][file]")
      input.setAttribute("value", uploadedFileData)

      return input
    }

    uppy.on('complete', result => {
      document.querySelector('.upload-submit').style.visibility='visible'
      result.successful.forEach(function(success) {
        document.getElementsByTagName('form')[0].appendChild(hiddenFileInput(success))
      })
    })
  }
}
