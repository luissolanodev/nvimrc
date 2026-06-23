return {
  "cormacrelf/dark-notify",
  lazy = false,
  config = function()
    require("dark_notify").run({
      schemes = {
        dark = "tokyonight-night",
        light = "tokyonight-day",
      },
    })
  end,
}
