/*! sortable.js 0.5.0 */
(function() {
  var a, b, c, d, e, f;
  a = "table[data-sortable]", c = /^-?[£$¤]?[\d,.]+%?$/, f = /^\s+|\s+$/g, e = "ontouchstart" in document.documentElement, b = e ? "touchstart" : "click", d = {
    init: function() {
      var b, c, e, f, g;
      for (c = document.querySelectorAll(a), g = [], e = 0, f = c.length; f > e; e++) b = c[e], g.push(d.initTable(b));
      return g
    },
    initTable: function(a) {
      var b, c, e, f, g;
      if (1 === a.tHead.rows.length && "true" !== a.getAttribute("data-sortable-initialized")) {
        for (a.setAttribute("data-sortable-initialized", "true"), e = a.querySelectorAll("th"), b = f = 0, g = e.length; g > f; b = ++f) c = e[b], "false" !== c.getAttribute("data-sortable") && d.setupClickableTH(a, c, b);
        return a
      }
    },
    setupClickableTH: function(a, c, e) {
      var f;
      return f = d.getColumnType(a, e), c.addEventListener(b, function() {
        var b, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u;
        for (j = "true" === this.getAttribute("data-sorted"), k = this.getAttribute("data-sorted-direction"), b = j ? "ascending" === k ? "descending" : "ascending" : f.defaultSortDirection, m = this.parentNode.querySelectorAll("th"), n = 0, q = m.length; q > n; n++) c = m[n], c.setAttribute("data-sorted", "false"), c.removeAttribute("data-sorted-direction");
        for (this.setAttribute("data-sorted", "true"), this.setAttribute("data-sorted-direction", b), l = a.tBodies[0], h = [], t = l.rows, o = 0, r = t.length; r > o; o++) g = t[o], h.push([d.getNodeValue(g.cells[e]), g]);
        for (j ? h.reverse() : h.sort(f.compare), u = [], p = 0, s = h.length; s > p; p++) i = h[p], u.push(l.appendChild(i[1]));
        return u
      })
    },
    getColumnType: function(a, b) {
      var e, f, g, h, i;
      for (i = a.tBodies[0].rows, g = 0, h = i.length; h > g; g++)
        if (e = i[g], f = d.getNodeValue(e.cells[b]), "" !== f && f.match(c)) return d.types.numeric;
      return d.types.alpha
    },
    getNodeValue: function(a) {
      return a ? null !== a.getAttribute("data-value") ? a.getAttribute("data-value") : "undefined" != typeof a.innerText ? a.innerText.replace(f, "") : a.textContent.replace(f, "") : ""
    },
    types: {
      numeric: {
        defaultSortDirection: "descending",
        compare: function(a, b) {
          var c, d;
          return c = parseFloat(a[0].replace(/[^0-9.-]/g, "")), d = parseFloat(b[0].replace(/[^0-9.-]/g, "")), isNaN(c) && (c = 0), isNaN(d) && (d = 0), d - c
        }
      },
      alpha: {
        defaultSortDirection: "ascending",
        compare: function(a, b) {
          var c, d;
          return c = a[0].toLowerCase(), d = b[0].toLowerCase(), c === d ? 0 : d > c ? -1 : 1
        }
      }
    }
  }, setTimeout(d.init, 0), window.Sortable = d
}).call(this);