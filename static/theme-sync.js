// williamjwhite-docs/static/theme-sync.js
(function () {
  var COOKIE_NAME = "wjjw_theme";

  function getCookie(name) {
    var match = document.cookie.match(
      new RegExp("(?:^|; )" + name + "=([^;]*)")
    );
    return match ? decodeURIComponent(match[1]) : null;
  }

  function setDocusaurusTheme(mode) {
    // Docusaurus reads these localStorage keys depending on version/config.
    // Keeping both is harmless and improves compatibility.
    try {
      localStorage.setItem("theme", mode);
      localStorage.setItem("docusaurus-theme", mode);
      localStorage.setItem("docusaurus.colorMode", mode);
      localStorage.setItem("docusaurus.theme", mode);
    } catch (e) {}

    // Apply immediately
    document.documentElement.setAttribute("data-theme", mode);
  }

  var cookie = getCookie(COOKIE_NAME);
  if (cookie === "dark" || cookie === "light") {
    setDocusaurusTheme(cookie);
  }
})();
