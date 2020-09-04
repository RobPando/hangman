import React from "react";
import ReactDOM from "react-dom";

import HangmanSocket from "./hangman_socket";
import Hangman from "./scenes/Hangman";

window.onload = function () {
  const hangman = new HangmanSocket();
  hangman.connect_to_hangman();

  ReactDOM.render(<Hangman />, document.getElementById("hangman"))
}
