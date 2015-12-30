class Ckeditor::ApplicationController < ApplicationController
  layout 'ckeditor/application'

  before_filter :find_asset, :only => [:destroy]
  # before_filter :ckeditor_authorize!
  before_filter :authorize_resource

  protected

    def respond_with_asset(asset)
      _response = Ckeditor::AssetResponse.new(asset, request)
      _callback = ckeditor_before_create_asset(asset)

      if asset.save
        render _response.success(config.relative_url_root)
      else
        p _response.errors
        render _response.errors
      end
    end
end
