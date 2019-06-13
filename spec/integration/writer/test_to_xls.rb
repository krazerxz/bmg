require 'spec_helper'
require 'bmg/writer/to_xls'
module Bmg
  module Writer
    describe ToXLS do

      let(:data) {
        [
          { int: 1, string: "Hello 1", float: 27.6,  date: Date.parse("2019-01-08"),  datetime: DateTime.parse("2019-01-08T09:00:00") },
          { int: 2, string: "Hello 2", float: -27.6, date: Date.parse("2019-08-01"),  datetime: nil },
          { int: 3, string: "Hello 3", float: 0.0,   date: Date.parse("2019-12-31"),  datetime: DateTime.parse("2019-01-08T09:00:00+02:00") }
        ]
      }

      let(:relation) {
        Relation.new(data)
      }

      subject {
        relation.to_xls
      }

      it 'works' do
        expect(subject).to be_a(Spreadsheet::Workbook)
        subject.write(Path.dir/"output.xls")
      end

    end
  end
end
