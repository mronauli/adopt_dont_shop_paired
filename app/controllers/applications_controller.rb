class ApplicationsController < ApplicationController
  def new
  end

  def create
    flash[:success] = "Application for #{@sparky.name} and #{@peppo.name} submitted successfully!"
  end
end
