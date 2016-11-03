require 'csv'
require_relative './merchant'
require_relative './item'
require_relative './invoice'

module Importer

  def self.read_file(path_and_filename)
    CSV.open(path_and_filename,
             headers: true,
             header_converters: :symbol)
  end
end
