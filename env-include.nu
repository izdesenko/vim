export-env {
  $env.EDITOR = "emacs"
  $env.VISUAL = "emacs"
  $env.VIEWER = "less"
  $env.PAGER = "less"
  $env.LESS = ' -Ri ' # less without word wrapp
  $env.TERM = 'xterm-256color'
  $env.DOCKER_ID_USER = "izdesenko"
  $env.LESSCHARSET = "UTF-8"
  $env.NODE_REPL_HISTORY = "~/.vim/.node_repl_history"
}
