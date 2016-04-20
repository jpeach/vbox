# These packages really need to be installed before anything happens.
package {['nfs-utils']:
  ensure =>latest,
}

# Base ATS build dependencies.
package {[
    'gcc', 'gcc-c++', 'automake', 'autoconf', 'libtool', 'pkgconfig',
    'openssl-devel', 'tcl-devel', 'expat-devel', 'pcre-devel',
    'ncurses-devel', 'libaio-devel',
    'hwloc-devel', 'libcap-devel', 'bison', 'flex', 'make',
    'libcurl-devel', 'perl-ExtUtils-MakeMaker'
  ]:
  ensure => latest,
}

# development extras.
package {[
    'gdb', 'valgrind', 'git', 'curl', 'screen', 'ccache', 'tmux'
  ]:
  ensure => latest,
}
