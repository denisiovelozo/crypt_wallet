namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
    
      show_spinner("Apagando DB...") do
     %x(rails db:drop)
    end

      show_spinner("Criando DB...") do
      %x(rails db:create)
     end

     show_spinner("Migrando DB...") do
      %x(rails db:migrate)
     end

     show_spinner("Populando DB...") do
      %x(rails db:seed)
     end
 
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end
  
  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
