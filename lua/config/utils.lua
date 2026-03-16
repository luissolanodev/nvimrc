local M = {}

M.has_nerd_fonts_support = os.getenv("TERM_HAS_NERD_FONT") == "1"

return M
