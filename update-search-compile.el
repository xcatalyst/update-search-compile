;;; update-search-compile.el ---  emacs utility functions to automate compiling and updating TAG files

;; MIT License

;; Copyright (c) 2023 Çağan Korkmaz

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(if (eq system-type 'windows-nt)
    (defun search-compile ()
      "Recursively search for build.bat and compile"
      (interactive)
      (when (locate-dominating-file default-directory "build.bat")
	(with-temp-buffer
	  (cd (locate-dominating-file default-directory "build.bat"))
	  (compile "build.bat")))))

(if (not (eq system-type 'windows-nt))
    (defun search-compile ()
      "Recursively search for build.bat and compile"
      (interactive)
      (if (locate-dominating-file default-directory "build.sh")
	  (with-temp-buffer
	    (cd (locate-dominating-file default-directory "build.sh"))
	    (compile "./build.sh"))
	(if(locate-dominating-file default-directory "Makefile")
	  (with-temp-buffer
	    (cd (locate-dominating-file default-directory "Makefile"))
	    (compile "make -k"))))))

(if (not (eq system-type 'windows-nt))
    (defun update-ctags ()
      (interactive)
      "Recursively search for TAG and update it"
      (when (locate-dominating-file default-directory "TAGS") ;
	(with-temp-buffer
	  (cd (locate-dominating-file default-directory "TAGS"))
	  (call-process-shell-command "ctags -e -R" nil 0)))))
