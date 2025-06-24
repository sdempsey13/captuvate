// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".flash-alert").forEach((alert) => {
    setTimeout(() => {
      alert.classList.remove("show");
      setTimeout(() => alert.remove(), 500);
    }, 3000);
  });
});
  