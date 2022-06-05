# frozen_string_literal: true

# module WagonFilling
module WagonFilling
  attr_reader :total, :occupied

  def free
    @total - @occupied
  end

  def occupy(loading_quantity)
    raise 'There is no free space!' if loading_quantity > free

    @occupied += loading_quantity
  end
end
