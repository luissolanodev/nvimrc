local luasnip = require("luasnip")
luasnip.config.set_config {
   --  If true, Snippets that were exited can still be jumped back into.
   history = true,
   -- Choose which events trigger an update of the active nodes' dependents.
   updateevents = "TextChanged,TextChangedI",
   region_check_events = "CursorMoved"
}
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
-- Load only snippets of the language you use
require("luasnip.loaders.from_vscode").lazy_load()
