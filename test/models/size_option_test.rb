require 'test_helper'

class SizeOptionTest < ActiveSupport::TestCase
  describe '#valid?' do
    test 'size cannot be blank' do
      size_option = SizeOption.new(size: '')

      size_option.valid?

      assert_includes size_option.errors.details[:size], { error: :blank }
    end

    test 'size accepts valid enum values' do
      valid_sizes = %w[S M L XL]

      valid_sizes.each do |valid_size|
        size_option = SizeOption.new(size: valid_size)

        size_option.valid?

        assert_empty size_option.errors[:size]
      end
    end

    test 'size rejects invalid enum values' do
      invalid_size = 'invalid'

      assert_raises(ArgumentError, "'#{invalid_size}' is not a valid size") do
        SizeOption.new(size: invalid_size)
      end
    end
  end
end
