# pacbrew-repo
Build a PS5 package repository you can put into your `pacman.conf`.

## Purpose of this fork
1. To output a package repository rather than a zip of all the contents.
2. To make the packages work on Arch Linux.
3. To use some of the neat Arch Build System tools.

## Building
1. Ensure `devtools` package is installed.

   ```
   # pacman -S devtools
   ```
   
2. Clone this git repository and run `build.sh`.

    ```
    $ git clone https://github.com/rootlis/pacbrew-repo.git
    $ cd pacbrew-repo
    $ sh build.sh
    ```

3. Your newly-built Pacman repository will be in the `repo` subdirectory. Put it wherever you like. I put the contents of `repo` into `/srv/repo/ps5-payload-dev`. You could also host it on a server to save others the trouble of building it themselves.

The package repository is now ready.

## Using
1. Add the repository to your `pacman.conf`. For example, if you have installed the repository to `/srv/repo/ps5-payload-dev`, you'd put the following in your `pacman.conf`:

   ```
   [ps5-payload-dev]
   SigLevel = Optional TrustAll
   Server = file:///srv/repo/$repo
   ```

2. Update your Pacman database and system.

   ```
   # pacman -Syu
   ```

3. Done. You can install the packages now. Example:
   ```
   # pacman -S ps5-payload-offact
   ```

## Additional note

`build.sh` creates the `chroot` directory to build the packages, but does not delete it when it's done. For a clean build, delete both the `chroot` and `repo` directories.
