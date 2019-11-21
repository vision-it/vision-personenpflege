# Class: vision_personenpflege::database
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_personenpflege::database
#

class vision_personenpflege::database (


  String $mysql_personenpflege_database = $vision_personenpflege::mysql_personenpflege_database,
  String $mysql_personenpflege_password = $vision_personenpflege::mysql_personenpflege_password,
  String $mysql_personenpflege_user     = $vision_personenpflege::mysql_personenpflege_user,

) {

  ::mysql::db { $mysql_personenpflege_database:
    user     => $mysql_personenpflege_user,
    password => $mysql_personenpflege_password,
    host     => 'localhost',
    grant    => ['ALL'],
  }

}
