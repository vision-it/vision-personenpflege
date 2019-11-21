# Class: vision_personenpflege::config
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_personenpflege::config
#

class vision_personenpflege::config (

) {

  contain ::vision_shipit::user

  vision_shipit::inotify { 'personenpflege_tag':
    group   => 'shipit',
    require => Class['::vision_shipit::user'],
  }

  file {
    [
      '/vision/data/personenpflege',
      '/vision/data/personenpflege/storage',
      '/vision/data/personenpflege/storage/logs',
      '/vision/data/personenpflege/storage/framework',
      '/vision/data/personenpflege/storage/app',
    ]:
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }

}
