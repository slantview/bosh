# Copyright (c) 2009-2012 VMware, Inc.
require 'bosh_agent/platform/linux'

module Bosh::Agent
  class Platform::Linux::Password
    USERS = ['root', BOSH_APP_USER]

    # Update passwords
    def update(settings)
      password = settings.fetch('env', {}).fetch('bosh', {})['password']

      # TODO - also support user/password hash override
      if password
        USERS.each { |user| update_password(user, password) }
      end
    end

    protected
    # Actually update password
    def update_password(user, encrypted_password)
      Bosh::Exec.sh "usermod -p '#{encrypted_password}' #{user} 2>%"
    end
  end
end
