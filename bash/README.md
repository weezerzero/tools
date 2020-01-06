# Bash tools for working with git
* The git_bash script creates an enhanced prompt
  indicating the current state of the repo you are
  in.

* The git_fetch script is for a cron job that will
  run git fetch every hour so you are always up
  to date. The git fetch script will load up all
  directories that are listed in __git_fetch.
  NOTE: you must checkout your git repo over ssh
  for everything to work. HTTPS will not fetch
  correctly when using a cron job.

* Both scripts have an installer script to get
  everything setup.
