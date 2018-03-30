require 'spec_helper'
module Bmg
  module Relation
    describe Spied do

      let(:base) {
        Relation.new [{a: 1}]
      }

      let(:spied) {
        base.spied(spy)
      }

      let(:spy) {
        ->(r){ puts r }
      }

      describe "algebra" do

        it 'forwards all algebra methods' do
          r = spied.restrict(a: 1)
          expect(r).to be_a(Spied)
          expect(r.operand).to be_a(Operator::Restrict)
          expect(predicate_of(r.operand)).to eql(Predicate.eq(a: 1))
        end

      end # algebra

      describe "each" do

        it 'calls the spy but keep eaching normally' do
          seen = nil
          spied = base.spied(->(r){
            seen = r
          })
          expect(spied.to_a).to eql(base.to_a)
          expect(seen).to be(spied)
        end

      end

    end
  end
end
