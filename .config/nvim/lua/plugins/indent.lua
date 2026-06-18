return {
  -- Indentation guides (VS Code's indent rulers), with active-scope highlight.
  {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      indent = { char = "│" },
      scope  = { enabled = true, show_start = false, show_end = false },
    },
  },
}
