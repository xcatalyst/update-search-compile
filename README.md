# Update Search Compile

This is a really easy elisp code but there might be people who are looking for this
kind of a utility so I decided to push it to github.

update-search-compile.el includes 2 functions that I had to write to improve
the emacs workflow. Both of the functions look recursively on the directory
and climb up to find the corresponding file they need.

### update-ctags: Update TAG file

 * This is an async function, even on a large codebase
is doesn't stall emacs but you will have to wait for ctags to
finish.

 * This function doesn't generate a TAG file if it cannot find
one when traveling up recursively. You have to generate the
first TAG file for this script to work. You ony have to do that for
the first time.

### search-compile: Search for the build file and compile

 * On windows: this function looks for "build.bat" and executes.
 * On non-windows systems: functions looks for "build.sh" and
 executes, if there is no "build.sh" it looks for "Makefile" and
 if found, the function executes "make -k"
```elisp

(load-file "<path_to_file>/update-search-compile.el")

;; Set a key for update-ctags
(global-set-key (kbd "<your_prefered_key_binding>") 'update-ctags)

;; You can also execute the function when saving a file with the following::
(add-hook 'after-save-hook 'update-ctags)

;; Search and compile
(global-set-key (kbd "<your_prefered_key_binding>") 'search-compile)

```