/* ──────────────────────────────────────────────────────────────
 * grid-columns.js — 모든 그리드(표) 컬럼 조정
 *  · 각 표 우상단에 '⚙ 컬럼조정' 버튼 자동 삽입
 *  · 컬럼 표시/숨김(체크박스) + 드래그앤드랍 순서변경
 *  · 설정은 로그인 사용자별로 서버 저장 (/api/grid-prefs)
 *  · 동적으로 다시 그려지는 표·이후 추가되는 표에도 자동 적용
 *  · 대상: 단일행 헤더(th) 데이터 그리드. data-nocols 로 제외 가능
 * ────────────────────────────────────────────────────────────── */
(function () {
  "use strict";

  var prefsCache = {};      // grid_key -> { order, hidden, freeze, widths:{ origIdx:px } }
  var prefsLoaded = false;
  var CLIENT_PREFS_KEY = "tracker_grid_prefs_v1";

  // ── 유틸 ──
  function hash(str) {
    var h = 5381;
    for (var i = 0; i < str.length; i++) h = ((h << 5) + h + str.charCodeAt(i)) >>> 0;
    return h.toString(36);
  }
  function cleanLabel(th) { return (th.textContent || "").replace(/[▲▼★]/g, "").trim(); }
  function range(n) { var a = []; for (var i = 0; i < n; i++) a.push(i); return a; }

  function eligible(table) {
    if (table.__gcDone) return false;
    var thead = table.tHead;
    if (!thead || thead.rows.length !== 1) return false;     // 단일행 헤더만
    if (!table.tBodies.length) return false;
    if (table.hasAttribute("data-nocols") || table.closest("[data-nocols]")) return false;
    // 모달 안의 (재사용/전환되는) 테이블은 제외
    if (table.closest('.modal-ov, .modal, [id^="modal-"], #gc-panel')) return false;
    var ths = thead.rows[0].cells;
    if (ths.length < 2) return false;
    for (var i = 0; i < ths.length; i++) if ((ths[i].colSpan || 1) > 1) return false;  // 그룹헤더 제외
    return true;
  }

  function origCols(table) {
    if (table.__gcCols) return table.__gcCols;
    var ths = table.tHead.rows[0].cells, cols = [];
    for (var i = 0; i < ths.length; i++) cols.push({
      idx: i,
      label: cleanLabel(ths[i]) || ("컬럼 " + (i + 1)),
      width: ths[i].style.width || "",
      minWidth: ths[i].style.minWidth || "",
      maxWidth: ths[i].style.maxWidth || ""
    });
    table.__gcCols = cols;
    return cols;
  }

  function gridKey(table) {
    if (table.__gcKey) return table.__gcKey;
    if (table.dataset.gridKey) { table.__gcKey = table.dataset.gridKey; return table.__gcKey; }
    var idEl = table.closest("[id]");
    var base = (idEl ? idEl.id : "grid").replace(/[^a-zA-Z0-9_-]/g, "").slice(0, 40) || "grid";
    var sig = origCols(table).map(function (c) { return c.label; }).join("|");
    table.__gcKey = (base + "_" + hash(location.pathname + "|" + sig)).slice(0, 191);
    return table.__gcKey;
  }

  function getPrefs(table) {
    var n = origCols(table).length;
    var p = prefsCache[gridKey(table)];
    var freeze = (p && p.freeze != null) ? p.freeze : null;
    var widths = (p && p.widths && typeof p.widths === "object") ? Object.assign({}, p.widths) : {};
    if (!p || !Array.isArray(p.order) || p.order.length !== n) {
      return { order: range(n), hidden: (p && Array.isArray(p.hidden)) ? p.hidden.slice() : [], freeze: freeze, widths: widths };
    }
    return { order: p.order.slice(), hidden: (p.hidden || []).slice(), freeze: freeze, widths: widths };
  }

  // ── 적용 (헤더+바디 셀을 원본 index(data-col) 기준으로 재배치/숨김) ──
  function applyRow(row, order, hiddenSet, n) {
    var cells = Array.prototype.slice.call(row.children);
    if (cells.length !== n) return;   // colspan/placeholder 행은 건너뜀
    cells.forEach(function (c, i) { if (c.getAttribute("data-col") === null) c.setAttribute("data-col", String(i)); });
    order.forEach(function (ci) {
      var cell = null;
      for (var j = 0; j < cells.length; j++) if (cells[j].getAttribute("data-col") === String(ci)) { cell = cells[j]; break; }
      if (cell) { cell.style.display = hiddenSet.has(ci) ? "none" : ""; row.appendChild(cell); }
    });
  }
  function applyWidthToCell(cell, width, original) {
    if (!cell) return;
    if (width != null && Number(width) > 0) {
      var px = Math.max(48, Math.min(800, Math.round(Number(width)))) + "px";
      cell.style.width = px;
      cell.style.minWidth = px;
      cell.style.maxWidth = px;
      cell.style.boxSizing = "border-box";
      cell.setAttribute("data-gc-width", "1");
      return;
    }
    if (!cell.hasAttribute("data-gc-width")) return;
    cell.style.width = original ? original.width : "";
    cell.style.minWidth = original ? original.minWidth : "";
    cell.style.maxWidth = original ? original.maxWidth : "";
    cell.style.boxSizing = "";
    cell.removeAttribute("data-gc-width");
  }
  function applyColumnWidths(table, prefs) {
    var p = prefs || getPrefs(table);
    var widths = p.widths || {};
    var cols = origCols(table);
    var headRow = table.tHead && table.tHead.rows[0];
    if (!headRow) return;
    for (var ci = 0; ci < cols.length; ci++) {
      var width = widths[String(ci)];
      applyWidthToCell(cellByCol(headRow, ci), width, cols[ci]);
      for (var b = 0; b < table.tBodies.length; b++) {
        var rows = table.tBodies[b].rows;
        for (var r = 0; r < rows.length; r++) {
          if (rows[r].cells.length === 1 && (rows[r].cells[0].colSpan || 1) > 1) continue;
          applyWidthToCell(cellByCol(rows[r], ci), width, null);
        }
      }
    }
  }
  function applyTable(table) {
    var n = origCols(table).length;
    var p = getPrefs(table);
    var hiddenMap = {}; p.hidden.forEach(function (h) { hiddenMap[h] = 1; });
    var hiddenSet = { has: function (k) { return !!hiddenMap[k]; } };
    if (table.tHead && table.tHead.rows[0]) applyRow(table.tHead.rows[0], p.order, hiddenSet, n);
    for (var b = 0; b < table.tBodies.length; b++) {
      var rows = table.tBodies[b].rows;
      for (var r = 0; r < rows.length; r++) {
        var row = rows[r];
        if (row.cells.length === 1 && (row.cells[0].colSpan || 1) > 1) continue;
        applyRow(row, p.order, hiddenSet, n);
      }
    }
    applyColumnWidths(table, p);
    ensureResizeHandles(table);
    applyFreeze(table);
  }

  // ── 틀 고정 (freeze panes) — 지정 컬럼까지 가로 스크롤 시 좌측 고정 ──
  function cellByCol(row, ci) {
    var cells = row.children;
    for (var j = 0; j < cells.length; j++) if (cells[j].getAttribute("data-col") === String(ci)) return cells[j];
    return null;
  }
  function clearFreeze(table) {
    var stuck = table.querySelectorAll("[data-gc-stuck]");
    for (var i = 0; i < stuck.length; i++) {
      var c = stuck[i];
      c.style.position = ""; c.style.left = ""; c.style.zIndex = ""; c.style.boxShadow = "";
      c.style.background = c.getAttribute("data-gc-bg") || "";   // 원래 인라인 배경 복원
      c.removeAttribute("data-gc-bg");
      c.removeAttribute("data-gc-stuck");
    }
  }
  function stickCell(cell, left, isHeader, isLast) {
    if (!cell.hasAttribute("data-gc-stuck")) cell.setAttribute("data-gc-bg", cell.style.background || "");
    cell.style.position = "sticky";
    cell.style.left = left + "px";
    cell.style.zIndex = isHeader ? "6" : "3";
    if (!cell.style.background) cell.style.background = isHeader ? "#eef2f7" : "#fff";
    if (isLast) cell.style.boxShadow = "2px 0 0 0 #cbd5e1";
    cell.setAttribute("data-gc-stuck", "1");
  }
  function applyFreeze(table) {
    clearFreeze(table);
    var headRow = table.tHead && table.tHead.rows[0];
    if (!headRow) return;
    var p = getPrefs(table);
    if (p.freeze == null) return;
    var freezePos = p.order.indexOf(p.freeze);
    if (freezePos < 0) return;
    var hiddenMap = {}; p.hidden.forEach(function (h) { hiddenMap[h] = 1; });
    // 고정 대상 = 시각순서상 freeze 경계 위치까지의 '표시중' 컬럼
    var frozenIds = [];
    p.order.forEach(function (ci, pos) { if (pos <= freezePos && !hiddenMap[ci]) frozenIds.push(ci); });
    if (!frozenIds.length) return;
    var left = 0;
    frozenIds.forEach(function (ci, k) {
      var th = cellByCol(headRow, ci);
      if (!th) return;
      var w = th.offsetWidth;
      var isLast = (k === frozenIds.length - 1);
      stickCell(th, left, true, isLast);
      for (var b = 0; b < table.tBodies.length; b++) {
        var rows = table.tBodies[b].rows;
        for (var r = 0; r < rows.length; r++) {
          if (rows[r].cells.length === 1 && (rows[r].cells[0].colSpan || 1) > 1) continue;
          var td = cellByCol(rows[r], ci);
          if (td) stickCell(td, left, false, isLast);
        }
      }
      left += w;
    });
  }

  function savePrefs(table, prefs) {
    var k = gridKey(table);
    prefs._savedAt = Date.now();
    prefsCache[k] = prefs;
    try { localStorage.setItem(CLIENT_PREFS_KEY, JSON.stringify(prefsCache)); } catch (e) {}
    fetch("/api/grid-prefs", {
      method: "PUT", headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ grid_key: k, prefs: prefs }),
    }).catch(function () {});
  }

  // ── 헤더 경계 드래그 컬럼 폭 조절 ──
  function ensureResizeHandles(table) {
    var headRow = table.tHead && table.tHead.rows[0];
    if (!headRow) return;
    var cells = headRow.children;
    for (var i = 0; i < cells.length; i++) {
      var th = cells[i];
      if (th.querySelector(":scope > .gc-resizer")) continue;
      if (th.getAttribute("data-col") === null) continue;
      if (!th.style.position) th.style.position = "relative";
      var handle = document.createElement("span");
      handle.className = "gc-resizer";
      handle.title = "드래그하여 컬럼 폭 조절";
      handle.style.cssText =
        "position:absolute;top:0;right:-3px;width:7px;height:100%;z-index:9;" +
        "cursor:col-resize;touch-action:none;user-select:none;" +
        "background:linear-gradient(90deg,transparent 3px,#cbd5e1 3px,#cbd5e1 4px,transparent 4px);";
      handle.onmouseenter = function () { this.style.background = "rgba(37,99,235,.35)"; };
      handle.onmouseleave = function () {
        if (!this.hasAttribute("data-resizing")) {
          this.style.background = "linear-gradient(90deg,transparent 3px,#cbd5e1 3px,#cbd5e1 4px,transparent 4px)";
        }
      };
      handle.addEventListener("pointerdown", function (event) {
        event.preventDefault();
        event.stopPropagation();
        var target = event.currentTarget;
        var header = target.parentElement;
        var ci = parseInt(header.getAttribute("data-col"), 10);
        if (isNaN(ci)) return;
        var startX = event.clientX;
        var startWidth = header.getBoundingClientRect().width;
        var prefs = getPrefs(table);
        target.setPointerCapture(event.pointerId);
        document.body.style.cursor = "col-resize";
        document.body.style.userSelect = "none";
        target.setAttribute("data-resizing", "1");
        target.style.background = "rgba(37,99,235,.35)";

        function move(e) {
          var width = Math.max(48, Math.min(800, startWidth + e.clientX - startX));
          prefs.widths[String(ci)] = Math.round(width);
          prefsCache[gridKey(table)] = prefs;
          applyColumnWidths(table, prefs);
          applyFreeze(table);
        }
        function end(e) {
          target.removeEventListener("pointermove", move);
          target.removeEventListener("pointerup", end);
          target.removeEventListener("pointercancel", end);
          try { target.releasePointerCapture(e.pointerId); } catch (ignore) {}
          document.body.style.cursor = "";
          document.body.style.userSelect = "";
          target.removeAttribute("data-resizing");
          target.style.background = "linear-gradient(90deg,transparent 3px,#cbd5e1 3px,#cbd5e1 4px,transparent 4px)";
          savePrefs(table, prefs);
        }
        target.addEventListener("pointermove", move);
        target.addEventListener("pointerup", end);
        target.addEventListener("pointercancel", end);
      });
      th.appendChild(handle);
    }
  }

  // ── 컬럼조정 패널 ──
  function openPanel(table, btn) {
    closePanel();
    var cols = origCols(table);
    var p = getPrefs(table);
    var hiddenSet = {}; p.hidden.forEach(function (h) { hiddenSet[h] = 1; });
    var freeze = (p.freeze != null) ? p.freeze : null;
    var widths = Object.assign({}, p.widths || {});

    // 중앙 모달(헤더/푸터 고정 + 본문 세로 스크롤)
    var panel = document.createElement("div");
    panel.id = "gc-panel";
    panel.style.cssText =
      "position:fixed;inset:0;z-index:9500;background:rgba(15,23,42,.5);" +
      "display:flex;align-items:center;justify-content:center;padding:16px;font-size:13px;color:#1e293b;";
    panel.innerHTML =
      '<div class="gc-modal" style="background:#fff;border-radius:14px;width:360px;max-width:calc(100vw - 32px);max-height:85vh;display:flex;flex-direction:column;overflow:hidden;box-shadow:0 24px 60px rgba(0,0,0,.4);">' +
        // 헤더 (고정)
        '<div style="position:relative;flex:none;display:flex;align-items:center;justify-content:center;min-height:30px;padding:14px 54px;border-bottom:1px solid #1d4ed8;background:#2563eb;">' +
          '<div style="width:100%;text-align:center;font-weight:800;font-size:15px;color:#000;">컬럼 조정</div>' +
          '<button type="button" id="gc-x" aria-label="닫기" style="position:absolute;right:18px;top:14px;width:30px;height:30px;border:none;border-radius:50%;background:#f1f5f9;color:#475569;font-size:18px;line-height:1;cursor:pointer;">&times;</button>' +
        '</div>' +
        // 본문 (세로 스크롤)
        '<div style="flex:1;min-height:0;overflow-y:auto;padding:14px 18px;">' +
          '<div style="font-size:12px;color:#94a3b8;margin-bottom:10px;">표시할 컬럼을 선택하고, 드래그(⠿)로 순서를 바꾸세요. 표 헤더 경계를 드래그하면 폭을 조절할 수 있습니다. 📌 는 좌측 틀 고정입니다.</div>' +
          '<div id="gc-list"></div>' +
        '</div>' +
        // 푸터 (고정)
        '<div style="flex:none;display:flex;gap:8px;padding:12px 18px;border-top:1px solid #e2e8f0;background:#f8fafc;">' +
          '<button type="button" id="gc-reset" style="flex:1;font-size:13px;background:#fff;border:1px solid #cbd5e1;border-radius:8px;padding:9px;cursor:pointer;color:#475569;">초기화</button>' +
          '<button type="button" id="gc-close" style="flex:1;font-size:13px;background:#0f172a;color:#fff;border:none;border-radius:8px;padding:9px;cursor:pointer;font-weight:700;">닫기</button>' +
        '</div>' +
      '</div>';

    var listEl = panel.querySelector("#gc-list");
    // 현재 순서대로 행 구성
    p.order.forEach(function (ci) {
      var col = cols[ci];
      if (!col) return;
      var item = document.createElement("div");
      item.className = "gc-item";
      item.setAttribute("draggable", "true");
      item.dataset.col = String(ci);
      item.style.cssText = "display:flex;align-items:center;gap:8px;padding:7px 6px;border:1px solid #f1f5f9;border-radius:7px;margin-bottom:4px;background:#fff;cursor:grab;";
      item.innerHTML =
        '<span style="color:#cbd5e1;font-size:14px;">⠿</span>' +
        '<input type="checkbox" class="gc-chk" ' + (hiddenSet[ci] ? "" : "checked") + ' style="width:15px;height:15px;cursor:pointer;">' +
        '<span style="flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + (col.label || ("컬럼 " + (ci + 1))) + "</span>" +
        '<button type="button" class="gc-pin" title="이 컬럼까지 틀 고정" style="flex:none;border:none;background:none;cursor:pointer;font-size:13px;line-height:1;padding:2px;opacity:.35;">📌</button>';
      listEl.appendChild(item);
    });

    // 틀 고정 경계 시각 표시 (경계 컬럼 및 그 앞쪽 표시 컬럼 강조)
    function paintFreeze() {
      var items = listEl.querySelectorAll(".gc-item");
      var boundaryPos = -1;
      items.forEach(function (it, idx) { if (parseInt(it.dataset.col, 10) === freeze) boundaryPos = idx; });
      items.forEach(function (it, idx) {
        var frozen = (boundaryPos >= 0 && idx <= boundaryPos);
        it.style.background = frozen ? "#eff6ff" : "#fff";
        it.style.borderColor = frozen ? "#bfdbfe" : "#f1f5f9";
        var pin = it.querySelector(".gc-pin");
        pin.style.opacity = (parseInt(it.dataset.col, 10) === freeze) ? "1" : (frozen ? ".6" : ".35");
      });
    }
    paintFreeze();

    document.body.appendChild(panel);
    // 배경(오버레이) 클릭 시 닫기
    panel.addEventListener("click", function (e) { if (e.target === panel) closePanel(); });

    function commit() {
      var items = listEl.querySelectorAll(".gc-item");
      var order = [], hidden = [];
      items.forEach(function (it) {
        var ci = parseInt(it.dataset.col, 10);
        order.push(ci);
        if (!it.querySelector(".gc-chk").checked) hidden.push(ci);
      });
      // freeze 컬럼이 숨김이면 고정 해제
      if (freeze != null && hidden.indexOf(freeze) >= 0) freeze = null;
      var prefs = { order: order, hidden: hidden, freeze: freeze, widths: widths };
      prefsCache[gridKey(table)] = prefs;
      applyTable(table);
      savePrefs(table, prefs);
    }

    // 체크박스 → 표시/숨김
    listEl.addEventListener("change", function (e) {
      if (e.target.classList.contains("gc-chk")) commit();
    });

    // 📌 → 틀 고정 경계 지정 (토글)
    listEl.addEventListener("click", function (e) {
      var pin = e.target.closest(".gc-pin");
      if (!pin) return;
      var it = pin.closest(".gc-item");
      var ci = parseInt(it.dataset.col, 10);
      freeze = (freeze === ci) ? null : ci;
      paintFreeze();
      commit();
    });

    // 드래그앤드랍 순서변경
    var dragEl = null;
    listEl.addEventListener("dragstart", function (e) {
      var it = e.target.closest(".gc-item"); if (!it) return;
      dragEl = it; it.style.opacity = ".4";
    });
    listEl.addEventListener("dragend", function () {
      if (dragEl) dragEl.style.opacity = "";
      dragEl = null; commit();
    });
    listEl.addEventListener("dragover", function (e) {
      e.preventDefault();
      var over = e.target.closest(".gc-item");
      if (!over || over === dragEl || !dragEl) return;
      var rc = over.getBoundingClientRect();
      var after = (e.clientY - rc.top) > rc.height / 2;
      listEl.insertBefore(dragEl, after ? over.nextSibling : over);
    });

    panel.querySelector("#gc-x").onclick = closePanel;
    panel.querySelector("#gc-close").onclick = closePanel;
    panel.querySelector("#gc-reset").onclick = function () {
      var n = cols.length;
      freeze = null;
      widths = {};
      var prefs = { order: range(n), hidden: [], freeze: null, widths: {} };
      prefsCache[gridKey(table)] = prefs;
      applyTable(table);
      savePrefs(table, prefs);
      closePanel();
    };
  }
  function closePanel() {
    var ex = document.getElementById("gc-panel");
    if (ex && ex.parentNode) ex.parentNode.removeChild(ex);
  }
  // ESC 로 닫기
  document.addEventListener("keydown", function (e) { if (e.key === "Escape") closePanel(); });

  // ── 버튼 삽입 ──
  function injectButton(table) {
    var anchor = (table.parentElement && table.parentElement.classList.contains("tbl-wrap"))
      ? table.parentElement : table;
    if (!anchor.parentNode) return;
    var bar = document.createElement("div");
    bar.className = "gc-bar";
    bar.style.cssText = "display:flex;justify-content:flex-end;margin:0 0 6px;";
    var btn = document.createElement("button");
    btn.type = "button"; btn.className = "gc-btn"; btn.textContent = "⚙ 컬럼조정";
    btn.style.cssText = "font-size:12px;color:#475569;background:#fff;border:1px solid #cbd5e1;border-radius:8px;padding:5px 11px;cursor:pointer;line-height:1.2;";
    btn.onmouseover = function () { btn.style.background = "#f1f5f9"; };
    btn.onmouseout = function () { btn.style.background = "#fff"; };
    btn.onclick = function (e) { e.stopPropagation(); openPanel(table, btn); };
    bar.appendChild(btn);
    anchor.parentNode.insertBefore(bar, anchor);
  }

  // ── 표 처리 ──
  var processed = [];
  function processTable(table) {
    if (!eligible(table)) return;
    table.__gcDone = true;
    processed.push(table);
    origCols(table);
    injectButton(table);
    applyTable(table);
    // 재렌더 시 재적용 — 헤더/바디 행 교체 감지 (셀 이동은 tr 내부라 미감지 → 루프 없음)
    var reapply = debounce(function () { applyTable(table); }, 30);
    var mo = new MutationObserver(reapply);
    if (table.tHead) mo.observe(table.tHead, { childList: true });
    for (var b = 0; b < table.tBodies.length; b++) mo.observe(table.tBodies[b], { childList: true });
  }
  // 창 크기 변경 → 고정 컬럼 폭 재계산
  var onResize = debounce(function () {
    for (var i = 0; i < processed.length; i++) {
      if (document.body.contains(processed[i])) applyFreeze(processed[i]);
    }
  }, 150);
  window.addEventListener("resize", onResize);

  function debounce(fn, ms) {
    var t = null;
    return function () { if (t) clearTimeout(t); t = setTimeout(fn, ms); };
  }

  function scanAll() {
    if (!prefsLoaded) return;
    var tables = document.getElementsByTagName("table");
    for (var i = 0; i < tables.length; i++) processTable(tables[i]);
  }

  // ── 초기화 ──
  function init() {
    try {
      var localPrefs = JSON.parse(localStorage.getItem(CLIENT_PREFS_KEY) || "{}");
      if (localPrefs && typeof localPrefs === "object") prefsCache = localPrefs;
    } catch (e) {}
    fetch("/api/grid-prefs")
      .then(function (r) { return r.ok ? r.json() : null; })
      .then(function (d) {
        if (d && d.ok && d.prefs) {
          Object.keys(d.prefs).forEach(function (key) {
            var serverPrefs = d.prefs[key] || {};
            var clientPrefs = prefsCache[key] || {};
            if (Number(clientPrefs._savedAt || 0) > Number(serverPrefs._savedAt || 0)) return;
            if ((!serverPrefs.widths || !Object.keys(serverPrefs.widths).length) &&
                clientPrefs.widths && Object.keys(clientPrefs.widths).length) {
              serverPrefs.widths = Object.assign({}, clientPrefs.widths);
            }
            prefsCache[key] = serverPrefs;
          });
          try { localStorage.setItem(CLIENT_PREFS_KEY, JSON.stringify(prefsCache)); } catch (e) {}
        }
      })
      .catch(function () {})
      .then(function () {
        prefsLoaded = true;
        scanAll();
        // 이후 동적으로 추가되는 표도 처리
        var rescan = debounce(scanAll, 250);
        new MutationObserver(rescan).observe(document.body, { childList: true, subtree: true });
      });
  }
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
