class StaticPagesController < ApplicationController
 
  def about
    @latitude = '35.6585805'
    @longitude = '139.7454329'
    @address = '〒105-0011 東京都港区芝公園４丁目２-８'
  end

end
