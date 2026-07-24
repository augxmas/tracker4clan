/* session-guard.js — 세션 만료(401/440) 전역 처리
 *  세션 종료 후 버튼 클릭 등으로 API 가 401(not_logged_in / *_login_required) /
 *  440(session_expired) 을 반환하면 → "다시 로그인" 안내 후 로그인 화면으로 전환.
 *  admin / merchant / supervisor 공용.
 */
(function () {
  "use strict";
  if (window.__sessionGuard) return;
  window.__sessionGuard = true;

  var _fetch = window.fetch.bind(window);
  var handling = false;
  var MSG = "세션이 종료되었습니다.\n다시 로그인해 주세요.";

  function dashVisible() {
    var d = document.getElementById("sec-dashboard") || document.getElementById("dashboard");
    if (!d) return false;
    if (d.id === "sec-dashboard") {
      return d.classList.contains("active");
    }
    return d.style.display !== "none" && d.offsetParent !== null;
  }

  function toLogin() {
    try { if (typeof stopSessionWatch === "function") stopSessionWatch(); } catch (e) {}
    try { if (typeof stopScanner === "function") stopScanner(); } catch (e) {}
    // 앱별 로그인 전환 함수 우선
    if (typeof showLogin === "function") { try { showLogin(); return; } catch (e) {} }
    if (typeof show === "function" && document.getElementById("sec-login")) { try { show("sec-login"); return; } catch (e) {} }
    // 폴백 — DOM 직접 토글
    var login = document.getElementById("sec-login") || document.getElementById("login-wrap");
    var dash = document.getElementById("sec-dashboard") || document.getElementById("dashboard");
    if (login) { login.classList.add("active"); login.style.display = ""; }
    if (dash) { dash.classList.remove("active"); dash.style.display = "none"; }
  }

  function notify() {
    if (typeof uiAlert === "function") { try { uiAlert(MSG, { title: "로그인 필요" }); return; } catch (e) {} }
    try { alert(MSG.replace("\n", " ")); } catch (e) {}
  }

  var customFetch = function (input, init) {
    init = init || {};
    init.headers = init.headers || {};

    // 로컬 스토리지에서 세션 ID 가져와서 헤더에 주입 (크로스사이트 iframe 세션 차단 대안)
    var savedSessionId = null;
    try {
      savedSessionId = localStorage.getItem("tracker_session_id");
    } catch (e) {}

    if (savedSessionId) {
      if (typeof Headers !== "undefined" && init.headers instanceof Headers) {
        if (!init.headers.has("X-Session-ID")) {
          init.headers.set("X-Session-ID", savedSessionId);
        }
      } else if (Array.isArray(init.headers)) {
        var hasHeader = false;
        for (var i = 0; i < init.headers.length; i++) {
          if (init.headers[i][0] && init.headers[i][0].toLowerCase() === "x-session-id") {
            hasHeader = true;
            break;
          }
        }
        if (!hasHeader) {
          init.headers.push(["X-Session-ID", savedSessionId]);
        }
      } else {
        var keys = Object.keys(init.headers);
        var hasHeader = false;
        for (var i = 0; i < keys.length; i++) {
          if (keys[i].toLowerCase() === "x-session-id") {
            hasHeader = true;
            break;
          }
        }
        if (!hasHeader) {
          init.headers["X-Session-ID"] = savedSessionId;
        }
      }
    }

    return _fetch(input, init).then(function (res) {
      var url = (typeof input === "string") ? input : (input && input.url) || "";
      var isLogin = url.indexOf("/login") >= 0;

      // 성공한 로그인 응답에서 세션 ID를 비동기식 대기 완료 후 최종 전달
      if (res.ok && isLogin) {
        return res.clone().json().then(function (d) {
          if (d && d.ok && d.sessionId) {
            try {
              localStorage.setItem("tracker_session_id", d.sessionId);
            } catch (e) {}
          }
          return res;
        }).catch(function () {
          return res;
        });
      }

      try {
        // 로그아웃 시 세션 ID 삭제
        if (url.indexOf("/logout") >= 0) {
          try {
            localStorage.removeItem("tracker_session_id");
          } catch (e) {}
        }

        // 로그인/세션 폴링·연장 엔드포인트는 제외 (로그인 실패 401·안내 중복 방지)
        var skip = url.indexOf("/api/session-info") >= 0
          || url.indexOf("/api/session-extend") >= 0
          || isLogin;
        // 로그인 상태(대시보드 표시 중)에서 발생한 경우에만 안내 — 로그인 화면 배경 401 은 무시
        if ((res.status === 401 || res.status === 440) && !skip && !handling && dashVisible()) {
          handling = true;
          toLogin();
          notify();
          setTimeout(function () { handling = false; }, 1500);
        }
      } catch (e) {}
      return res;
    });
  };

  try {
    Object.defineProperty(window, 'fetch', {
      value: customFetch,
      writable: true,
      configurable: true,
      enumerable: true
    });
  } catch (err) {
    try {
      window.fetch = customFetch;
    } catch (e) {
      console.warn("[session-guard] Unable to override window.fetch directly, using fallback wrapper", e);
    }
  }
})();
