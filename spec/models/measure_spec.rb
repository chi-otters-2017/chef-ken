require 'rails_helper'

RSpec.describe Measure, type: :model do
  describe "amount of ingredient" do
    user_info = {name: 'test', }
    cat_info = {name: 'Desert'}
    rec_info = {title: 'banana bread',
                user_id: 1, time: 60, difficulty: 'Easy',
               directions: 'Make the banana bread' }
    let(:test_user){User.create!(user_info)}
    let(:test_cat){Category.create!(cat_info)}
    let(:test_recipe){test_cat.recipes.create!(rec_info)}

    it 'returns a string of the quant and units of its ingredient' do
      meas_info = { recipe_id: test_recipe.id,
                  ingredient: 'bananas',
                  quantity: '2',
                  units: 'Cup'}
      test_measure = Measure.create!(meas_info)
      expect(test_measure.pretty_print_ammount).to eq "2 Cups of bananas"
    end

    it 'recognizes a quanity greater than 1 and pluralizes its units' do
      meas_info = { recipe_id: test_recipe.id,
                  ingredient: 'flour',
                  quantity: '1 1/2',
                  units: 'Cup'}
      test_measure = Measure.create!(meas_info)
      expect(test_measure.pretty_print_ammount).to eq "1 1/2 Cups of flour"
    end

    it 'recognizes a string fractions and does NOT pluralize its units' do
      meas_info = { recipe_id: test_recipe.id,
                  ingredient: 'sugar',
                  quantity: '1/3',
                  units: 'Cup'}
      test_measure = Measure.create!(meas_info)
      expect(test_measure.pretty_print_ammount).to eq "1/3 Cup of sugar"
    end
  end
end
