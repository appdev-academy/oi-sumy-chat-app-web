// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

Turbo.StreamActions.scroll_to = function () {
  this.targetElements[0].scrollIntoView({ behavior: "smooth" });
};
