# Keymaps

Cheat sheet for tmux and Neovim. Items marked ⭐ are the ones used most often.

- **tmux prefix** = `Ctrl+s` (written `Prefix` below). Press it, release, then press the next key.
- **Neovim leader** = `Space` (written `Leader` below).
- Sources: `.config/tmux/tmux.conf`, `.config/nvim/lua/keymaps.lua` and the plugin files in `.config/nvim/lua/plugins/`.

---

## ⭐ Daily drivers

| Keys | What it does |
|---|---|
| `Prefix` + `←↓↑→` | Move between tmux panes and Neovim splits (seamless) |
| `Prefix` + `Shift+←↓↑→` | Resize tmux pane (repeatable, no need to re-press `Prefix`) |
| `Prefix` `v` / `h` | Split pane side by side / stacked |
| `Prefix` `c` | New tmux window |
| `Ctrl+Shift+←/→` | Previous / next tmux window (no prefix) |
| `Leader` `r` + arrows | Resize Neovim split (repeat the whole combo each time) |
| `Leader` `s` | Save (only if changed) |
| `Leader` `q` / `x` | Quit / save and quit |
| `Leader` `ff` / `fg` / `fb` | Find files / live grep / buffers |
| `Leader` `t` | Open file tree (right side) |
| `Leader` `;` | Toggle floating terminal |
| `gcc` | Comment line |
| `K` / `gd` | LSP hover / go to definition |
| `Leader` `nh` | Clear search highlight |

---

## tmux

### Panes and windows

| Keys | What it does |
|---|---|
| `Prefix` `v` | Split pane left/right (new pane beside the current one) |
| `Prefix` `h` | Split pane top/bottom (new pane below the current one) |
| `Prefix` `c` | Create a new **window** (a tab, not a pane) |
| `Prefix` `n` / `p` | Next / previous window |
| `Prefix` `1`–`9` | Jump to window by number (numbering starts at 1) |
| `Ctrl+Shift+←/→` | Previous / next window, no prefix needed |
| `Prefix` `z` | Zoom the current pane to full screen, press again to restore |
| `Prefix` `x` | Close the current pane (asks to confirm) |
| `Prefix` `&` | Close the current window (asks to confirm) |
| `Prefix` `,` | Rename the current window |
| `Prefix` `w` | Pick a window from a list |

### Moving and resizing

| Keys | What it does |
|---|---|
| `Prefix` `←↓↑→` | Select the pane in that direction. If the pane is running Neovim, the key goes to Neovim so it can move between its own splits first |
| `Prefix` `Shift+←↓↑→` | Resize the pane by 3 cells. Repeatable: press `Prefix` once, then keep tapping `Shift`+arrow (default repeat window is 500 ms) |

### Session and config

| Keys | What it does |
|---|---|
| `Prefix` `r` | Reload `tmux.conf` |
| `Prefix` `d` | Detach from the session |
| `Prefix` `Ctrl+s` | Send a literal `Ctrl+s` to the program inside |
| `Prefix` `[` | Enter copy mode |

### Copy mode (vi keys) and mouse

| Keys | What it does |
|---|---|
| `Prefix` `[` | Start copy mode, then move with `h j k l`, `/` to search, `Ctrl+u` / `Ctrl+d` to page |
| `Space` | Start selection |
| `Enter` | Copy the selection to the macOS clipboard and leave copy mode |
| Mouse drag | Select and copy to clipboard on release |
| Mouse wheel / click | Scroll, select pane, resize by dragging borders (mouse is on) |

---

## Neovim

### Files, windows and splits

| Keys | What it does |
|---|---|
| `Leader` `s` | Save only if there is a change |
| `Leader` `q` | Quit |
| `Leader` `x` | Save and quit |
| `Leader` `w` | Same as `Ctrl+w` (window commands). `Ctrl+w` itself is disabled. Example: `Leader` `w` `v` splits vertically |
| `Leader` `r` `←↓↑→` | Resize the split by 3 |
| `Leader` `r` `=` | Make all splits equal |
| `Leader` `r` `_` | Maximize height |
| `Leader` `r` `\|` | Maximize width |
| `Prefix` `←↓↑→` | Move between Neovim splits and tmux panes |

### Editing

| Keys | Mode | What it does |
|---|---|---|
| `p` | Visual | Paste over the selection without losing what you yanked |
| `Leader` `d` | Normal, Visual | Delete without yanking |
| `J` / `K` | Visual | Move the selected lines down / up and re-indent |
| `<` / `>` | Visual | Unindent / indent and keep the selection |
| `Tab` / `Shift+Tab` | Insert | Jump out of / back into a bracket or quote pair (tabout) |

### Comments (Comment.nvim)

