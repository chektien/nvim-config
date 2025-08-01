return {
  s({ trig = "beg", dscr = "begin{} / end{}" }, {
    t("\\begin{"), i(1), t({"}", "\t"}), i(0), t({"", "\\end{"}), rep(1), t("}"),
  }),

  s({ trig = "cnt", dscr = "Center" }, {
    t({"\\begin{center}", "\t"}), i(0), t({"", "\\end{center}"}),
  }),

  s({ trig = "frac", dscr = "Fraction" }, {
    t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0),
  }),

  s({ trig = "dm", dscr = "Display Math" }, {
    t({"\\[", "\t"}), i(1), t({"", "\\]"}), i(0),
  }),

  s({ trig = "srto", dscr = "nth Root" }, {
    t("\\sqrt["), i(1), t("]{"), i(2), t("}"), i(0),
  }),

  s({ trig = "fig", dscr = "Figure env" }, {
    t("\\begin{figure}["), i(1, "htpb"), t({"]", "\t\\centering", "\t\\includegraphics[width="}),
    i(2, "0.8"), t("\\textwidth]{"), i(3, "path/to/img"), t({"}", "\t\\caption{"}), i(4, "Caption"),
    t({"}", "\t\\label{fig:"}), f(function(args)
      local label = args[1][1]:lower():gsub("%s", "-")
      label = label:gsub("%..*", "")
      return label
    end, { 3 }), t({"}", "\\end{figure}"}), i(0),
  }),

  s({ trig = "sec", dscr = "Section" }, {
    t("\\section{"), i(1), t({"}", "\\label{sec:"}), f(function(args)
      return args[1][1]:lower():gsub("%s", "-")
    end, { 1 }), t("}"), i(0),
  }),

  s({ trig = "cite", dscr = "Cite reference" }, {
    t("~\\cite{"), i(1), t("}"), i(0),
  }),

  s({ trig = "todo", dscr = "Todonote" }, {
    t("~\\todo{"), i(1), t("}"), i(0),
  }),

  s({ trig = "itm", dscr = "Item" }, {
    t("\\item "), i(1), i(0),
  }),

  s({ trig = "sum", dscr = "Summation" }, {
    t("\\sum_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} "), i(3, "a_n z^n"), i(0),
  }),

  s({ trig = "prod", dscr = "Product" }, {
    t("\\prod_{"), i(1, "n=1"), t("}^{"), i(2, "\\infty"), t("} "), i(3), i(0),
  }),

  s({ trig = "chek", dscr = "Chek note" }, {
    t("\\chek{"), i(1), t("}"), i(0),
  }),
}
