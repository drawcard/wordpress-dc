# WordPress Skeleton (Drawcard Fork)

This is simply a skeleton repo for a WordPress site. Use it to jump-start your WordPress site repos, or fork it and customize it to your own liking!

---

## Setup Instructions

### Grabbing the PHP code
```bash
git clone https://github.com/drawcard/wordpress-dc project-name
cd project-name
git submodule init
git submodule update --recursive
git checkout drawcard
./init.sh #Optional
```

### What is init.sh?
Init.sh is a simple script that installs a few helpful extras, eg. Roots theme, DBSync, etc. It's not compulsory.

### Setting up
This setup assumes you've installed WP on a local server or VM, and you intend to synchronise it to a remote production server somewhere on the Internet. You need to create a local DB as well as a remote DB (eg using PHPMyAdmin) and write down the access credentials.
```bash
cp local-config-sample.php local-config.php
nano local-config.php
# Add your local db information here, save and exit

nano wp-config.php
# Add your remote db information here

# For security reasons and to reduce conflicts, it's also a good idea to change table prefixes before running WP setup.
# Replace 'wp_' with a random letter or number combination, eg:
$table_prefix = '20dc3_'; # Line 45
# Save and exit the file

# Visit your project's URL in a browser to finish setup
```

### If you are using Roots.io theme + Grunt for autocompiling Sass / JS
(Assuming you have those packages preinstalled)

```bash
# After running init.sh
cd content/themes/build
npm install
# If you are getting errors you are probably missing dependencies
# Be sure that you've installed Ruby, Sass + Compass Gems!
grunt build # Initialise the theme files
grunt watch # Monitor the folder for changes and compile on the fly
```

## If you are experiencing CSS / JS loading issues with themes
If you are hosting your WP install in a subfolder on your server (eg ip-address/project-name/...) you need to tell wp-config where to find the custom content directory. On line 84 change the following:

```php
define( 'WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/content' );
// change to
define( 'WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/project-name/content' );
```

## Assumptions

* WordPress as a Git submodule in `/wp/`
* Custom content directory in `/content/` (cleaner, and also because it can't be in `/wp/`)
* `wp-config.php` in the root (because it can't be in `/wp/`)
* All writable directories are symlinked to similarly named locations under `/shared/`.

## Questions & Answers

**Q:** Will you accept pull requests?  
**A:** Maybe — if I think the change is useful. I primarily made this for my own use, and thought people might find it useful. If you want to take it in a different direction and make your own customized skeleton, then just maintain your own fork.

**Q:** Why the `/shared/` symlink stuff for uploads?  
**A:** For local development, create `/shared/` (it is ignored by Git), and have the files live there. For production, have your deploy script (Capistrano is my choice) look for symlinks pointing to `/shared/` and repoint them to some outside-the-repo location (like an NFS shared directory or something). This gives you separation between Git-managed code and uploaded files.

**Q:** What version of WordPress does this track?  
**A:** The latest stable release. Send a pull request if I fall behind.

**Q:** What's the deal with `local-config.php`?  
**A:** It is for local development, which might have different MySQL credentials or do things like enable query saving or debug mode. This file is ignored by Git, so it doesn't accidentally get checked in. If the file does not exist (which it shouldn't, in production), then WordPress will used the DB credentials defined in `wp-config.php`.

**Q:** What is `memcached.php`?  
**A:** This is for people using memcached as an object cache backend. It should be something like: `<?php return array( "server01:11211", "server02:11211" ); ?>`. Programattic generation of this file is recommended.

**Q:** Does this support WordPress in multisite mode?  
**A:** Yes, as of WordPress v3.5 which was released in December, 2012.
