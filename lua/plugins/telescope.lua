local telescope = require('telescope')
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = {"--mime-type", "-b", filepath},
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false,
                                               {"No preview available."})
                end)
            end
        end
    }):sync()
end

telescope.setup {
    defaults = {
        preview = {
            mime_hook = function(filepath, bufnr, opts) -- Preview images using catimg
                local is_image = function(filepath)
                    local image_extensions = {'png', 'jpg'} -- Supported image formats
                    local split_path = vim.split(filepath:lower(), '.',
                                                 {plain = true})
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. '\r\n')
                        end
                    end
                    vim.fn.jobstart({
                        'catimg', filepath -- Terminal image viewer command
                    }, {
                        on_stdout = send_output,
                        stdout_buffered = true,
                        pty = true
                    })
                else
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr, opts.winid, "Binary cannot be previewed")
                end
            end
        },
        vimgrep_arguments = {
            "rg", "-L", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case"
        },
        prompt_prefix = "󰍉 ",
        selection_caret = "  ",
        entry_prefix = "  "
    },
    pickers = {find_files = {theme = 'ivy'}},
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true
        }
    }
}

telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fc', builtin.commands)
