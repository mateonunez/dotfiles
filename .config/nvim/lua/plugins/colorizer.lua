return {
  -- Inline color swatches for hex / rgb / tailwind (naumovs.color-highlight).
  -- Maintained fork of the original norcalli plugin.
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        names    = false, -- don't colorize words like "red"
        tailwind = true,
        css      = true,
      },
    },
  },
}
