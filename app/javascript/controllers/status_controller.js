import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.load()

    if (this.data.has("refreshInterval")) {
      this.refreshCount = 0
      this.startRefreshing()
    }
  }

  disconnect() {
    this.stopRefreshing()
  }

  startRefreshing() {
    this.interval = setInterval(() => {
      this.load()
    }, this.data.get("refreshInterval"))
  }

  stopRefreshing() {
    if(this.interval) {
      clearInterval(this.interval)
    }
  }

  load() {
    fetch(this.data.get("url"), {
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
      .then(response => response.text())
      .then(text => {
        this.element.innerHTML = text
        this.element.innerHTML += `<p>JavaScript Refresh Count: ${++this.refreshCount}</p>`

        let completed = document
          .getElementById('status-inner')
          .getAttribute('data-completed') === 'true'

        if (completed) this.stopRefreshing()
      })
  }
}
