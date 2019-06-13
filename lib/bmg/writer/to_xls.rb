require 'spreadsheet'
module Bmg

  module Writer
    class ToXLS
      include Writer

      def initialize(relation)
        @relation = relation
      end
      attr_reader :relation

      def to_xls
        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet
        types.each_with_index do |type,i|
          format = format_for(type)
          sheet.column(i).default_format = format if format
        end
        sheet.row(0).replace(headers.map{|h| h.to_s })
        relation.each.each_with_index do |tuple,index|
          row = headers.map{|h| tuple[h] }
          sheet.row(1+index).replace(row)
        end
        book
      end

    private

      def headers
        @headers ||= first_tuple.keys
      end

      def types
        headers.map{|h| @first_tuple[h].class }
      end

      def first_tuple
        @first_tuple ||= relation.each.first || {}
      end

      def format_for(type)
        case type
        when Date then Spreadsheet::Format.new :number_format => 'YYYY-MM-DD'
        when Time, DateTime then Spreadsheet::Format.new :number_format => 'YYYY-MM-DD hh:mm:ss'
        end
      end

    end # ToXLSX
  end # module Writer

  module Relation

    def to_xls
      Writer::ToXLS.new(self).to_xls
    end

  end # class Relation

end # module Bmg
