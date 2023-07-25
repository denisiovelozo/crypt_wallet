class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby!"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
