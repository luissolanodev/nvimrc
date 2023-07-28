require('luasnip').config.setup {
    --  if true, Snippets that were exited can still be jumped back into.
    history = true,
    -- Choose which events trigger an update of the active nodes' dependents.
    updateevents = "TextChanged,TextChangedI",
    -- Events on which to leave the current snippet if the cursor is outside its' 'region'
    region_check_events = "CursorMoved"

}
require('luasnip.loaders.from_vscode').lazy_load()
