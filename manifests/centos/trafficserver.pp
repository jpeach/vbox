# These packages really need to be installed before anything happens.
package {['nfs-utils', 'redhat-lsb']:
  ensure =>latest
}

# Base ATS build dependencies.
package {[
    'gcc', 'gcc-c++', 'automake', 'autoconf', 'libtool', 'pkgconfig',
    'openssl-devel', 'tcl-devel', 'expat-devel', 'pcre-devel',
    'ncurses-devel', 'libaio-devel',
    'hwloc-devel', 'libcap-devel', 'bison', 'flex', 'make',
  ]:
  ensure => latest
}

package { $lsbmajdistrelease ? { '5' => 'curl-devel', default => 'libcurl-devel'}:
  ensure => latest
}

# RHEL/CentOS 5 doesn't have MakeMaker and I don't know what package to use instead :(
if $lsbmajdistrelease != '5' {
  package{'perl-ExtUtils-MakeMaker':
    ensure => latest
  }
}

# development extras.
package {[
    'gdb', 'valgrind', 'git', 'curl', 'screen'
  ]:
  ensure => latest,
}
