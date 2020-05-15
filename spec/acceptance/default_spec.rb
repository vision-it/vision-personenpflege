require 'spec_helper_acceptance'

describe 'vision_personenpflege' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE
        file { ['/vision', '/vision/data/', '/vision/data/swarm']:
          ensure => directory,
        }
        group { 'docker':
          ensure => present,
        }

        # mock classes
        class vision_personenpflege::database () {}
        class vision_mysql::mariadb () {}
        class vision_gluster::node () {}

        class vision_shipit::user () {}
        define vision_shipit::inotify (
         String $group,
        ) {}

        class { 'vision_personenpflege': }
      FILE

      apply_manifest(pp, catch_failures: true)
    end
  end

  context 'files provisioned' do
    describe file('/vision/data/personenpflege/storage') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'www-data' }
    end

    describe file('/vision/data/swarm/personenpflege.yaml') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'managed by Puppet' }
      it { is_expected.to contain 'image: registry.gitlab.cc-asp.fraunhofer.de:4567/vision-it/application/personenpflege@latest' }
      it { is_expected.to contain '/vision/data/personenpflege/storage/app:/var/www/html/storage/app' }
      it { is_expected.to contain 'personenpflege' }
      it { is_expected.to contain 'DB_SOCKET=/var/run/mysqld/mysqld.sock' }
      it { is_expected.to contain 'DB_DATABASE=personenpflege' }
      it { is_expected.to contain 'DB_USERNAME=userpers' }
      it { is_expected.to contain 'DB_PASSWORD=foobar' }
      it { is_expected.to contain 'FOO=BAR' }
      it { is_expected.to contain 'traefik.http.routers.personenpflege.rule' }
      it { is_expected.to contain 'Host(`example.com`) || PathPrefix(`/personenpflege`)' }
    end
  end
end
