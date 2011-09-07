throughnothing's dotfiles
===
About
==
These are my dotfiles.  These files will get my environment up and running the way i need it to be to get stuff done(tm).

In this repo, the files do not have the preceding '.' in their names.  The install script takes care of this.  It loops over every file except the install and README files, and symlinks them to ~/ with the preceding '.'.  This way i simple git pull (or 'dfu' to call the function in my bashrc) will update everything.

Use
==
To use these dotfiles, simply clone the repo, checkout your desired branch, and then run the install script:

    ./install

This will create symlinks in ~/. to the files in the git repo.  It will also remove any existing symlinks, or backup files if they were already there.

I also have a gist, which can be used to automate the entire process:

* https://gist.github.com/921139

I host an up-to-date copy of this script at http://throughnothing.com/dfs, making it easy to install a new box with:

    curl throughnothing.com/dfs | bash
    bash <(curl throughnothing.com/dfs)

To use with a specific branch:

    curl throughnothing.com/dfs.sh | bash -s BRANCH 
    bash <(curl throughnothing.com/dfs) BRANCH

To use with a shallow clone:

    curl throughnothing.com/dfs.sh | bash -s BRANCH 1
    bash <(curl throughnothing.com/dfs) BRANCH 1
    
