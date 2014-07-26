require 'rails/generators/erb'
require 'rails/generators/resource_helpers'

module Rails
  class ShowlessScaffoldGenerator < Erb::Generators::Base
    include Rails::Generators::ResourceHelpers

    argument :attributes, type: :array, default: [], banner: "field:type field:type"

    def create_root_folder
      empty_directory File.join("app/views", controller_file_path)
    end

    def copy_view_files
      available_views.each do |view|
        formats.each do |format|
          filename = filename_with_extensions(view, format)
          template filename, File.join("app/views", controller_file_path, filename)
        end
      end
    end

    protected

    def available_views
      %w(index edit new _form)
    end
  end
end
