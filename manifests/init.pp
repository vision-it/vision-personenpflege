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
  Array[String] $environment = [],
  String $traefik_rule = 'Host:personenpflege.vision.fraunhofer.de',

) {

  contain ::vision_mysql::mariadb

  contain vision_personenpflege::config
  contain vision_personenpflege::database
  contain vision_personenpflege::docker

}
