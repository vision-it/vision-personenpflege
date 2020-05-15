# Class: vision_personenpflege::docker
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_personenpflege::docker
#

class vision_personenpflege::docker (

  String $mysql_personenpflege_database = $vision_personenpflege::mysql_personenpflege_database,
  String $mysql_personenpflege_user     = $vision_personenpflege::mysql_personenpflege_user,
  String $mysql_personenpflege_password = $vision_personenpflege::mysql_personenpflege_password,
  Array[String] $environment            = $vision_personenpflege::environment,
  String $traefik_rule                  = $vision_personenpflege::traefik_rule,
  String $personenpflege_digest         = $vision_personenpflege::personenpflege_tag,

) {

  $docker_volumes = [
    '/var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock',
    '/vision/data/personenpflege/storage/logs:/var/www/html/storage/logs',
    '/vision/data/personenpflege/storage/framework:/var/www/html/storage/framework',
    '/vision/data/personenpflege/storage/app:/var/www/html/storage/app',
  ]

  $docker_environment = concat([
      'DB_SOCKET=/var/run/mysqld/mysqld.sock',
      "DB_DATABASE=${mysql_personenpflege_database}",
      "DB_USERNAME=${mysql_personenpflege_user}",
      "DB_PASSWORD=${mysql_personenpflege_password}",
  ], $environment)

  $docker_queue_environment = concat([
      'CONTAINER_ROLE=queue',
      'DB_SOCKET=/var/run/mysqld/mysqld.sock',
      "DB_DATABASE=${mysql_personenpflege_database}",
      "DB_USERNAME=${mysql_personenpflege_user}",
      "DB_PASSWORD=${mysql_personenpflege_password}",
  ], $environment)

  # Note: Container runs on port 8080
  $compose = {
    'version' => '3.7',
    'services' => {
      'personenpflege' => {
        'image'       => "registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/personenpflege@${personenpflege_digest}",
        'volumes'     => $docker_volumes,
        'environment' => $docker_environment,
        'deploy' => {
          'labels' => [
            'traefik.enable=true',
            'traefik.http.services.personenpflege.loadbalancer.server.port=8080',
            "traefik.http.routers.personenpflege.rule=${traefik_rule}",
            'traefik.http.routers.personenpflege.entrypoints=https',
            'traefik.http.routers.personenpflege.tls=true',
            'traefik.http.routers.personenpflege.middlewares=strip-personenpflege@docker',
            'traefik.http.middlewares.strip-personenpflege.stripprefix.prefixes=/personenpflege',
          ],
        },
      }
    }
  }

  vision_docker::to_compose { 'personenpflege':
    compose => $compose,
  }

}
