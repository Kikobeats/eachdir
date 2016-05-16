# eachdir

<h1 align="center">
  <img src="http://i.imgur.com/gBTP7Xp.png" alt="eachdir">
</h1>

> Run one or more commands in one or more dirs.

## Install

```bash
npm install --global eachdir
```

## Usage

```sh
$ eachdir

Run one or more commands in one or more dirs.

  Usage
   $ eachdir [dirs --] <commands>

  By default, all subdirs of the current dir will be iterated.

  Use '--' to separate a list of dirs from commands to be executed.

  Multiple commands must be specified as a single string argument.

  Example
    # Print the working directory
      $ eachdir pwd
      $ eachdir * -- pwd

    # Perform a 'git pull' inside for subdirs starting with 'repo-'
      $ eachdir repo-* -- git pull

    # Perform a few commands inside all subdirs starting with 'repo-'
      $ eachdir repo-* -- 'git fetch && git merge'
```

## License

MIT © [Kiko Beats](http://kikobeats.com)