| Keys | What it does |
|---|---|
| `gcc` | Toggle comment on the current line |
| `gc` + motion | Toggle line comment over a motion, for example `gcap` for a paragraph |
| `gc` | Visual: toggle line comment on the selection |
| `gbc` / `gb` | Same as above, with block comments |
| `Leader` `co` / `cO` | Add a comment on the line below / above |
| `Leader` `ce` | Add a comment at the end of the line |

### Search

| Keys | What it does |
|---|---|
| `/` `?` | Search forward / backward |
| `n` / `N` | Next / previous match, with `[3/8]` style counters (hlslens) |
| `3n` / `3N` | Jump 3 matches. The lens hint shows the count to type, for example `[3n 8]` |
| `*` / `#` | Search the word under the cursor forward / backward |
| `g*` / `g#` | Same, but match partial words |
| `Leader` `nh` | Clear search highlighting |

### Telescope (fuzzy finder)

| Keys | What it does |
|---|---|
| `Leader` `ff` | Find files (includes hidden, sorted) |
| `Leader` `fg` | Live grep (includes hidden) |
| `Leader` `fb` | Open buffers |

Inside the Telescope prompt:

| Keys | What it does |
|---|---|
| `Ctrl+n` / `Ctrl+p` | Next / previous result |
| `Enter` | Open |
| `Ctrl+x` / `Ctrl+v` / `Ctrl+t` | Open in horizontal split / vertical split / tab |
| `Ctrl+u` / `Ctrl+d` | Scroll the preview up / down |
| `Ctrl+q` | Send results to the quickfix list |
| `Esc` or `Ctrl+c` | Close |

### File tree (Neo-tree)

| Keys | What it does |
|---|---|
| `Leader` `t` | Open the tree on the right (follows the current file) |
| `Enter` | Open file or toggle folder |
| `s` | Open in vertical split |
| `S` | Open in horizontal split |
| `a` | New file (a name ending in `/` also creates a folder) |
| `A` | New directory |
| `Space` | Toggle the folder under the cursor |
| `d` | Delete |
| `r` | Rename |
| `y` / `x` / `p` | Copy / cut / paste |
| `H` | Toggle hidden files |
| `/` | Filter |
| `R` | Refresh |
| `q` | Close |
| `?` | Show all tree keys |

### LSP and diagnostics

| Keys | What it does |
|---|---|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `Leader` `ca` | Code action (Normal, Visual) |
| `Leader` `gf` | Format the buffer |
| `Leader` `e` | Show the diagnostic under the cursor |
| `Leader` `cd` | Diagnostics list for the buffer |
| `]d` / `[d` | Next / previous diagnostic |
| `grn` | Rename symbol (Neovim default) |
| `grr` | List references (Neovim default) |
| `gri` | List implementations (Neovim default) |

### Completion (built in)

The popup opens automatically while you type.

| Keys | What it does |
|---|---|
| `Ctrl+n` / `Ctrl+p` | Next / previous item |
| `Ctrl+y` | Accept the item |
| `Ctrl+e` | Cancel the popup |

### Folding (treesitter)

Everything starts unfolded. These are Neovim defaults.

| Keys | What it does |
|---|---|
| `za` | Toggle the fold under the cursor |
| `zc` / `zo` | Close / open the fold |
| `zC` / `zO` | Close / open the fold and everything nested in it |
| `zM` / `zR` | Close / open all folds in the file |
| `zm` / `zr` | Fold more / less, one level at a time |
| `zj` / `zk` | Move to the next / previous fold |
| `zv` | Open just enough folds to show the cursor line |

### Tools

| Keys | What it does |
|---|---|
| `Leader` `;` | Toggle the floating terminal (works from terminal mode too) |
| `Leader` `u` | Undo tree (history survives restarts) |
| `Leader` `D` | Diff two files or directories (prompts for paths) |
| `Leader` (wait) | which-key popup lists the available keys after about 0.5 s |

### Command line

| Keys | What it does |
|---|---|
| `↑` / `↓` | Cycle through completion matches while the completion menu is open |
| `Tab` | Complete (case-sensitive on `:`) |

### Packages

```vim
:lua vim.pack.update()
:write            " saves nvim-pack-lock.json after the update
```

---

## Cross-tool cheat sheet

| Goal | Keys |
|---|---|
| Move between any split or pane | `Prefix` + arrows |
| Resize a tmux pane | `Prefix` + `Shift` + arrows |
| Resize a Neovim split | `Leader` `r` + arrows |
| Split in tmux | `Prefix` `v` / `h` |
| Split in Neovim | `Leader` `w` `v` / `s` (via `Ctrl+w`), or `s` / `S` from the file tree |
| New tab-like workspace | `Prefix` `c` (tmux window) |
