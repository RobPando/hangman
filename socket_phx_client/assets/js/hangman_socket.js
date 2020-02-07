import { Socket } from "phoenix";

export default class HangmanSocket {
  constructor() {
    this.socket = new Socket("/socket", {});
    this.socket.connect();
  }

  connect_to_hangman() {
    this.setup_channel();
    this.channel.on("tally", tally => {
      console.dir(tally);
    })
  }

  setup_channel() {
    this.channel = this.socket.channel("hangman:game", {});
    this.channel
      .join()
      .receive("ok", response => {
        console.log("Connected! ", response);
        this.fetch_tally()
      })
      .receive("error", response => {
        alert(response);
        throw(response);
      })
  }

  fetch_tally() {
    this.channel.push("tally", {});
  }
}
