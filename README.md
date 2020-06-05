throughnothing's dotfiles
===
About
==
These are my dotfiles, but also a little bit more.  These files will get my environment up and running the way i need it to be to get stuff done(tm).

For now, this is tailored to a Mac, and will help setup homebrew, my applications (via `brew`), etc.

Use
==
To use these dotfiles, simply clone the repo, checkout your desired branch, and then run the install script:

    ./mac-setup.sh

This will create symlinks in ~/. to the files in the git repo.  It will also remove any existing symlinks, or backup files if they were already there.

I host an up-to-date copy of this script at http://willwolf.me/mac-setup.sh, making it easy to install a new box with:

    curl https://willwolf.me/mac-setup.sh | bash