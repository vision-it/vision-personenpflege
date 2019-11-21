require 'spec_helper'
require 'hiera'

describe 'vision_personenpflege' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :pre_condition do
        [
          'class vision_docker::swarm () {}',
          'class vision_mysql::mariadb () {}',
          'class vision_gluster::node () {}',
          'contain mysql::params'
        ]
      end
      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
