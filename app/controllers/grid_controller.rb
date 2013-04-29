class GridController < ApplicationController
  def index
    @shapes = Shape.all(:order => 'RANDOM()', :limit => 49)
    @row = current_row
    @cart = current_cart
  end

  def animals
    @shapes = Shape.where(shape_type:'animal') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def colours
    @shapes = Shape.where(shape_type:'colour') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def faces
    @shapes = Shape.where(shape_type:'faces') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def places
    @shapes = Shape.where(shape_type:'places') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def plants
    @shapes = Shape.where(shape_type:'plants') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def shapes
    @shapes = Shape.where(shape_type:'shapes') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def sky
    @shapes = Shape.where(shape_type:'sky') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def texture
    @shapes = Shape.where(shape_type:'texture') .order('RANDOM()') .limit(49)
    @row = current_row
    @cart = current_cart
  end

  def tshirt
    @shapes = Shape.all(:order => 'RANDOM()', :limit => 1)
    @row = current_row
    @cart = current_cart
  end

  def thanks
    @shapes = Shape.all
    @row = current_row
    @cart = current_cart
  end

  #def texture
  #  @shapes = Shape.where(shape_type:'texture')
  #end
end



