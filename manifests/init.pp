# Class: vision_personenpflege
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_personenpflege
#

class vision_personenpflege (

  String $mysql_personenpflege_database,
  String $mysql_personenpflege_user,
  String $mysql_personenpflege_password,
  String $redis_personenpflege_host,
  String $whitelist,
  Array[String] $environment = [],
  String $traefik_rule       = 'PathPrefix(`/personenpflege`)',
  String $personenpflege_tag = $facts['personenpflege_tag']

) {

  contain ::vision_mysql::mariadb

  contain vision_personenpflege::config
  contain vision_personenpflege::database
  contain vision_personenpflege::docker

}
