import "@hotwired/turbo-rails";
import "./controllers";

Turbo.StreamActions.scroll_to = function () {
  this.targetElements[0].scrollIntoView({ behavior: "smooth" });
};
