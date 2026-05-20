-- Базовые плагины
require("git"):setup()
require("full-border"):setup()
require("starship"):setup()
require("yatline"):setup()
require("rich-preview"):setup()

-- Плагины управления и утилиты
require("session"):setup { sync_yanked = true }
require("folder-rules"):setup()
require("bookmarks"):setup()
require("smart-enter"):setup()
require("mime-ext"):setup()
require("wl-clipboard"):setup()

-- Плагины смены поведения
require("nav-parent-panel"):setup()
require("close-and-restore-tab"):setup()
require("toggle-pane"):setup()
require("smart-filter"):setup()

-- Плагины монтирования и действий
require("gvfs"):setup()
require("mount"):setup()
require("yafg"):setup()
require("sudo"):setup()
require("chmod"):setup()
require("dupes"):setup()
require("rsync"):setup()
require("restore"):setup()
require("piper"):setup()
require("ouch"):setup()
require("gitui"):setup()
require("diff"):setup()
require("drag"):setup()
require("glow"):setup()
require("jjui"):setup()
require("nord"):setup()
