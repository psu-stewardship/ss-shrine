import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.load()

    if (this.data.has("refreshInterval")) {
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
    fetch(this.data.get("url"))
      .then(response => response.text())
      .then(string => JSON.parse(string))
      .then(json => {
        this.element.innerHTML = `
          <p><strong>Promoted:</strong> ${json.promoted}</p>
          <p><strong>Derived:</strong> ${json.derived}</p>`

        if (json.completed) {
          this.stopRefreshing()

          this.element.innerHTML += `
            <p><strong>Great success!</strong></p>
            <p>
              <a href="${this.data.get('parentUrl')}">Click me to go back to the post</a> (this would be a countdown timer and automatic redirect)
            </p>`
        }
      })
  }
}
