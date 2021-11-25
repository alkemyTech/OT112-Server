class OrganizationController < ApplicationController
  def public
    @organizations = Organization.all
  end
end
